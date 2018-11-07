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
					select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,SAMACCOUNTNAME,CHANGEDATE,BIRTH_DATE,SSN | 
					Export-Csv -Delimiter $delimiter -NoTypeInformation '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'

					#if($both){
				if($PSBoundParameters.ContainsKey('both')){
					$tblSortedResults | 
						select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,SAMACCOUNTNAME,CHANGEDATE,BIRTH_DATE,SSN |
						Export-Csv -Delimiter "," -NoTypeInformation "I:\Continuity\Celaya\AD\New-AD-Account-Template-v2.csv"
				}
			}
			else{
				$tblSortedResults = $tblStaffResults
			}
			Write-Verbose "Query from staff table contains: $($tblStaffResults.Rows.Count) rows."

		}
		else{
			'"GIVENNAME","MIDDLENAME","SURNAME","SUFFIX","PREFERREDNAME","EMPLOYEEID","EXTENSIONATTRIBUTE1","SITE","DEPARTMENT","TITLE","EMPLOYEETYPE","EMPLOYEETYPE_RAW","SAMACCOUNTNAME","CHANGEDATE"' |
				Out-File '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'
		}
		
		if($PSBoundParameters.ContainsKey("UpdateFiles")){
            np++ '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'
		}

		#$objResults = $tblStaffResults | select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,SAMACCOUNTNAME | ConvertTo-Csv -NoTypeInformation
		$tmpFile = join-path $env:TEMP "$($(for($i = 0; $i -lt 6; $i++){$(0..9 | Get-Random)}) -join '').csv"
		$tblStaffResults | 
			select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,SAMACCOUNTNAME,CHANGEDATE,BIRTH_DATE,SSN | 
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