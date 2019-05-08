
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

    <#
    if($Global:ADHash.ContainsKey($EmployeeID)){
        $true
    }
    #>
    $ADHash = Import-Clixml (Join-Path "c:\Users\ac007" "ADHash.xml")
    if($ADHash.ContainsKey($EmployeeID)){
        $true
    }
    elseif($null -ne $sqlResults.EmployeeID){
        $strName = $("{0} {1}" -f $sqlResults.GivenName,$sqlResults.SURNAME)
        Try{
            $a = Get-ADUser -Filter {Anr -eq $strName} -ErrorAction Stop -Properties EmployeeID
            if(($a.EmployeeID -eq $EmployeeID)){
                $true
            }
            #elseif(($null -eq $a.EmployeeID) -and ($a.Givenname -eq $sqlResults.GIVENNAME) -and ($a.Surname -eq $sqlResults.SURNAME)){
            elseif((!([string]::IsNullOrEmpty($a.EmployeeID))) -and ($a.Givenname -eq $sqlResults.GIVENNAME) -and ($a.Surname -eq $sqlResults.SURNAME)){
                $true
            }
            else{
                $false
            }
        }
        Catch{
            $false
        }
    }
    else{
        $false
    }
}

