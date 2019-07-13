
<#
 # Implicit remoting module
 # generated on 2019-07-12 11:12:19 AM
 # by Export-PSSession cmdlet
 # Invoked with the following command line: Export-PSSession -Session $session_onPrem -OutputModule OnPremExchange -Force
 #>
        
@{
    GUID = 'ef54ee04-45e3-4bb4-8cb0-c2eee1b6ddb3'
    Description = 'Implicit remoting for http://sdoex01.scccd.net/powershell'
    ModuleToProcess = @('OnPremExchange.psm1')
    FormatsToProcess = @('OnPremExchange.format.ps1xml')

    ModuleVersion = '1.0'

    PrivateData = @{
        ImplicitRemoting = $true
    }
}
        