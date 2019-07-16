
#region :: Header
<#

NAME        : Test-ADAccountExist.ps1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Test whether and account exists in AD (SCCCD.NET) or not.
MODULES     : 
GLOBAL VARS : $Global:ADHash 
LAST RAN    : 12-13-2018
UPDATED     : 12-13-2018
VERSION     : 1.0



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE

#>
#endregion



Function Test-ADAccountExist{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][String]$EmployeeID
    )
    $sqlResults = Get-SQLWebAdvisorID -EmployeeID $EmployeeID
    if($sqlResults -eq "no results"){
        $sqlResults = Get-SQLWebAdvisorID -EmployeeID $EmployeeID -NoPosition
    }
    <#
    if($Global:ADHash.ContainsKey($EmployeeID)){
        $true
    }
    #>
    $ADHash = Import-Clixml (Join-Path "c:\Users\ac007" "ADHash.xml")
    if($ADHash.ContainsKey($EmployeeID)){
        Write-Warning "`$ADHash contains $($EmployeeID), $($Global:ADHash[$EmployeeID])"
        $true
    }
    elseif(![string]::IsNullOrEmpty($sqlResults.EmployeeID)){
        $strName = $("{0} {1}" -f $sqlResults.GivenName,$sqlResults.SURNAME)
        Try{
            $a = Get-ADUser -Filter {Anr -eq $strName} -ErrorAction Stop -Properties EmployeeID
            if(($a.EmployeeID -eq $EmployeeID)){
                Write-Warning "Found user by EmployeeID in AD, $($strName): $($a.SamAccountName) [$($EmployeeID)]"
                $true
            }#end  if (($a.EmployeeID -eq $EmployeeID))
            elseif((!([string]::IsNullOrEmpty($a.EmployeeID))) -and ($a.Givenname -eq $sqlResults.GIVENNAME) -and ($a.Surname -eq $sqlResults.SURNAME)){
                Write-Warning "Found user by name in AD and EmployeeID is blank, $($strName): $($a.SamAccountName)"
                $true
            }#end elseif((!([string]::IsNullOrEmpty($a.EmployeeID))) -and ($a.Givenname -eq $sqlResults.GIVENNAME) -and ($a.Surname -eq $sqlResults.SURNAME))
            else{
                $false
            }#end else (no match)
        }#end try
        Catch{
            Write-Warning "Available by Catch{}"
            $false
        }#end catch
    }#end elseif(![string]::IsNullOrEmpty($sqlResults.EmployeeID))
    else{
        Write-Warning "EmployeeID is blank and no match by name"
        $false
    }#end else()
}#end Function Test-ADAccountExist

<#
Import-Module SCCCDModules -Force
#>
