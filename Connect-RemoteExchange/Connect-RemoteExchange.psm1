<# 06/19/2019 #>

#region :: Header
<#

NAME..........: Connect-RemoteExchange.psm1
AUTHOR........: ac007
DESCRIPTION...: Connect to remote PowerShell session to Exchange on O365
CREATED.......: 06/19/2019
UPDATED.......: 06/19/2019
VERSION.......: 1.0


Ver  EntryDate   Editor  Description
---  ----------  ------  -----------
1.0  06/19/2019  ac007   Initial release

#>
#endregion :: Header

function Connect-RemoteExchange {
    [CmdletBinding(
        DefaultParameterSetName="OnPrem"
    )]
    [OutputType([System.Management.Automation.Runspaces.PSSession])]
    param (
        [Parameter(
            Mandatory=$true,
            Position=0,
            ParameterSetName="Default",
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="Credentials to connect to Exchange in O365 for SCCCD."
        )]
        [Parameter(
            ParameterSetName="Cloud"
        )]
        [Parameter(
            ParameterSetName="OnPrem"
        )]
        [Alias("Creds")]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credentials

        ,[Parameter(
            ParameterSetName="Cloud",
            HelpMessage="Connect to O365 or Cloud."
        )]
        [Alias("o365")]
        [Switch]
        $Cloud

        ,[Parameter(
            ParameterSetName="OnPrem",
            HelpMessage="Connect to Exchange on premisis."
        )]
        [Alias("Local")]
        [Switch]
        $OnPrem
    )
    
    begin {
    }
    
    process {

        Switch($PSCmdlet.ParameterSetName){
            'OnPrem'{
                $URL1 = "SDOEX01"
                $URL = $("http://{0}.scccd.net/powershell" -f $URL1)
                $splatSession = @{
                    Name = "Miscrosoft.Exchange.OnPremesis"
                    Credential = $Credentials
                    ConfigurationName = "Microsoft.Exchange"
                    ConnectionUri = $URL
                    Authentication = "Kerberos"
                    AllowRedirection = $true
                }
            }
            'Cloud'{
                $splatSession = @{
                    Name = "Miscrosoft.Exchange.o365"
                    Credential = $Credentials
                    ConfigurationName = "Microsoft.Exchange"
                    ConnectionUri = "https://outlook.office365.com/powershell-liveid/"
                    Authentication = "Basic"
                    AllowRedirection = $true
                }
            }
        }

        $Session = New-PSSession @splatSession
        #Import-PSSession $SessionO365 -DisableNameChecking
        
        $Session
    }
    
    end {
    }
}