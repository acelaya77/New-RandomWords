USE [DatatelInformation]

SELECT DISTINCT NE.[GIVENNAME]
    ,P.MIDDLE_NAME AS [MIDDLENAME]
    ,NE.[SURNAME]
    ,P.SUFFIX AS [SUFFIX]
    ,P.PREFERRED_NAME AS [PREFERREDNAME]
    ,NE.[EMPLOYEEID]
    ,NE.[EXTENSIONATTRIBUTE1]
    ,NE.[SITE]
    ,NE.[DEPARTMENT]
    ,NE.[TITLE]
    ,P.PERSON_EMAIL_ADDRESS
    ,CASE NE.EMPLOYEETYPE
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
    ,NE.EMPLOYEETYPE AS [EMPLOYEETYPE_RAW]
    --,'' AS [SAMACCOUNTNAME]
    ,P.PERSON_CHANGE_DATE AS [CHANGEDATE]
    ,P.SSN
    ,P.BIRTH_DATE
FROM [DatatelInformation].[dbo].[vwFindNewEmployee] AS NE WITH (NOLOCK)
LEFT JOIN [ODS_ST].dbo.S85_PERSON AS P WITH (NOLOCK) ON NE.EmployeeID = P.ID
    WHERE (
$($EmployeeIDs | Select-Object -First 1 | %{"`t`t`t   NE.[EMPLOYEEID] = `'$($_)`'"})
$($EmployeeIDs | Select-Object -Skip 1 | %{"`t`t`tOR NE.[EMPLOYEEID] = `'$($_)`'`r`n"})
    )

