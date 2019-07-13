function Connect-OnPrem{
    [cmdletbinding()]
    param(
        [parameter()]
        [string]$prefix = "eop"
    )#end param
    
    PROCESS{
        
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
            Write-Host -ForegroundColor DarkBlue -BackgroundColor White "`tConnecting to `"" -NoNewline
            Write-Host -ForegroundColor DarkGreen -BackgroundColor White "$Url_OnPrem`""
            Import-PSSession -Session $session_onPrem -CommandName * -FormatTypeName * -Prefix $prefix
        }#end if

        Export-PSSession -Session $session_onPrem -OutputModule OnPremExchange -Force
    }#end process{}

}#end function connect-OnPrem

function Disconnect-OnPrem{
    [cmdletbinding()]
    param(
        [parameter()]
        [string]$name = "SCCCD.Exchange.OnPrem"
    )#end param()
    
    process{
        write-verbose "Disconnecting from: $(Get-PSSession -name $name)"
        Get-PSSession -Name $name | Remove-PSSession
    }#end process
}#end function Disconnect-OnPrem

<#
Import-Module OnPremExchange -Force
#>
Set-PSBreakpoint -Script .\Modules\OnPremExchange\OnPremExchange.psm1 -Variable prefix,session_onPrem 
