USE ODS_ST

SELECT *
FROM (
    SELECT PERS.ID AS [EMPLOYEEID]
        --,PSTAT.PERSTAT_HRP_ID AS [PSTAT_EMPLOYEEID]
        ,PP.PERSON_PIN_USER_ID AS [EXTENSIONATTRIBUTE1]
        --,HRPER.HRPER_ID
        ,PERS.FIRST_NAME AS [GIVENNAME]
        ,PERS.MIDDLE_NAME AS [MIDDLENAME]
        ,PERS.LAST_NAME AS [SURNAME]
        ,PERS.SUFFIX AS [SUFFIX]
        ,PERS.PREFERRED_NAME AS [PREFERRED_NAME]
        ,HRPER.HRP_CHK_NAME AS [CHECK_NAME]
        ,CLAS.VAL_EXTERNAL_REPRESENTATION AS [CLASSIFICATION]
        ,POS.POS_TITLE AS [TITLE]
        ,POS.POS_DEPT AS [DEPT]
		,DEPTS.DEPTS_DESC AS [DEPARTMENT]
        ,POS.POS_LOCATION AS [SITE]
        ,POS.POS_TYPE AS [EMPLOYEETYPE_RAW]
        ,(
            SELECT VAL.VAL_EXTERNAL_REPRESENTATION
            FROM ODS_ST.dbo.S85_VALCODES AS VAL -- WITH (NOLOCK)
            WHERE VAL.VALCODE_ID = 'POSITION.TYPES'
                AND VAL.VAL_INTERNAL_CODE = POS.POS_TYPE
         ) AS [EMPLOYEETYPE]
        ,PERS.BIRTH_DATE AS [BIRTH_DATE]
        ,PERS.SSN
        ,PERS.PERSON_EMAIL_ADDRESS AS [EMAIL_ADDRESS]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_EMAIL_TYPES = 'DST'
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_DST]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_PREFERRED_EMAIL IS NOT NULL
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_PRIMARY]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_EMAIL_TYPES = 'PD'
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_PD]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_EMAIL_TYPES = 'SCH'
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_SCH]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_EMAIL_TYPES = 'SC1'
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_SC1]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_EMAIL_TYPES = 'INT'
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_INT]
        ,(
            SELECT TOP 1 EM.PERSON_EMAIL_ADDRESSES
            FROM ODS_ST.dbo.S85_PEOPLE_EMAIL AS EM -- WITH (NOLOCK)
            WHERE EM.PERSON_EMAIL_TYPES = 'LO'
                AND EM.ID = PSTAT.PERSTAT_HRP_ID
            ) AS [EMAIL_LO]
        ,PSTAT.PERSTAT_PRIMARY_POS_ID AS [POSITION_ID]
        ,PSTAT.PERSTAT_START_DATE AS [START_DATE]
        ,PSTAT.PERSTAT_STATUS AS [FUNDING]
        ,PSTAT.PERSTAT_PRIMARY_PERPOS_ID
        ,PSTAT.PERSTAT_END_DATE AS [PSTAT_EFF_TERM_DATE]
        ,PPOS.PERPOS_ID
        ,PPOS.PERPOS_POSITION_ID
        ,ISNULL(PPOS.PERPOS_END_DATE, GETDATE()) AS [PERPOS_END_DATE]
        ,DENSE_RANK() OVER (
            PARTITION BY PSTAT.PERSTAT_HRP_ID
            --ORDER BY ISNULL(PPOS.PERPOS_END_DATE, GETDATE()) DESC
            ORDER BY ISNULL(PSTAT.PERSTAT_END_DATE, GETDATE()) DESC
            ) AS [POS_RANK]
        ,POS.POS_END_DATE AS [POS_EFF_TERM_DATE]
    FROM [ODS_ST].[dbo].[S85_PERSON] AS PERS -- WITH (NOLOCK)
    LEFT JOIN [ODS_HR].[dbo].[S85_PERSTAT] AS PSTAT -- WITH (NOLOCK)
        ON PSTAT.PERSTAT_HRP_ID = PERS.ID
    INNER JOIN [ODS_HR].[dbo].[S85_PERPOS] AS PPOS -- WITH (NOLOCK)
        ON PPOS.PERPOS_ID = PSTAT.PERSTAT_PRIMARY_PERPOS_ID
    LEFT JOIN [ODS_HR].[dbo].[S85_POSITION] AS POS -- WITH (NOLOCK)
        ON POS.POSITION_ID = PPOS.PERPOS_POSITION_ID
	LEFT JOIN [ODS_HR].[dbo].[S85_DEPTS] AS DEPTS -- WITH (NOLOCK)
        ON POS.POS_DEPT = DEPTS.DEPTS_ID
    JOIN [ODS_HR].[dbo].[S85_HRPER] AS HRPER -- WITH (NOLOCK)
        ON HRPER.HRPER_ID = PPOS.PERPOS_HRP_ID
--	LEFT JOIN [ODS_ST].[dbo].[S85_PERSON] AS PERS WITH (NOLOCK) ON PERS.ID = PSTAT.PERSTAT_HRP_ID
    LEFT JOIN (
        SELECT VAL_INTERNAL_CODE
            ,VAL_EXTERNAL_REPRESENTATION
        FROM ODS_ST.dbo.S85_VALCODES --WITH (NOLOCK)
        WHERE COMPOUND_ID = 'POSITION.TYPES'
        ) AS CLAS ON CLAS.VAL_INTERNAL_CODE = POS.POS_TYPE
    LEFT JOIN ODS_ST.dbo.S85_PERSON_PIN AS PP -- WITH (NOLOCK)
        ON PP.PERSON_PIN_ID = PSTAT.PERSTAT_HRP_ID
    --WHERE PSTAT.PERSTAT_HRP_ID IS NOT NULL
    WHERE PERS.ID IS NOT NULL
    ) AS POSITION
WHERE POSITION.POS_RANK < 2
