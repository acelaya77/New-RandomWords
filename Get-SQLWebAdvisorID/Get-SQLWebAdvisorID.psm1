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
     [Parameter(ParameterSetName='Default'  ,Mandatory=$true )] [string[]] $EmployeeID
    ,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $UpdateFiles
    ,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $OutputQuery
    ,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $ShowQuery
    ,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $Both
    ,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [int] $SqlTimeOut=60
    ,[Parameter(ParameterSetName='Default'  ,Mandatory=$false)] [switch] $NoPosition
    ,[Parameter(ParameterSetName='Query'    ,Mandatory=$false)] [string] $Query
    ,[Parameter(ParameterSetName='InputFile',Mandatory=$true )] [string] $InputFile
    ,[Parameter(ParameterSetName='InputFile',Mandatory=$false)] [string] $Delimiter=","
    )

    Begin{
        $fileSQLQuery = Get-Item (Join-Path $PSScriptRoot "query.sql")

        Switch($InputFile){

            {($PSBoundParameters.ContainsKey('InputFile')) -and $InputFile}{
                $InputFile = Get-Item (Resolve-Path $InputFile)
                $EmployeeID = $(Import-Csv -Delimiter "," -Path $InputFile.FUllName).EmployeeIDs
                Write-Verbose $EmployeeID
                $strEmployeeIDs = [string]::Join(',',$($EmployeeID | ForEach-Object{"`'$_`'"}))
            }#end case
            {($PSBoundParameters.ContainsKey('InputFile')) -and (-not($InputFile))}{
                Do{
                    $InputFile = Read-Host -Prompt "Please give path to input file. (*.CSV): "
                    $InputFile = Get-Item (Resolve-Path $InputFile)
                }Until(Test-Path $InputFile.FUllName)
            }#end case
            {-not($PSBoundParameters.ContainsKey('InputFile'))}{
                $EmployeeID = $($EmployeeID.Replace("'","") -split ",")
                $strEmployeeIDs = [string]::join(',',$($EmployeeID | Foreach-Object{"`'$_`'"}))
                $strEmployeeIDs = $strEmployeeIDs.replace("''","'")
            }#end case
        }#end switch

        #$csvOutput = gci (join-path '\\sdofs1-08e\is$\Continuity\Celaya\AD\' 'WebAdvisorID.csv')
        $csvOutput = (join-path $env:USERPROFILE\Desktop 'WebAdvisorID.csv')
        [string]$Server = "sdodw1"
        [string]$StaffDatabase = "ODS_HR"
        $StaffConnection = New-Object System.Data.SqlClient.SqlConnection
        $StaffConnection.ConnectionString = "server='$server';database='$StaffDatabase';trusted_connection=true;"
        $StaffConnection.Open()
        Write-Verbose "`$strEmployeeIDs:"
        Write-Verbose $strEmployeeIDs

    }#end Begin{}

    Process{

#region :: Current query using [DatatelInformation].[dbo].[vwFindNewEmployee]
        
        Switch($PSBoundParameters.ContainsKey('NoPosition')){
            $true{
                $strQuery = @"
USE [ODS_HR]

SELECT   P.ID AS [EMPLOYEEID]
        ,P.FIRST_NAME AS [GIVENNAME]
        ,P.MIDDLE_NAME AS [MIDDLENAME]
        ,P.LAST_NAME AS [SURNAME]
        ,P.SUFFIX AS [SUFFIX]
        ,P.PREFERRED_NAME AS [PREFERREDNAME]
        ,PP.PERSON_PIN_USER_ID AS [EXTENSIONATTRIBUTE1]
        ,P.BIRTH_DATE
        ,P.SSN
FROM ODS_ST.dbo.S85_PERSON AS P  WITH (NOLOCK)
LEFT JOIN ODS_ST.dbo.S85_PERSON_PIN AS PP WITH (NOLOCK)
    ON PP.PERSON_PIN_ID = P.ID
WHERE (
        $($EmployeeID | select-Object -First 1 | Foreach-Object{"`t`t`t   P.ID  = `'$($_)`'"})
        $($EmployeeID | select-Object -Skip 1 | Foreach-Object{"`t`t`tOR P.ID  = `'$($_)`'`r`n"})
    )
ORDER BY P.ID


"@
            }
            Default{
                $strQuery = $("{0}`r`n{1}" -f $(Get-Content -Raw $fileSQLQuery),$(@"
    AND (
        $($EmployeeID | select-Object -First 1 | Foreach-Object{"`t`t`t   POSITION.EMPLOYEEID  = `'$($_)`'"})
        $($EmployeeID | select-Object -Skip 1 | Foreach-Object{"`t`t`tOR POSITION.EMPLOYEEID  = `'$($_)`'`r`n"})
        )
"@))
            }
        }


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
                    select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,PSTAT_EFF_TERM_DATE,POS_EFF_TERM_DATE,CHANGEDATE,BIRTH_DATE,SSN |
                    Export-Csv -Delimiter $delimiter -NoTypeInformation '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'

                    #if($both){
                if($PSBoundParameters.ContainsKey('both')){
                    $tblSortedResults |
                        select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,EMPLOYEETYPE_RAW,PSTAT_EFF_TERM_DATE,POS_EFF_TERM_DATE,CHANGEDATE,BIRTH_DATE,SSN |
                        Export-Csv -Delimiter "," -NoTypeInformation "I:\Continuity\Celaya\AD\New-AD-Account-Template-v2.csv"
                }
            }
            else{
                $tblSortedResults = $tblStaffResults
            }
            Write-Verbose "Query from staff table contains: $($tblStaffResults.Rows.Count) rows."

        }
        else{
            '"GIVENNAME","MIDDLENAME","SURNAME","SUFFIX","PREFERREDNAME","EMPLOYEEID","EXTENSIONATTRIBUTE1","SITE","DEPARTMENT","TITLE","TYPE","EMPLOYEETYPE","EMPLOYEETYPE_RAW","PSTAT_EFF_TERM_DATE","POS_EFF_TERM_DATE","CHANGE_DATE"' |
                Out-File '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'
        }

        if($PSBoundParameters.ContainsKey("UpdateFiles")){
            np++ '\\sdofs1-08e\is$\Continuity\Celaya\AD\query_WebAdvisorID.csv'
        }

        #$objResults = $tblStaffResults | select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,SAMACCOUNTNAME | ConvertTo-Csv -NoTypeInformation
        $tmpFile = join-path $env:TEMP "$($(for($i = 0; $i -lt 6; $i++){$(0..9 | Get-Random)}) -join '').csv"
        $tblStaffResults |
            select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,EMAIL_DST,EMAIL_PD,EMAIL_INT,EMAIL_SCH,EMAIL_SC1,SITE,DEPARTMENT,TITLE,EMPLOYEETYPE,SUPER_ID,EMPLOYEETYPE_RAW,PSTAT_EFF_TERM_DATE,POS_EFF_TERM_DATE,CHANGE_DATE,BIRTH_DATE,SSN |
            Export-Csv -NoTypeInformation -Delimiter "," $tmpFile
        $objResults = Import-Csv $tmpFile

        #np++ $tmpFile

        #Remove-Item $tmpFile -Confirm:$false -Force
        if($Global:ADHash.ContainsKey($EmployeeID)){
            $objResults | Add-Member -MemberType NoteProperty -Name 'sAMAccountName' -Value $($Global:ADHash[$objResults.EmployeeID])
        }else{
            $objResults | Add-Member -MemberType NoteProperty -Name 'sAMAccountName' -Value $null
        }
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

Remove-Module Get-SQLWebAdvisorID; Import-Module Get-SQLWebAdvisorID

#>
