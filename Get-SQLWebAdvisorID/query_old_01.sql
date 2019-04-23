SELECT DISTINCT PER.FIRST_NAME AS [GIVENNAME]
        ,PER.MIDDLE_NAME AS [MIDDLENAME]
        ,PER.LAST_NAME AS [SURNAME]
        ,PER.SUFFIX AS [SUFFIX]
        ,PER.PREFERRED_NAME AS [PREFERREDNAME]
        ,PER.ID AS [EMPLOYEEID]
        ,PP.PERSON_PIN_USER_ID AS [EXTENSIONATTRIBUTE1]
        ,ED.POS_LOCATION AS [SITE]
        ,ED.DEPARTMENT AS [DEPARTMENT]
        ,ED.POS_TITLE AS [TITLE]
        ,PER.PERSON_EMAIL_ADDRESS AS [EMAIL]
        ,EMAIL1.PERSON_EMAIL_ADDRESSES AS [EMAIL_DST]
        ,EMAIL2.PERSON_EMAIL_ADDRESSES AS [EMAIL_INT]
        ,EMAIL3.PERSON_EMAIL_ADDRESSES AS [EMAIL_SCH]
        ,EMAIL4.PERSON_EMAIL_ADDRESSES AS [EMAIL_SC1]
        ,EMAIL5.PERSON_EMAIL_ADDRESSES AS [EMAIL_PD]
        ,ED.EMPLOYMENT_TYPE AS [TYPE]
        ,CASE ED.CLASSIFICATION
            WHEN 'Certificated Contractual'		THEN 'Faculty'
            WHEN 'Certificated Hourly'			THEN 'Adjunct'
            WHEN 'Certificated Management'		THEN 'Management'
            WHEN 'Classified - Flexible'		THEN 'Classified'
            WHEN 'Classified Half-Time'			THEN 'Classified'
            WHEN 'Classified Regular'			THEN 'Classified'
            WHEN 'Classified - Seasonal'		THEN 'Classified'
            WHEN 'Classified - Regular 75%'		THEN 'Classified'
            WHEN 'Classified Non-Bargaining'	THEN 'Classified'
            WHEN 'Confidential'					THEN 'Classified'
            WHEN 'Classified Perm Part-Time'	THEN 'Classified'
            WHEN 'Classified Student Aide'		THEN 'Student'
            WHEN 'College Work Study'			THEN 'Student'
            WHEN 'Classified Mgmt Temporary'	THEN 'Management'
            WHEN 'Certificated Mgmt Tempora'	THEN 'Management'
            WHEN 'Personnel Commissioner'		THEN 'Management'
            WHEN 'Classified Management'		THEN 'Management'
            WHEN 'Board of Trustees'			THEN 'Board of Trustees'
         END AS [EMPLOYEETYPE]
        ,ED.SuperID AS [SUPER_ID]
        ,ED.CLASSIFICATION AS [EMPLOYEETYPE_RAW]
        ,PER.PERSON_CHANGE_DATE AS [CHANGE_DATE]
        ,ED.EFF_TERM_DATE AS [EFF_TERM_DATE]
        ,PER.SSN AS [SSN]
        ,PER.BIRTH_DATE AS [BIRTH_DATE]
FROM ODS_ST.dbo.S85_PERSON AS PER WITH (NOLOCK)
LEFT JOIN [ODS_ST].dbo.S85_PEOPLE_EMAIL AS EMAIL1 WITH (NOLOCK) ON EMAIL1.ID = PER.ID
    AND EMAIL1.PERSON_EMAIL_TYPES = 'DST'
LEFT JOIN [ODS_ST].dbo.S85_PEOPLE_EMAIL AS EMAIL2 WITH (NOLOCK) ON EMAIL2.ID = PER.ID
    AND EMAIL2.PERSON_EMAIL_TYPES = 'INT'
LEFT JOIN [ODS_ST].dbo.S85_PEOPLE_EMAIL AS EMAIL3 WITH (NOLOCK) ON EMAIL3.ID = PER.ID
    AND EMAIL3.PERSON_EMAIL_TYPES = 'SCH'
LEFT JOIN [ODS_ST].dbo.S85_PEOPLE_EMAIL AS EMAIL4 WITH (NOLOCK) ON EMAIL4.ID = PER.ID
    AND EMAIL4.PERSON_EMAIL_TYPES = 'SC1'
LEFT JOIN [ODS_ST].dbo.S85_PEOPLE_EMAIL AS EMAIL5 WITH (NOLOCK) ON EMAIL5.ID = PER.ID
    AND EMAIL5.PERSON_EMAIL_TYPES = 'PD'
LEFT JOIN (
            SELECT DISTINCT PSTAT.PERSTAT_HRP_ID AS ID
                    ,P.FIRST_NAME
                    ,P.LAST_NAME
                    ,P.PREFERRED_NAME
                    ,P.BIRTH_DATE
                    ,PSTAT.PERSTAT_PRIMARY_POS_ID AS [POSITION_ID]
                    ,PSTAT.PERSTAT_START_DATE AS [START_DATE]
                    ,PSTAT.PERSTAT_END_DATE AS [END_DATE]
                    ,PERSTAT_CHANGE_DATE AS [CHANGE_DATE]
                    ,POS.POS_TITLE
                    ,POS.POS_HRLY_OR_SLRY
                    ,POS.POS_TYPE
                    ,H.HRP_EFFECT_TERM_DATE AS [EFF_TERM_DATE]
                    ,CLAS.VAL_EXTERNAL_REPRESENTATION AS CLASSIFICATION
                    ,POS.POS_HRLY_OR_SLRY AS [EMPLOYMENT_TYPE]
                    ,CASE POS.POS_HRLY_OR_SLRY
                        WHEN 'S'
                            THEN 'Full-Time'
                        WHEN 'H'
                            THEN 'Part-Time'
                        ELSE 'Undefined'
                        END AS [SCHEDULE]
                    ,POS.POS_DEPT
                    ,POS.POS_LOCATION
                    ,(
                        SELECT LOC_DESC
                        FROM ODS_ST.dbo.S85_LOCATIONS WITH (NOLOCK)
                        WHERE LOCATIONS_ID = POS.POS_LOCATION
                        ) AS COLLEGE
                    ,D.DEPTS_DESC AS DEPARTMENT
                    ,POS.POS_DIVISION_IDX
                    ,POS.POS_RANK
                    ,ISNULL(H.HRP_USER6, AdjSup.SuperID) AS SuperID
                FROM ODS_HR.dbo.S85_PERSTAT AS PSTAT WITH (NOLOCK)
                LEFT JOIN ODS_HR.dbo.S85_POSITION AS POS WITH (NOLOCK) ON PSTAT.PERSTAT_PRIMARY_POS_ID = POS.POSITION_ID
                LEFT JOIN ODS_ST.dbo.S85_DEPTS AS D WITH (NOLOCK) ON D.DEPTS_ID = POS.POS_DEPT
                LEFT OUTER JOIN ODS_ST.dbo.S85_PERSON AS P WITH (NOLOCK) ON PSTAT.PERSTAT_HRP_ID = P.ID
                LEFT JOIN (
                    SELECT VAL_INTERNAL_CODE
                        ,VAL_EXTERNAL_REPRESENTATION
                    FROM ODS_ST.dbo.S85_VALCODES WITH (NOLOCK)
                    WHERE COMPOUND_ID = 'POSITION.TYPES'
                    ) AS CLAS ON CLAS.VAL_INTERNAL_CODE = POS.POS_TYPE
                LEFT JOIN ODS_HR.dbo.S85_HRPER AS H WITH (NOLOCK) ON H.[HRPER_ID] = PSTAT.PERSTAT_HRP_ID
                LEFT JOIN (
                    SELECT DISTINCT POSS.[POSITION_ID]
                        ,PS.PERSTAT_HRP_ID AS SuperID
                    FROM ODS_HR.[dbo].[S85_POSITION] AS POSS WITH (NOLOCK)
                    INNER JOIN ODS_HR.dbo.S85_PERSTAT AS PS WITH (NOLOCK) ON POSS.POS_SUPERVISOR_POS_ID = PS.PERSTAT_PRIMARY_POS_ID
                        AND PS.PERSTAT_END_DATE IS NULL
                    ) AS AdjSup ON AdjSup.POSITION_ID = PSTAT.PERSTAT_PRIMARY_POS_ID
                WHERE PSTAT.PERSTAT_HRP_ID IS NOT NULL
                    --AND PSTAT.PERSTAT_END_DATE IS NULL
                --ORDER BY ID
        ) AS ED ON PER.ID = ED.ID
    AND ED.END_DATE IS NULL
LEFT JOIN ODS_ST.dbo.S85_PERSON_PIN AS PP WITH (NOLOCK)
ON PP.PERSON_PIN_ID = PER.ID
WHERE (
    $($EmployeeIDs | Select-Object -First 1 | %{"`t`t`t   PER.ID = `'$($_)`'"})
    $($EmployeeIDs | Select-Object -Skip 1 | %{"`t`t`tOR PER.ID = `'$($_)`'`r`n"})
)
--ORDER BY PER.ID
