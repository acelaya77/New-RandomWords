#region     ========================== :: Header :: ========================= #
<#
    NAME..........:	SCCCDAccounts.psm1
    AUTHOR........:	Anthony J. Celaya
    DATE..........:	06-19-2018
    DESCRIPTION...:	Creates new mailbox in SCCCD for new account.
    NOTES.........:
    LAST_UPDATED..:	06-19-2018
    VERSION.......:	2.0
    HISTORY.......:
        VER DATE	EDITOR	DESCRIPTION
        1.0 01-20-2017	ac007	Initial Release.
        1.1 08-07-2017	ac007	Add Header.
        1.2 08-07-2017	ac007	Rename function and file to include approved verb
        2.0 06-19-2018	ac007	Rewrite of modules.
        3.0 11-06-2018  ac007   Complete rewrite.
#>
#endregion  ========================== :: Header :: ========================= #

. $PSScriptRoot\wip_functions.ps1
Export-ModuleMember New-SCCCDAccount
Export-ModuleMember Test-EmailAddressAvailable
