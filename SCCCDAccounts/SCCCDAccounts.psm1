#region     ========================== :: Header :: ========================= #
<#
    NAME..........:	SCCCDAccounts.psm1
    AUTHOR........:	Anthony J. Celaya
    DATE..........:	12-13-2018
    DESCRIPTION...:	Creates new mailbox in SCCCD for new account.
    NOTES.........:
    LAST_UPDATED..:	12-13-2018
    VERSION.......:	3.1
    HISTORY.......:
        VER DATE	EDITOR	DESCRIPTION
        1.0 01-20-2017	ac007	Initial Release.
        1.1 08-07-2017	ac007	Add Header.
        1.2 08-07-2017	ac007	Rename function and file to include approved verb
        2.0 06-19-2018	ac007	Rewrite of modules.
        3.0 11-06-2018  ac007   Complete rewrite.
        3.1 12-13-2018  ac007   Moving functions to separate files.
#>
#endregion  ========================== :: Header :: ========================= #

#. $PSScriptRoot\wip_functions.ps1
. $PSScriptRoot\New-SCCCDAccount.ps1
. $PSScriptRoot\Initialize-TrackItInformation.ps1
. $PSScriptRoot\Test-ExtensionAttribute1.ps1
. $PSScriptRoot\Test-ADAccountExist.ps1
. $PSScriptRoot\Test-EmailAddressAvailable.ps1
. $PSScriptRoot\Test-MissingAttributes.ps1
. $PSScriptRoot\Remove-FromTrackItExport.ps1
. $PSScriptRoot\Get-ExchangeDatabase.ps1
. $PSScriptRoot\Get-TrackItInfo.ps1
 
#Export-ModuleMember 
Export-ModuleMember New-SCCCDAccount
Export-ModuleMember Test-ADAccountExist
Export-ModuleMember Test-EmailAddressAvailable
Export-ModuleMember Initialize-TrackItInformation

<# Import-Module SCCCDAccounts -Force #>