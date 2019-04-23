
SELECT DISTINCT  ED.FIRST_NAME AS [Givenname]
                ,PERS.MIDDLE_NAME AS [MiddleName]
				,ED.LAST_NAME AS [Surname]
				,PERS.SUFFIX AS [Suffix]
				,PERS.PREFERRED_NAME AS [PreferredName]
                ,ED.ID AS [EmployeeID]
				,PP.PERSON_PIN_USER_ID AS [ExtensionAttribute1]
				,PER.HRP_CHK_NAME
				,EMAILDST.PERSON_EMAIL_ADDRESSES AS [EMAIL_DST]
				,EMAILINT.PERSON_EMAIL_ADDRESSES AS [EMAIL_INT]
				/*
				,EMAILPD.PERSON_EMAIL_ADDRESSES AS [EMAIL_PD]
				,EMAILSCH.PERSON_EMAIL_ADDRESSES AS [EMAIL_SCH]
				,EMAILSC1.PERSON_EMAIL_ADDRESSES AS [EMAIL_SC1]
				*/
				,ED.POS_TITLE AS [TITLE]
                ,ED.EMPLOYMENT_TYPE AS [Employment_Type]
				,ED.CLASSIFICATION AS [EMPLOYEETYPE_RAW]
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
                ,LOC.LOC_DESC AS [Loc_Desc]
				,ED.COLLEGE AS [COLLEGE]
                ,ED.POS_LOCATION AS [SITE]
                --,ED.POS_DEPT
                ,ED.DEPARTMENT
                ,ED.POSITION_ID
--                ,PER.HRP_PRI_CAMPUS_LOCATION
                ,ED.END_DATE AS [EFF_TERM_DATE]
				,PERS.BIRTH_DATE
				,PERS.SSN
--                ,ED.RK
    FROM (
            SELECT   ID
                    ,POSITION_ID
                    ,FIRST_NAME
                    ,LAST_NAME
                    ,PREFERRED_NAME
                    ,POS_TITLE
                    ,POS_LOCATION
                    ,EMPLOYMENT_TYPE
                    ,CLASSIFICATION
                    ,POS_DEPT
                    ,DEPARTMENT
                    ,[END_DATE]
                    ,COLLEGE
                    ,RANK() OVER (
                        PARTITION BY ID ORDER BY [END_DATE] DESC
                        ) AS RK
            FROM ODS_HR.HR.vwEmployeeDemographics WITH (NOLOCK)
        ) AS ED
    LEFT JOIN ODS_HR.dbo.S85_POSITION AS POS WITH (NOLOCK)
        ON ED.POSITION_ID = POS.POSITION_ID
    LEFT JOIN [ODS_HR].[dbo].[S85_HRPER] AS PER WITH (NOLOCK)
        ON ED.ID = PER.HRPER_ID
    LEFT JOIN ODS_ST.dbo.S85_PERSON AS PERS WITH (NOLOCK)
		ON PERS.ID = ED.ID
	/*
	LEFT JOIN ODS_ST.dbo.S85_PEOPLE_EMAIL AS EMAIL WITH (NOLOCK)
		ON EMAIL.ID = PER.HRPER_ID
	*/
	LEFT JOIN ODS_ST.dbo.S85_PEOPLE_EMAIL AS EMAILDST WITH (NOLOCK)
		ON EMAILDST.ID = ED.ID AND EMAILDST.PERSON_EMAIL_TYPES = 'DST'
	LEFT JOIN ODS_ST.dbo.S85_PEOPLE_EMAIL AS EMAILINT WITH (NOLOCK)
		ON EMAILINT.ID = ED.ID AND EMAILINT.PERSON_EMAIL_TYPES = 'INT'
	/*
	LEFT JOIN ODS_ST.dbo.S85_PEOPLE_EMAIL AS EMAILSCH WITH (NOLOCK)
		ON EMAILSCH.ID = ED.ID AND EMAILSCH.PERSON_EMAIL_TYPES = 'SCH'
	LEFT JOIN ODS_ST.dbo.S85_PEOPLE_EMAIL AS EMAILSC1 WITH (NOLOCK)
		ON EMAILSC1.ID = ED.ID AND EMAILSC1.PERSON_EMAIL_TYPES = 'SC1'
	LEFT JOIN ODS_ST.dbo.S85_PEOPLE_EMAIL AS EMAILPD WITH (NOLOCK)
		ON EMAILPD.ID = ED.ID AND EMAILPD.PERSON_EMAIL_TYPES = 'PD'
	*/
	LEFT JOIN ODS_ST.dbo.S85_PERSON_PIN AS PP WITH (NOLOCK)
		ON PP.PERSON_PIN_ID = PER.HRPER_ID
	LEFT JOIN [ODS_ST].dbo.S85_LOCATIONS AS LOC WITH (NOLOCK)
        ON PER.HRP_PRI_CAMPUS_LOCATION = LOC.LOCATIONS_ID
    WHERE ED.RK = 1
        --AND ED.END_DATE = GETDATE()
        --AND ED.END_DATE > DATEADD(d,-1,GETDATE())

        AND (
        $($EmployeeIDs | Select-Object -First 1 | Foreach-Object{"`t`t`t   ED.ID = `'$($_)`'"})
        $($EmployeeIDs | Select-Object -Skip 1 | ForEach-Object{"`t`t`tOR ED.ID = `'$($_)`'`r`n"})
    )
    ORDER BY EmployeeID
