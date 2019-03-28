Function Redo-Mailbox{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]$alias
    )

    Begin{Connect-Exchange}
    Process{
        $mailbox = Get-Mailbox $alias -DomainController $DomainController
        if([System.String]::IsNullOrEmpty($mailbox.Alias)){
            [bool]$procede = $false
        }
        else{
            [bool]$procede = $true
        }

        if($procede){
            $splat = @{
                Identity = $mailbox.alias
                ImapEnabled = $true
                PopEnabled = $true
                ActiveSyncEnabled = $true
                OWAEnabled = $true
                OWAforDevicesEnabled = $true
                MAPIEnabled = $true
                ECPEnabled = $true
                DomainController = $DomainController
            }
            Set-CASMailbox @splat
            Set-Mailbox -Identity $mailbox.alias -HiddenFromAddressListsEnabled:$false
        }
    }
    End{
        $date = get-date
        $logFileName = (Join-Path "\\sdofs1-08e\is$\Continuity\Celaya\AD\New_Accounts" $("{0:}-{1}-mailbox-rehydrate.log" -f $date.ToString('yyyyMMdd_HHmmss'),$mailbox.Alias))
        @"
$($date.ToString('MM-dd-yyyy HH:mm:ss'))
"@ | Set-Content -Encoding UTF8 -LiteralPath $logFileName
        Get-MailBoxInfo $alias | Out-String -Stream | Add-Content -Encoding UTF8 -LiteralPath $logFileName -PassThru
        Disconnect-Exchange
    }
}