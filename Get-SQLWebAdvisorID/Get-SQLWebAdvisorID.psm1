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
    [CmdletBinding(DefaultParameterSetName="EmployeeID")]
    Param(
     [Parameter(Position=0,
                ParameterSetName='EmployeeID',
                Mandatory=$true )] [string[]] $EmployeeID
    ,[Parameter(Position=0,
                ParameterSetName='Name',
                Mandatory=$true)][string]$Givenname
    ,[Parameter(Position=1,
                ParameterSetName='Name',
                Mandatory=$true)][string]$Surname
    ,[Parameter(Mandatory=$false)] [switch] $NoPosition
    ,[Parameter(Mandatory=$false)] [int] $SqlTimeOut=60
    ,[Parameter(Mandatory=$false)] [switch] $ShowQuery
    ,[Parameter(Mandatory=$false)] [switch] $OutputQuery
    )

    Begin{
        $fileSQLQuery = Get-Item (Join-Path $PSScriptRoot "query.sql")
        if($PSBoundParameters.ContainsKey('NoPosition')){
            $fileSQLQuery = Get-Item (Join-Path $PSScriptRoot "query_noposition.sql")
            Write-Warning "$($fileSQLQuery)"
        }#end if($PSBoundParameters.ContainsKey('NoPosition'))
    }#end Begin{}

    Process{

        $csvOutput = (join-path $env:USERPROFILE\Desktop 'WebAdvisorID.csv')
        [string]$Server = "sdodw1"
        [string]$StaffDatabase = "ODS_HR"
        $StaffConnection = New-Object System.Data.SqlClient.SqlConnection
        $StaffConnection.ConnectionString = "server='$server';database='$StaffDatabase';trusted_connection=true;"
        $StaffConnection.Open()


        #region :: Setup query string
        Switch($PSBoundParameters.ContainsKey("NoPosition")){
            $true{
                if($PSBoundParameters.ContainsKey('Givenname')){
                    $strAppendQuery = $("`r`n{0}" -f $(@"
        AND (
            $("`t`t`t PERSON.GIVENNAME = '{0}' AND PERSON.SURNAME = '{1}'" -f $Givenname,$Surname)
        )
"@))
                    [switch]$setEmployeeID = $true
                }#end if($PSBoundParameters.ContainsKey('Givenname'))
                else{
                    $strAppendQuery = $(@"
        AND (
            $($EmployeeID | select-Object -First 1 | Foreach-Object{"`t`t`t   PERSON.EMPLOYEEID  = `'$($_)`'"})
            $($EmployeeID | select-Object -Skip 1 | Foreach-Object{"`t`t`tOR PERSON.EMPLOYEEID  = `'$($_)`'`r`n"})
            )
"@)
                }#end else
            }#end $true($PSBoundParameters.ContainsKey("NoPosition"))
            Default{
                if($PSBoundParameters.ContainsKey('Givenname')){
                    $strAppendQuery = $("`r`n{0}" -f $(@"
        AND (
            $("`t`t`t POSITION.GIVENNAME = '{0}' AND POSITION.SURNAME = '{1}'" -f $Givenname,$Surname)
        )
"@))
                    [switch]$setEmployeeID = $true
                }#end if($PSBoundParameters.ContainsKey('Givenname'))
                else{
                    $strAppendQuery = $(@"
    AND (
        $($EmployeeID | select-Object -First 1 | Foreach-Object{"`t`t`t   POSITION.EMPLOYEEID  = `'$($_)`'"})
        $($EmployeeID | select-Object -Skip 1 | Foreach-Object{"`t`t`tOR POSITION.EMPLOYEEID  = `'$($_)`'`r`n"})
        )
"@)
                }#end else
            }#end Default($PSBoundParameters.ContainsKey("NoPosition"))
        }#end Switch($PSBoundParameters.ContainsKey("NoPosition"))
        
        $fullQuery = $("{0}`r`n{1}" -f $(Get-Content -Raw $fileSQLQuery),$strAppendQuery)
        #endregion
        
        #region :: Show Query
        if($PSBoundParameters.ContainsKey('showQuery')){
            Write-Host -ForegroundColor DarkGreen -BackgroundColor Gray "Showing query"
            Write-Host "`r`n"
            Write-Host -ForegroundColor DarkRed -BackgroundColor White $fullQuery
            Write-Host "`r`n"
            $fullQuery | clip
        }#end if($PSBoundParameters.ContainsKey('showQuery'))
        #endregion :: Show Query

        #region :: Configure SQL Server connection and perform query
        $StaffCommand = $StaffConnection.CreateCommand()
        $StaffCommand.CommandText = $fullQuery
        $StaffCommand.CommandTimeout = $SqlTimeOut
        $StaffResults = $StaffCommand.ExecuteReader()

        if($StaffResults.HasRows){
            $tblStaffResults = New-Object System.Data.DataTable
            try{
                $tblStaffResults.Load($StaffResults)
            }#end try
            catch{
                $ErrorMessage = $($_.Exception.Message)  #$_.Exception.Message

                Write-Verbose $ErrorMessage
            }#end catch
        }#end if($StaffResults.HasRows)
        else{
            Write-Warning "No Results"
        }#end else ($StaffResults.HasRows)
        
        $StaffConnection.Close()
        #endregion :: Configure SQL Server connection and perform query

        #region :: Configure output object
        $objResults = $tblStaffResults |
            select-object GIVENNAME,MIDDLENAME,SURNAME,SUFFIX,PREFERREDNAME,EMPLOYEEID,EXTENSIONATTRIBUTE1,EMAIL_DST,EMAIL_PD,EMAIL_INT,EMAIL_SCH,EMAIL_SC1,SITE,DEPT,DEPARTMENT,TITLE,EMPLOYEETYPE,SUPER_ID,EMPLOYEETYPE_RAW,PSTAT_EFF_TERM_DATE,POS_EFF_TERM_DATE,CHANGE_DATE,BIRTH_DATE,SSN

        if([string]::IsNullOrEmpty($objResults)){
            [bool]$noResults = $true
        }
        if($noResults){
            Write-Warning "noResults"
            break
        }

        $tblSortedResults = @()
        if($tblStaffResults.Rows.Count -gt 0){
            #if($UpdateFiles){
            $tblSortedResults = $tblStaffResults
            Write-Verbose "Query from staff table contains: $($tblStaffResults.Rows.Count) rows."

        }#end if

        if($setEmployeeID){
            $EmployeeID = $tblStaffResults.EMPLOYEEID
        }#end if

        #Remove-Item $tmpFile -Confirm:$false -Force
        if($Global:ADHash.ContainsKey($EmployeeID)){
            $objResults | Add-Member -MemberType NoteProperty -Name 'sAMAccountName' -Value $($Global:ADHash[$objResults.EmployeeID])
        }else{
            $objResults | Add-Member -MemberType NoteProperty -Name 'sAMAccountName' -Value $null
        }
        $objResults
        #endregion ::Configure output object

    }#end Process{}

    End{
        if($PSBoundParameters.ContainsKey('outputQuery')){
            $fileName = Join-Path $env:USERPROFILE\Desktop\Temp\ "$(get-date -f 'yyyyMMdd-HHmmss')_query.sql"
            $strQuery | Out-File $fileName
            Write-Verbose "Query output to `'$fileName`'"
        }
    }#end End{}

}#end Function Query-Staff
