Function Get-SqlEmpIDFromSSN{
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true,
                HelpMessage="Enter a valid SSN, xxx-xx-xxxx")]
    [ValidatePattern("\d{3}-\d{2}-\d{4}")]
    $ssn
)

#$ssn = '608-16-8910'

$query = @"
DECLARE @SSN AS Varchar(30)

SET @SSN = $("`'{0}`'" -f $ssn)

USE [DatatelInformation]

SELECT DISTINCT  NE.[EMPLOYEEID]
		,NE.[GIVENNAME]
		,P.MIDDLE_NAME
		,NE.[SURNAME]
		,P.SUFFIX AS [SUFFIX]
		,P.PREFERRED_NAME AS [PREFERREDNAME]
		,NE.[EXTENSIONATTRIBUTE1]
		,P.SSN
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
		--,'' AS [SAMACCOUNTNAME]
		,P.PERSON_CHANGE_DATE AS [ChangeDate]
		,P.PERSON_STATUS
		,P.S85_PERSON_EMAIL_ACTIVATE
		,P.[SOURCE]
		--,TheseIDs.POS_USER1
FROM [DatatelInformation].[dbo].[vwFindNewEmployee] AS NE WITH (NOLOCK)
LEFT JOIN [ODS_ST].dbo.S85_PERSON AS P WITH (NOLOCK) ON NE.EmployeeID = P.ID
WHERE P.SSN = @SSN
/*
JOIN (
	SELECT DISTINCT POS_USER1
	FROM [ODS_HR].[dbo].[S85_POSITION]
	  WHERE POS_USER1 IS NOT NULL
) AS TheseIDs ON TheseIDs.POS_USER1 = P.ID
*/
/*
WHERE [EMPLOYEEID] IN (
		 '0004794'
		,'0848008'
		,'0861882'
	)
*/
"@

#region :: SQL Server connection info
$server = 'sdodw1'
$database = 'DatatelInformation'
$conTemp = "Trusted_Connection=true;"
$conString = "server='$server';database='$database';trusted_connection=true;"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $conString
$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $query
$command.Connection = $connection
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$dataset = New-Object System.Data.DataSet
$SqlAdapter.Fill($dataset)
$connection.Close()
#endregion


if($dataset.Tables[0].Rows.Count -gt 0){
    $myData = $dataset.Tables[0] | ConvertTo-Csv -Delimiter "," -NoTypeInformation
    $myData = $myData | ConvertFrom-Csv -Delimiter ","
}

Return $myData
#$myData | fl
#$myData | get-member

<#
$dataset.Tables[0] | fl
$dataset | get-member
#>

}

<#
Try{Remove-Module Get-SqlEmpIdFromSSN -ErrorAction SilentlyContinue}
Finally{Import-Module Get-SqlEmpIDFromSSN}
#>