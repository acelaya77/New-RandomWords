
#region :: Header
<#

NAME        : Test-ExtensionAttribute1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Make call to Get-SQLWebADvisorID and return $true if it isn't blank, $false if it is.
MODULES     : Get-SQLWebAdvisorID
GLOBAL VARS : 
LAST RAN    : 12-13-2018
UPDATED     : 12-13-2018
VERSION     : 1.0



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 12-13-2017 ac007  INITIAL RELEASE

#>
#endregion




Function Test-ExtensionAttribute1{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][string]$EmployeeID
    )
    $sqlResults = Get-SQLWebAdvisorID -EmployeeIDs $EmployeeID
    if($null -eq $sqlResults.ExtensionAttribute1){
        $false
    }
    else{
        $true
    }
}
