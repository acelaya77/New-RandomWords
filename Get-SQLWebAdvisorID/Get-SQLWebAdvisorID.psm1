#region :: Header
<#
NAME..........:	Get-SQLWebAdvisorID.ps1
AUTHOR........:	Anthony J. Celaya
DATE..........:	03-02-2017
DESCRIPTION...:	Query SQL for WebAdvisorIDs and Title, Department info for new accounts.
NOTES.........:
LAST_UPDATED..:	05-29-2018
VERSION.......:	1.4
HISTORY.......:
	VER	DATE	EDITOR	DESCRIPTION
	1.0	03-02-2017	ac007	Initial Release.
	1.1	08-07-2017	ac007	Renamed Function.
	1.2	08-07-2016	ac007	Update/Clean some warnings.
	1.3	08-25-2017	ac007	Remove old queries & old remarks.
	1.4	05-29-2018	ac007	Rewrite query to use '=' rather than 'IN' for each employeeID.
#>
#endregion :: Header

Function Get-SQLWebAdvisorID{
	[CmdletBinding()]
	Param(
	 [Parameter(ParameterSetName='Default'  ,Mandatory=$true )] [string[]] $EmployeeIDs
	,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $UpdateFiles
	,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $OutputQuery
	,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $ShowQuery
	,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $Both
	,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [int] $SqlTimeOut=60
	,[Parameter(ParameterSetName='Query'    ,Mandatory=$false)] [string] $Query
	,[Parameter(ParameterSetName='InputFile',Mandatory=$true )] [string] $InputFile
	,[Parameter(ParameterSetName='InputFile',Mandatory=$false)] [string] $Delimiter=","
	)

	Begin{

		Switch($InputFile){
			
            {($PSBoundParameters.ContainsKey('InputFile')) -and $InputFile}{
				$InputFile = Get-Item (Resolve-Path $InputFile)
                $EmployeeIDs = $(Import-Csv -Delimiter "," -Path $InputFile.FUllName).EmployeeIDs
				Write-Verbose $EmployeeIDs
				$strEmployeeIDs = [string]::Join(',',$($EmployeeIDs | ForEach-Object{"`'$_`'"}))
			}#end case
			{($PSBoundParameters.ContainsKey('InputFile')) -and (-not($InputFile))}{
				Do{
					$InputFile = Read-Host -Prompt "Please give path to input file. (*.CSV): "
                    $InputFile = Get-Item (Resolve-Path $InputFile)
				}Until(Test-Path $InputFile.FUllName)
			}#end case
			{-not($PSBoundParameters.ContainsKey('InputFile'))}{
				$EmployeeIDs = $($EmployeeIDs.Replace("'","") -split ",")
				$strEmployeeIDs = [string]::join(',',$($EmployeeIDs | Foreach-Object{"`'$_`'"}))
				$strEmployeeIDs = $strEmployeeIDs.replace("''","'")                
			}#end case
		}#end switch

		#$csvOutput = gci (join-path '\\sdofs1-08e\is$\Continuity\Celaya\AD\' 'WebAdvisorID.csv')
		$csvOutput = (join-path $env:USERPROFILE\Desktop 'WebAdvisorID.csv')
		[string]$Server = "sdodw1"
		[string]$StaffDatabase = "DatatelInformation"
		$StaffConnection = New-Object System.Data.SqlClient.SqlConnection
		$StaffConnection.ConnectionString = "server='$server';database='$StaffDatabase';trusted_connection=true;"
		$StaffConnection.Open()
		Write-Verbose "`$strEmployeeIDs:"
		Write-Verbose $strEmployeeIDs

	}#end Begin{}

	Process{

#region :: Current query using [DatatelInformation].[dbo].[vwFindNewEmployee]
#<#
        $strQuery = @"
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
INNER JOIN (
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
				INNER JOIN ODS_HR.dbo.S85_POSITION AS POS WITH (NOLOCK) ON PSTAT.PERSTAT_PRIMARY_POS_ID = POS.POSITION_ID
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
					) AS AdjSup ON AdjSup.POSITION_ID = PSTAT.PERSTAT_PRIMARY_POS_ID
				WHERE PSTAT.PERSTAT_HRP_ID IS NOT NULL
					AND PSTAT.PERSTAT_END_DATE IS NULL
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
"@
#>
<#

        $strQuery = @"

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
	,'' AS [SAMACCOUNTNAME]
    ,P.PERSON_CHANGE_DATE AS [CHANGEDATE]
    ,P.SSN
    ,P.BIRTH_DATE
FROM [DatatelInformation].[dbo].[vwFindNewEmployee] AS NE WITH (NOLOCK)
LEFT JOIN [ODS_ST].dbo.S85_PERSON AS P WITH (NOLOCK) ON NE.EmployeeID = P.ID
	WHERE (
$($EmployeeIDs | Select-Object -First 1 | %{"`t`t`t   NE.[EMPLOYEEID] = `'$($_)`'"})
$($EmployeeIDs | Select-Object -Skip 1 | %{"`t`t`tOR NE.[EMPLOYEEID] = `'$($_)`'`r`n"})
	)

"@
#>
#endregion

		$StaffCommand = $StaffConnection.CreateCommand()

		write-verbose "IDs:"
		Write-Verbose $strEmployeeIDs

		#region :: THIS
		if($PSBoundParameters.ContainsKey('showQuery')){
			Write-Host -ForegroundColor DarkGreen -BackgroundColor Gray "Showing query"
			Write-Host "`r`n"
			Write-Host -ForegroundColor DarkRed -BackgroundColor White $strQuery
			Write-Host "`r`n"
		}
		#endregion :: THIS

		$StaffCommand.CommandText = $strQuery
		$StaffCommand.CommandTimeout = $SqlTimeOut

		$StaffResults = $StaffCommand.ExecuteReader()

		if($StaffResults.HasRows){
			$tblStaffResults = New-Object System.Data.DataTable
			try{
				$tblStaffResults.Load($StaffResults)
			}
			catch{
				$ErrorMessage = $($_.Exception.Message)  #$_.Exception.Message

				Write-Verbose $ErrorMessage
			}

		}

		$StaffConnection.Close()

		$tblSortedResults = @()
		if($tblStaffResults.Rows.Count -gt 0){
			#if($UpdateFiles){
			if($PSBoundParameters.ContainsKey('UpdateFiles')){
				$tblStaffResults | Export-Csv -Delimiter "," -NoTypeInformation $csvOutput

				for($i=0;$i -lt $strEmployeeIDs.Split(',').count;$i++){
					#$tblSortedResults += $tblStaffResults | ?{$_.EmployeeID -eq $strEmployeeIDs.Split(',')[$i]}
					$id = $($strEmployeeIDs.Split(',')[$i]).replace("'",'')
					$tblSortedResults += $tblStaffResults.Select("EmployeeID = `'$id`'")
				}

				$tblSortedResults | 
					select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,CHANGEDATE,BIRTH_DATE,SSN | 
					Export-Csv -Delimiter $delimiter -NoTypeInformation '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'

					#if($both){
				if($PSBoundParameters.ContainsKey('both')){
					$tblSortedResults | 
						select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,CHANGEDATE,BIRTH_DATE,SSN |
						Export-Csv -Delimiter "," -NoTypeInformation "I:\Continuity\Celaya\AD\New-AD-Account-Template-v2.csv"
				}
			}
			else{
				$tblSortedResults = $tblStaffResults
			}
			Write-Verbose "Query from staff table contains: $($tblStaffResults.Rows.Count) rows."

		}
		else{
			'"GIVENNAME","MIDDLENAME","SURNAME","SUFFIX","PREFERREDNAME","EMPLOYEEID","EXTENSIONATTRIBUTE1","SITE","DEPARTMENT","TITLE","TYPE","EMPLOYEETYPE","EMPLOYEETYPE_RAW","CHANGE_DATE"' |
				Out-File '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'
		}
		
		if($PSBoundParameters.ContainsKey("UpdateFiles")){
            np++ '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'
		}

		#$objResults = $tblStaffResults | select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,SAMACCOUNTNAME | ConvertTo-Csv -NoTypeInformation
		$tmpFile = join-path $env:TEMP "$($(for($i = 0; $i -lt 6; $i++){$(0..9 | Get-Random)}) -join '').csv"
		$tblStaffResults | 
			select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,EMAIL_DST,EMAIL_PD,EMAIL_INT,EMAIL_SCH,EMAIL_SC1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,SUPER_ID,EMPLOYEETYPE_RAW,CHANGE_DATE,BIRTH_DATE,SSN | 
			Export-Csv -NoTypeInformation -Delimiter "," $tmpFile
		$objResults = Import-Csv $tmpFile
		
		#np++ $tmpFile

		#Remove-Item $tmpFile -Confirm:$false -Force
		$objResults
	}#end Process{}

	End{
		if($PSBoundParameters.ContainsKey('outputQuery')){
			$fileName = Join-Path $env:USERPROFILE\Desktop\Temp\ "$(get-date -f 'yyyyMMdd-HHmmss')_query.txt"
			$strQuery | Out-File $fileName
			Write-Verbose "Query output to `'$fileName`'"
		}
	}#end End{}

}#end Function Query-Staff

<#

Remove-Module Get-SQLWebAdvisorID
Import-Module Get-SQLWebAdvisorID

#>