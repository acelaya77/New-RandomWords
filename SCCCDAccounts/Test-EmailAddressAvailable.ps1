
#region :: Header
<#

NAME        : Test-EmailAddressAvailable
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Test for email address availability.
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 12-13-2018 
UPDATED     : 12-13-2018
VERSION     : 1.0



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 12-13-2018 ac007  INITIAL RELEASE

#>
#endregion


Function Test-EmailAddressAvailable{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][string]$EmailAddress
    )
    Connect-Exchange
    #$sqlResults = Get-SQLWebAdvisorID -EmployeeIDs $EmployeeID
    <#
    $name = $("{0} {1}" -f $sqlResults.Givenname,$sqlResults.Surname)
    $smtp = $("{0}.{1}" -f $sqlResults.Givenname.Tolower().Replace(' ','-'),$sqlResults.Surname.ToLower().Replace(' ','-'))
    $givenname = $("{0}" -f $sqlResults.Givenname,$sqlResults.Surname)
    $surname = $("{1}" -f $sqlResults.Givenname,$sqlResults.Surname)
    #>
    <#
    Try{
        #$mailBox = Get-Mailbox -Filter {(EmailAddresses -like "smtp:$($smtp)*")} -ErrorAction Stop -DomainController SDODC1-08e
    }
    Catch{
        $true
    }
    #>
    $mailBox = Get-Mailbox "$($EmailAddress)" -DomainController $DomainController -ErrorAction SilentlyContinue
    if($null -ne $mailBox.PrimarySMTPAddress){
        [bool]$Available = $false
    }
    elseif($mailBox.PrimarySMTPAddress -like ""){
        [bool]$Available = $true
    }
    elseif($mailBox.EmailAddresses -like "$($EmailAddress)*"){
        [bool]$Available = $false
    }
    else{
        [bool]$Available = $true
    }
    Return $Available
}

