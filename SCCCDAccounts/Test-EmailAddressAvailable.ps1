
#region :: Header
<#

NAME        : Test-EmailAddressAvailable
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Test for email address availability.
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 07-09-2019 
UPDATED     : 07-09-2019
VERSION     : 1.1



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 12-13-2018 ac007  INITIAL RELEASE
1.1 07-09-2019 ac007  Discontinue use of Connect-Exchange

#>
#endregion


Function Test-EmailAddressAvailable{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][string]$EmailAddress
    )

    
    if(!(Get-PSSession).ComputerName -eq 'sdoex01.scccd.net'){
        $Url_OnPrem = $("http://{0}.scccd.net/powershell" -f "SDOEX01")

        $splat_onprem = @{
            ConfigurationName = 'Microsoft.Exchange'
            ConnectionUri = $Url_OnPrem
            Authentication = 'Kerberos'
            AllowRedirection = $true
            Name = "SCCCD.Exchange.OnPrem"
        }
        $session_onPrem = New-PSSession @splat_onprem
        Import-PSSession -Session $session_onPrem -CommandName * -FormatTypeName * -Prefix "onPrem"
        }#end if


    $mailBox = Get-onPremMailbox "$($EmailAddress)" -DomainController $DomainController -ErrorAction SilentlyContinue
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

