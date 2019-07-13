
<#
 # Implicit remoting module
 # generated on 2019-07-12 11:12:19 AM
 # by Export-PSSession cmdlet
 # Invoked with the following command line: Export-PSSession -Session $session_onPrem -OutputModule OnPremExchange -Force
 #>
        
param(
    <# Optional parameter that can be used to specify the session on which this proxy module works #>    
    [System.Management.Automation.Runspaces.PSSession] $PSSessionOverride,
    [System.Management.Automation.Remoting.PSSessionOption] $PSSessionOptionOverride
)

$script:__psImplicitRemoting_versionOfScriptGenerator = [Microsoft.PowerShell.Commands.ExportPSSessionCommand, Microsoft.PowerShell.Commands.Utility, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]::VersionOfScriptGenerator
if ($script:__psImplicitRemoting_versionOfScriptGenerator.Major -ne 1.0)
{
    throw 'The module cannot be loaded because it has been generated with an incompatible version of the Export-PSSession cmdlet. Generate the module with the Export-PSSession cmdlet from the current session, and try loading the module again.'
}


$script:WriteHost = $executionContext.InvokeCommand.GetCommand('Write-Host', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:WriteWarning = $executionContext.InvokeCommand.GetCommand('Write-Warning', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:WriteInformation = $executionContext.InvokeCommand.GetCommand('Write-Information', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:GetPSSession = $executionContext.InvokeCommand.GetCommand('Get-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:NewPSSession = $executionContext.InvokeCommand.GetCommand('New-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:ConnectPSSession = $executionContext.InvokeCommand.GetCommand('Connect-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:NewObject = $executionContext.InvokeCommand.GetCommand('New-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:RemovePSSession = $executionContext.InvokeCommand.GetCommand('Remove-PSSession', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:InvokeCommand = $executionContext.InvokeCommand.GetCommand('Invoke-Command', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:SetItem = $executionContext.InvokeCommand.GetCommand('Set-Item', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:ImportCliXml = $executionContext.InvokeCommand.GetCommand('Import-CliXml', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:NewPSSessionOption = $executionContext.InvokeCommand.GetCommand('New-PSSessionOption', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:JoinPath = $executionContext.InvokeCommand.GetCommand('Join-Path', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:ExportModuleMember = $executionContext.InvokeCommand.GetCommand('Export-ModuleMember', [System.Management.Automation.CommandTypes]::Cmdlet)
$script:SetAlias = $executionContext.InvokeCommand.GetCommand('Set-Alias', [System.Management.Automation.CommandTypes]::Cmdlet)

$script:MyModule = $MyInvocation.MyCommand.ScriptBlock.Module
        
##############################################################################

function Write-PSImplicitRemotingMessage
{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $message)
        
    try { & $script:WriteHost -Object $message -ErrorAction SilentlyContinue } catch { }
}

function Get-PSImplicitRemotingSessionOption
{
    if ($PSSessionOptionOverride -ne $null)
    {
        return $PSSessionOptionOverride
    }
    else
    {
        return $(& $script:NewPSSessionOption -Culture 'en-US' -UICulture 'en-US' -CancelTimeOut 60000 -IdleTimeOut 900000 -OpenTimeOut 180000 -OperationTimeOut 180000 -MaximumReceivedObjectSize 209715200 -MaximumRedirection 5 -ProxyAccessType None -ProxyAuthentication Negotiate )
    }
}

$script:PSSession = $null

function Get-PSImplicitRemotingModuleName { $myInvocation.MyCommand.ScriptBlock.File }

function Set-PSImplicitRemotingSession
{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [AllowNull()]
        [Management.Automation.Runspaces.PSSession] 
        $PSSession, 

        [Parameter(Mandatory = $false, Position = 1)]
        [bool] $createdByModule = $false)

    if ($PSSession -ne $null)
    {
        $script:PSSession = $PSSession

        if ($createdByModule -and ($script:PSSession -ne $null))
        {
            $moduleName = Get-PSImplicitRemotingModuleName 
            $script:PSSession.Name = 'Session for implicit remoting module at {0}' -f $moduleName
            
            $oldCleanUpScript = $script:MyModule.OnRemove
            $removePSSessionCommand = $script:RemovePSSession
            $script:MyModule.OnRemove = { 
                & $removePSSessionCommand -Session $PSSession -ErrorAction SilentlyContinue
                if ($oldCleanUpScript)
                {
                    & $oldCleanUpScript $args
                }
            }.GetNewClosure()
        }
    }
}

if ($PSSessionOverride) { Set-PSImplicitRemotingSession $PSSessionOverride }

function Get-PSImplicitRemotingSession
{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string] 
        $commandName
    )

    $savedImplicitRemotingHash = '30723460'

    if (($script:PSSession -eq $null) -or ($script:PSSession.Runspace.RunspaceStateInfo.State -ne 'Opened'))
    {
        Set-PSImplicitRemotingSession `
            (& $script:GetPSSession `
                -InstanceId 18ba98c2-b718-4af2-84bb-9e060afa581f `
                -ErrorAction SilentlyContinue )
    }
    if (($script:PSSession -ne $null) -and ($script:PSSession.Runspace.RunspaceStateInfo.State -eq 'Disconnected'))
    {
        # If we are handed a disconnected session, try re-connecting it before creating a new session.
        Set-PSImplicitRemotingSession `
            (& $script:ConnectPSSession `
                -Session $script:PSSession `
                -ErrorAction SilentlyContinue)
    }
    if (($script:PSSession -eq $null) -or ($script:PSSession.Runspace.RunspaceStateInfo.State -ne 'Opened'))
    {
        Write-PSImplicitRemotingMessage ('Creating a new session for implicit remoting of "{0}" command...' -f $commandName)

        Set-PSImplicitRemotingSession `
            -CreatedByModule $true `
            -PSSession ( 
            $( 
                & $script:NewPSSession `
                    -connectionUri 'http://sdoex01.scccd.net/powershell' -ConfigurationName 'Microsoft.Exchange' `
                    -SessionOption (Get-PSImplicitRemotingSessionOption) `
                     `
                     `
                    -Authentication Kerberos `
                    -AllowRedirection `
            )
 )

        if ($savedImplicitRemotingHash -ne '')
        {
            $newImplicitRemotingHash = [string]($script:PSSession.ApplicationPrivateData.ImplicitRemoting.Hash)
            if ($newImplicitRemotingHash -ne $savedImplicitRemotingHash)
            {
                & $script:WriteWarning -Message 'Commands that are available in the new remote session are different than those available when the implicit remoting module was created.  Consider creating the module again by using the Export-PSSession cmdlet.'
            }
        }

        
    }
    if (($script:PSSession -eq $null) -or ($script:PSSession.Runspace.RunspaceStateInfo.State -ne 'Opened'))
    {
        throw 'No session has been associated with this implicit remoting module.'
    }
    return [Management.Automation.Runspaces.PSSession]$script:PSSession
}

function Modify-PSImplicitRemotingParameters
{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [hashtable]
        $clientSideParameters,

        [Parameter(Mandatory = $true, Position = 1)]
        $PSBoundParameters,

        [Parameter(Mandatory = $true, Position = 2)]
        [string]
        $parameterName,

        [Parameter()]
        [switch]
        $leaveAsRemoteParameter)
        
    if ($PSBoundParameters.ContainsKey($parameterName))
    {
        $clientSideParameters.Add($parameterName, $PSBoundParameters[$parameterName])
        if (-not $leaveAsRemoteParameter) { 
            $null = $PSBoundParameters.Remove($parameterName) 
        }
    }
}

function Get-PSImplicitRemotingClientSideParameters
{
    param(
        [Parameter(Mandatory = $true, Position = 1)]
        $PSBoundParameters,

        [Parameter(Mandatory = $true, Position = 2)]
        $proxyForCmdlet)

    $clientSideParameters = @{}
    $parametersToLeaveRemote = 'ErrorAction', 'WarningAction', 'InformationAction'

    Modify-PSImplicitRemotingParameters $clientSideParameters $PSBoundParameters 'AsJob'
    if ($proxyForCmdlet)
    {
        foreach($parameter in [System.Management.Automation.Cmdlet]::CommonParameters)
        {
            if($parametersToLeaveRemote -contains $parameter)
            {
                Modify-PSImplicitRemotingParameters $clientSideParameters $PSBoundParameters $parameter -LeaveAsRemoteParameter
            }
            else
            {
                Modify-PSImplicitRemotingParameters $clientSideParameters $PSBoundParameters $parameter
            }
        }
    }

    return $clientSideParameters
}

##############################################################################

& $script:SetItem 'function:script:Add-DistributionGroupMember' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Member},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Add-DistributionGroupMember') `
                            -Arg ('Add-DistributionGroupMember', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Add-DistributionGroupMember
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Add-MailboxFolderPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${AccessRights},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Add-MailboxFolderPermission') `
                            -Arg ('Add-MailboxFolderPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Add-MailboxFolderPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Add-MailboxLocation' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Add-MailboxLocation') `
                            -Arg ('Add-MailboxLocation', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Add-MailboxLocation
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Add-MailboxPermission' `
{
    param(
    
    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${AccessRights},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Deny},

    ${AutoMapping},

    ${User},

    ${Owner},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${InheritanceType},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${Instance},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Add-MailboxPermission') `
                            -Arg ('Add-MailboxPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Add-MailboxPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Add-PublicFolderClientPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${AccessRights},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Add-PublicFolderClientPermission') `
                            -Arg ('Add-PublicFolderClientPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Add-PublicFolderClientPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Add-ResubmitRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${UnresponsivePrimaryServers},

    [Alias('infa')]
    ${InformationAction},

    ${Destination},

    [Alias('wa')]
    ${WarningAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('db')]
    [switch]
    ${Debug},

    ${StartTime},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${Recipient},

    [Alias('ob')]
    ${OutBuffer},

    ${CorrelationId},

    ${TestOnly},

    ${Sender},

    ${EndTime},

    ${MessageId},

    ${ResubmitTo},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Add-ResubmitRequest') `
                            -Arg ('Add-ResubmitRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Add-ResubmitRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Clear-ActiveSyncDevice' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Cancel},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${NotificationEmailAddresses},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Clear-ActiveSyncDevice') `
                            -Arg ('Clear-ActiveSyncDevice', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Clear-ActiveSyncDevice
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Clear-MobileDevice' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Cancel},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${AccountOnly},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${NotificationEmailAddresses},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Clear-MobileDevice') `
                            -Arg ('Clear-MobileDevice', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Clear-MobileDevice
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Connect-Mailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Force},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ValidateOnly},

    ${LinkedCredential},

    ${User},

    [switch]
    ${Archive},

    [switch]
    ${Equipment},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RetentionPolicy},

    [switch]
    ${Shared},

    [switch]
    ${ManagedFolderMailboxPolicyAllowed},

    [Alias('ov')]
    ${OutVariable},

    [switch]
    ${Room},

    ${LinkedMasterAccount},

    ${ManagedFolderMailboxPolicy},

    ${DomainController},

    ${LinkedDomainController},

    ${ActiveSyncMailboxPolicy},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    ${Alias},

    ${Database},

    ${AddressBookPolicy},

    [switch]
    ${AllowLegacyDNMismatch},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Connect-Mailbox') `
                            -Arg ('Connect-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Connect-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-DistributionGroup' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-DistributionGroup') `
                            -Arg ('Disable-DistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-DistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-InboxRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AlwaysDeleteOutlookRulesBlob},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-InboxRule') `
                            -Arg ('Disable-InboxRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-InboxRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-Mailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [switch]
    ${DisableArbitrationMailboxWithOABsAllowed},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [switch]
    ${Arbitration},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${PublicFolder},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${Archive},

    [switch]
    ${DisableLastArbitrationMailboxAllowed},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IgnoreLegalHold},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${RemoteArchive},

    ${DomainController},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-Mailbox') `
                            -Arg ('Disable-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-MailboxQuarantine' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    ${StoreMailboxIdentity},

    [switch]
    ${IncludeAllDatabases},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${IncludePassive},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${IncludeAllMailboxes},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-MailboxQuarantine') `
                            -Arg ('Disable-MailboxQuarantine', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-MailboxQuarantine
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-MailContact' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-MailContact') `
                            -Arg ('Disable-MailContact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-MailContact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-MailPublicFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-MailPublicFolder') `
                            -Arg ('Disable-MailPublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-MailPublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-MailUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IgnoreLegalHold},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-MailUser') `
                            -Arg ('Disable-MailUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-MailUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-PushNotificationProxy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-PushNotificationProxy') `
                            -Arg ('Disable-PushNotificationProxy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-PushNotificationProxy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-RemoteMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${Archive},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IgnoreLegalHold},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-RemoteMailbox') `
                            -Arg ('Disable-RemoteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-RemoteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-ServiceEmailChannel' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-ServiceEmailChannel') `
                            -Arg ('Disable-ServiceEmailChannel', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-ServiceEmailChannel
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Disable-SweepRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Disable-SweepRule') `
                            -Arg ('Disable-SweepRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Disable-SweepRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Dismount-Database' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Dismount-Database') `
                            -Arg ('Dismount-Database', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Dismount-Database
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-DistributionGroup' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${DisplayName},

    ${Alias},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${PrimarySmtpAddress},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-DistributionGroup') `
                            -Arg ('Enable-DistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-DistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-InboxRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AlwaysDeleteOutlookRulesBlob},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-InboxRule') `
                            -Arg ('Enable-InboxRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-InboxRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-Mailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AuditLog},

    ${Identity},

    [switch]
    ${RemoteArchive},

    ${DisplayName},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    ${ArchiveName},

    [switch]
    ${PublicFolder},

    [switch]
    ${Force},

    [Alias('wv')]
    ${WarningVariable},

    ${RoleAssignmentPolicy},

    ${LinkedCredential},

    ${ArchiveDatabase},

    [switch]
    ${Archive},

    [switch]
    ${Equipment},

    ${ArchiveGuid},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RetentionPolicy},

    [Alias('ea')]
    ${ErrorAction},

    [switch]
    ${Shared},

    [switch]
    ${Arbitration},

    [Alias('ov')]
    ${OutVariable},

    [switch]
    ${Room},

    [switch]
    ${LinkedRoom},

    ${LinkedMasterAccount},

    ${DomainController},

    ${LinkedDomainController},

    ${ActiveSyncMailboxPolicy},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [switch]
    ${HoldForMigration},

    [switch]
    ${Discovery},

    [Alias('iv')]
    ${InformationVariable},

    ${ArchiveDomain},

    ${Alias},

    ${Database},

    ${AddressBookPolicy},

    ${PrimarySmtpAddress},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-Mailbox') `
                            -Arg ('Enable-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-MailboxQuarantine' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    ${StoreMailboxIdentity},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${AllowMigration},

    ${QuarantineReason},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${Duration},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-MailboxQuarantine') `
                            -Arg ('Enable-MailboxQuarantine', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-MailboxQuarantine
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-MailContact' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${DisplayName},

    ${Alias},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${MessageBodyFormat},

    ${PrimarySmtpAddress},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    ${MessageFormat},

    [Alias('ob')]
    ${OutBuffer},

    ${MacAttachmentFormat},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    ${UsePreferMessageFormat},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ExternalEmailAddress},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-MailContact') `
                            -Arg ('Enable-MailContact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-MailContact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-MailPublicFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${HiddenFromAddressListsEnabled},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-MailPublicFolder') `
                            -Arg ('Enable-MailPublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-MailPublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-MailUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${DisplayName},

    ${Alias},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${MessageBodyFormat},

    ${PrimarySmtpAddress},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    ${MessageFormat},

    [Alias('ob')]
    ${OutBuffer},

    ${MacAttachmentFormat},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    ${UsePreferMessageFormat},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ExternalEmailAddress},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-MailUser') `
                            -Arg ('Enable-MailUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-MailUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-PushNotificationProxy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${Uri},

    [Alias('wa')]
    ${WarningAction},

    ${Organization},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-PushNotificationProxy') `
                            -Arg ('Enable-PushNotificationProxy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-PushNotificationProxy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-RemoteMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    ${PrimarySmtpAddress},

    ${DisplayName},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [switch]
    ${Equipment},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RemoteRoutingAddress},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${ACLableSyncedObjectEnabled},

    [switch]
    ${Archive},

    ${Alias},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    ${ArchiveName},

    [switch]
    ${Room},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Shared},

    ${DomainController},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-RemoteMailbox') `
                            -Arg ('Enable-RemoteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-RemoteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-ServiceEmailChannel' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-ServiceEmailChannel') `
                            -Arg ('Enable-ServiceEmailChannel', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-ServiceEmailChannel
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Enable-SweepRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Enable-SweepRule') `
                            -Arg ('Enable-SweepRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Enable-SweepRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Export-Message' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Export-Message') `
                            -Arg ('Export-Message', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Export-Message
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-AcceptedDomain' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-AcceptedDomain') `
                            -Arg ('Get-AcceptedDomain', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-AcceptedDomain
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ActiveSyncDevice' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [switch]
    ${Monitoring},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ActiveSyncDevice') `
                            -Arg ('Get-ActiveSyncDevice', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ActiveSyncDevice
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ActiveSyncDeviceStatistics' `
{
    param(
    
    [switch]
    ${ShowRecoveryPassword},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${GetMailboxLog},

    ${Identity},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${NotificationEmailAddresses},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ActiveSyncDeviceStatistics') `
                            -Arg ('Get-ActiveSyncDeviceStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ActiveSyncDeviceStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ActiveSyncMailboxPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ActiveSyncMailboxPolicy') `
                            -Arg ('Get-ActiveSyncMailboxPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ActiveSyncMailboxPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-AddressBookPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-AddressBookPolicy') `
                            -Arg ('Get-AddressBookPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-AddressBookPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ADServerSettings' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ADServerSettings') `
                            -Arg ('Get-ADServerSettings', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ADServerSettings
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-CalendarNotification' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-CalendarNotification') `
                            -Arg ('Get-CalendarNotification', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-CalendarNotification
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-CalendarProcessing' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-CalendarProcessing') `
                            -Arg ('Get-CalendarProcessing', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-CalendarProcessing
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-CASMailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${ActiveSyncSuppressReadReceipt},

    ${Identity},

    [switch]
    ${ReadFromDomainController},

    [switch]
    ${ReadIsOptimizedForAccessibility},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Anr},

    [switch]
    ${RecalculateHasActiveSyncDevicePartnership},

    [switch]
    ${Monitoring},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ea')]
    ${ErrorAction},

    ${Credential},

    ${ResultSize},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    ${DomainController},

    [switch]
    ${ActiveSyncDebugLogging},

    [switch]
    ${IgnoreDefaultScope},

    ${SendLogsTo},

    ${Filter},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${GetImapProtocolLog},

    [switch]
    ${ProtocolSettings},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${GetPopProtocolLog},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-CASMailbox') `
                            -Arg ('Get-CASMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-CASMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Contact' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${RecipientTypeDetails},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Contact') `
                            -Arg ('Get-Contact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Contact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-DefaultFolderHistory' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${DefaultFolderType},

    [Alias('ov')]
    ${OutVariable},

    ${FromDateTime},

    ${ToDateTime},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-DefaultFolderHistory') `
                            -Arg ('Get-DefaultFolderHistory', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-DefaultFolderHistory
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-DistributionGroup' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${RecipientTypeDetails},

    [Alias('wa')]
    ${WarningAction},

    ${ManagedBy},

    ${DomainController},

    ${Filter},

    ${ResultSize},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-DistributionGroup') `
                            -Arg ('Get-DistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-DistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-DistributionGroupMember' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-DistributionGroupMember') `
                            -Arg ('Get-DistributionGroupMember', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-DistributionGroupMember
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-DomainController' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Forest},

    ${DomainName},

    [switch]
    ${GlobalCatalog},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-DomainController') `
                            -Arg ('Get-DomainController', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-DomainController
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-DynamicDistributionGroup' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${IncludeSystemObjects},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    ${ManagedBy},

    ${DomainController},

    ${Filter},

    ${ResultSize},

    ${Anr},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-DynamicDistributionGroup') `
                            -Arg ('Get-DynamicDistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-DynamicDistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-EligibleDistributionGroupForMigration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${ManagedBy},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-EligibleDistributionGroupForMigration') `
                            -Arg ('Get-EligibleDistributionGroupForMigration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-EligibleDistributionGroupForMigration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ExchangeServer' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Domain},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Status},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ExchangeServer') `
                            -Arg ('Get-ExchangeServer', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ExchangeServer
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ExchangeServerAccessLicense' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ExchangeServerAccessLicense') `
                            -Arg ('Get-ExchangeServerAccessLicense', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ExchangeServerAccessLicense
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ExchangeServerAccessLicenseUser' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${LicenseName},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ExchangeServerAccessLicenseUser') `
                            -Arg ('Get-ExchangeServerAccessLicenseUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ExchangeServerAccessLicenseUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Group' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${RecipientTypeDetails},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Group') `
                            -Arg ('Get-Group', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Group
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-HybridConfiguration' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${DomainController},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-HybridConfiguration') `
                            -Arg ('Get-HybridConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-HybridConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-InboxRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${DescriptionTimeFormat},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DescriptionTimeZone},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-InboxRule') `
                            -Arg ('Get-InboxRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-InboxRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-LinkedUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-LinkedUser') `
                            -Arg ('Get-LinkedUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-LinkedUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-LogonStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-LogonStatistics') `
                            -Arg ('Get-LogonStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-LogonStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Mailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AuditLog},

    ${SortBy},

    ${Identity},

    [switch]
    ${RemoteArchive},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${PublicFolder},

    [Alias('pv')]
    ${PipelineVariable},

    ${Anr},

    [switch]
    ${Archive},

    [switch]
    ${Monitoring},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${AuxAuditLog},

    ${Credential},

    [Alias('ea')]
    ${ErrorAction},

    ${ResultSize},

    [switch]
    ${Arbitration},

    ${RecipientTypeDetails},

    [switch]
    ${Migration},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${ReadFromDomainController},

    [switch]
    ${IgnoreDefaultScope},

    ${Filter},

    [switch]
    ${GroupMailbox},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('wv')]
    ${WarningVariable},

    ${Database},

    [switch]
    ${SupervisoryReviewPolicy},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Server},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Mailbox') `
                            -Arg ('Get-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxAutoReplyConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxAutoReplyConfiguration') `
                            -Arg ('Get-MailboxAutoReplyConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxAutoReplyConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxCalendarConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxCalendarConfiguration') `
                            -Arg ('Get-MailboxCalendarConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxCalendarConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxCalendarFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxCalendarFolder') `
                            -Arg ('Get-MailboxCalendarFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxCalendarFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxDatabase' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [switch]
    ${DumpsterStatistics},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [switch]
    ${IncludePreExchange2013},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${IncludeCorrupted},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Status},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxDatabase') `
                            -Arg ('Get-MailboxDatabase', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxDatabase
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxDatabaseRedundancy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [switch]
    ${ProxyToPam},

    [Alias('ov')]
    ${OutVariable},

    [Alias('Dag')]
    ${DatabaseAvailabilityGroup},

    [Alias('wv')]
    ${WarningVariable},

    ${TimeoutInSeconds},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('Database')]
    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${ServerToContact},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxDatabaseRedundancy') `
                            -Arg ('Get-MailboxDatabaseRedundancy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxDatabaseRedundancy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxExportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${HighPriority},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BatchName},

    ${Name},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    ${Mailbox},

    ${Suspend},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${Status},

    ${DomainController},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxExportRequest') `
                            -Arg ('Get-MailboxExportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxExportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxExportRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxExportRequestStatistics') `
                            -Arg ('Get-MailboxExportRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxExportRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxFolderPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${GroupMailbox},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxFolderPermission') `
                            -Arg ('Get-MailboxFolderPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxFolderPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxFolderStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${IncludeOldestAndNewestItems},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${Archive},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AuditLog},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeAnalysis},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${FolderScope},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxFolderStatistics') `
                            -Arg ('Get-MailboxFolderStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxFolderStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxImportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${HighPriority},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BatchName},

    ${Name},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    ${Mailbox},

    ${Suspend},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${Status},

    ${DomainController},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxImportRequest') `
                            -Arg ('Get-MailboxImportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxImportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxImportRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxImportRequestStatistics') `
                            -Arg ('Get-MailboxImportRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxImportRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxJunkEmailConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxJunkEmailConfiguration') `
                            -Arg ('Get-MailboxJunkEmailConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxJunkEmailConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxLocation' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxLocation') `
                            -Arg ('Get-MailboxLocation', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxLocation
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxMessageConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxMessageConfiguration') `
                            -Arg ('Get-MailboxMessageConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxMessageConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    ${User},

    [switch]
    ${Owner},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxPermission') `
                            -Arg ('Get-MailboxPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxPreferredLocation' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxPreferredLocation') `
                            -Arg ('Get-MailboxPreferredLocation', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxPreferredLocation
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxRegionalConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${VerifyDefaultFolderNameLanguage},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxRegionalConfiguration') `
                            -Arg ('Get-MailboxRegionalConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxRegionalConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxRelocationRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxRelocationRequestStatistics') `
                            -Arg ('Get-MailboxRelocationRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxRelocationRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxRepairRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${Detailed},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${Archive},

    ${StoreMailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Mailbox},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxRepairRequest') `
                            -Arg ('Get-MailboxRepairRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxRepairRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxServer' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Status},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxServer') `
                            -Arg ('Get-MailboxServer', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxServer
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxServerRedundancy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [switch]
    ${ProxyToPam},

    [Alias('ov')]
    ${OutVariable},

    [Alias('Dag')]
    ${DatabaseAvailabilityGroup},

    [Alias('wv')]
    ${WarningVariable},

    ${TimeoutInSeconds},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('Server')]
    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${ServerToContact},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxServerRedundancy') `
                            -Arg ('Get-MailboxServerRedundancy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxServerRedundancy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxSpellingConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxSpellingConfiguration') `
                            -Arg ('Get-MailboxSpellingConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxSpellingConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [switch]
    ${NoADLookup},

    ${StoreMailboxIdentity},

    [switch]
    ${IncludeQuarantineDetails},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('wa')]
    ${WarningAction},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${IncludePassive},

    ${Server},

    [switch]
    ${Archive},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    ${CopyOnServer},

    ${DomainController},

    ${Filter},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxStatistics') `
                            -Arg ('Get-MailboxStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailboxUserConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailboxUserConfiguration') `
                            -Arg ('Get-MailboxUserConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailboxUserConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailContact' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${RecipientTypeDetails},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailContact') `
                            -Arg ('Get-MailContact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailContact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailPublicFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailPublicFolder') `
                            -Arg ('Get-MailPublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailPublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MailUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MailUser') `
                            -Arg ('Get-MailUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MailUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ManagementRoleAssignment' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${RoleAssigneeType},

    ${CustomRecipientWriteScope},

    ${Identity},

    ${Enabled},

    [Alias('ev')]
    ${ErrorVariable},

    ${RecipientWriteScope},

    [Alias('infa')]
    ${InformationAction},

    [Alias('pv')]
    ${PipelineVariable},

    ${WritableRecipient},

    ${WritableDatabase},

    ${WritableServer},

    [Alias('wv')]
    ${WarningVariable},

    ${ConfigWriteScope},

    ${ExclusiveConfigWriteScope},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RoleAssignee},

    ${Delegating},

    ${Exclusive},

    [Alias('ov')]
    ${OutVariable},

    ${AssignmentMethod},

    ${DomainController},

    ${Role},

    ${RecipientAdministrativeUnitScope},

    ${ExclusiveRecipientWriteScope},

    ${RecipientOrganizationalUnitScope},

    [Alias('ob')]
    ${OutBuffer},

    ${CustomConfigWriteScope},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${GetEffectiveUsers},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ManagementRoleAssignment') `
                            -Arg ('Get-ManagementRoleAssignment', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ManagementRoleAssignment
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Message' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Server},

    [Alias('ov')]
    ${OutVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ReturnPageInfo},

    [switch]
    ${IncludeRecipientInfo},

    ${BookmarkIndex},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Queue},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    ${SortOrder},

    ${SearchForward},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${IncludeComponentLatencyInfo},

    ${BookmarkObject},

    ${IncludeBookmark},

    ${Filter},

    ${ResultSize},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Message') `
                            -Arg ('Get-Message', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Message
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MessageCategory' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MessageCategory') `
                            -Arg ('Get-MessageCategory', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MessageCategory
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MessageClassification' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${IncludeLocales},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MessageClassification') `
                            -Arg ('Get-MessageClassification', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MessageClassification
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MobileDevice' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${OWAforDevices},

    ${SortBy},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${Monitoring},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${ActiveSync},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Filter},

    [switch]
    ${RestApi},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MobileDevice') `
                            -Arg ('Get-MobileDevice', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MobileDevice
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MobileDeviceMailboxPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MobileDeviceMailboxPolicy') `
                            -Arg ('Get-MobileDeviceMailboxPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MobileDeviceMailboxPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MobileDeviceStatistics' `
{
    param(
    
    [switch]
    ${ShowRecoveryPassword},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${OWAforDevices},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${GetMailboxLog},

    ${Identity},

    [switch]
    ${ActiveSync},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${NotificationEmailAddresses},

    [switch]
    ${RestApi},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MobileDeviceStatistics') `
                            -Arg ('Get-MobileDeviceStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MobileDeviceStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MoveRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${SourceDatabase},

    ${TargetDatabase},

    ${Identity},

    ${SuspendWhenReadyToComplete},

    [switch]
    ${IncludeSoftDeletedObjects},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('wv')]
    ${WarningVariable},

    ${HighPriority},

    ${Flags},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ea')]
    ${ErrorAction},

    ${Credential},

    ${ResultSize},

    ${Suspend},

    [Alias('ov')]
    ${OutVariable},

    ${BatchName},

    ${RemoteHostName},

    ${MoveStatus},

    ${Offline},

    ${DomainController},

    ${Protect},

    ${SortBy},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MoveRequest') `
                            -Arg ('Get-MoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MoveRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    ${MoveRequestQueue},

    [switch]
    ${ReportOnly},

    [Alias('wv')]
    ${WarningVariable},

    ${MailboxGuid},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${DomainController},

    [switch]
    ${Diagnostic},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MoveRequestStatistics') `
                            -Arg ('Get-MoveRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MoveRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MRSRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Organization},

    ${HighPriority},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BatchName},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    ${MailboxLocation},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${Suspend},

    ${Flags},

    ${SourceDatabase},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    ${Status},

    ${DomainController},

    ${TargetDatabase},

    ${ResultSize},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MRSRequest') `
                            -Arg ('Get-MRSRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MRSRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-MRSRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-MRSRequestStatistics') `
                            -Arg ('Get-MRSRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-MRSRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Notification' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${Summary},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${ProcessType},

    ${DomainController},

    ${StartDate},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Notification') `
                            -Arg ('Get-Notification', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Notification
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-OfflineAddressBook' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-OfflineAddressBook') `
                            -Arg ('Get-OfflineAddressBook', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-OfflineAddressBook
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-OnlineMeetingConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-OnlineMeetingConfiguration') `
                            -Arg ('Get-OnlineMeetingConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-OnlineMeetingConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-OrganizationalUnit' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    ${SearchText},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${SingleNodeOnly},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [switch]
    ${IncludeContainers},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-OrganizationalUnit') `
                            -Arg ('Get-OrganizationalUnit', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-OrganizationalUnit
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-OwaMailboxPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-OwaMailboxPolicy') `
                            -Arg ('Get-OwaMailboxPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-OwaMailboxPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PhysicalAvailabilityReport' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ReportingPeriod},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ReportingServer},

    [Alias('pv')]
    ${PipelineVariable},

    ${ReportingDatabase},

    [Alias('ev')]
    ${ErrorVariable},

    ${EndDate},

    [Alias('ob')]
    ${OutBuffer},

    ${ExchangeServer},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${DailyStatistics},

    ${StartDate},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PhysicalAvailabilityReport') `
                            -Arg ('Get-PhysicalAvailabilityReport', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PhysicalAvailabilityReport
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolder' `
{
    param(
    
    [switch]
    ${GetChildren},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${LostAndFound},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${ResidentFolders},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [switch]
    ${Recurse},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolder') `
                            -Arg ('Get-PublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderClientPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Mailbox},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderClientPermission') `
                            -Arg ('Get-PublicFolderClientPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderClientPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderDatabase' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${IncludeCorrupted},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Status},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderDatabase') `
                            -Arg ('Get-PublicFolderDatabase', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderDatabase
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderItemStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderItemStatistics') `
                            -Arg ('Get-PublicFolderItemStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderItemStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMailboxDiagnostics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [switch]
    ${IncludeHierarchyInfo},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${IncludeDumpsterInfo},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMailboxDiagnostics') `
                            -Arg ('Get-PublicFolderMailboxDiagnostics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMailboxDiagnostics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMailboxMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${HighPriority},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BatchName},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${Suspend},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${Status},

    ${DomainController},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMailboxMigrationRequest') `
                            -Arg ('Get-PublicFolderMailboxMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMailboxMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMailboxMigrationRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMailboxMigrationRequestStatistics') `
                            -Arg ('Get-PublicFolderMailboxMigrationRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMailboxMigrationRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${HighPriority},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BatchName},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${Suspend},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${Status},

    ${DomainController},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMigrationRequest') `
                            -Arg ('Get-PublicFolderMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMigrationRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMigrationRequestStatistics') `
                            -Arg ('Get-PublicFolderMigrationRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMigrationRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${HighPriority},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BatchName},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${Suspend},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${Status},

    ${DomainController},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMoveRequest') `
                            -Arg ('Get-PublicFolderMoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderMoveRequestStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${RequestGuid},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${ReportOnly},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IncludeReport},

    ${Identity},

    ${DiagnosticArgument},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Diagnostic},

    ${RequestQueue},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderMoveRequestStatistics') `
                            -Arg ('Get-PublicFolderMoveRequestStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderMoveRequestStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-PublicFolderStatistics' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-PublicFolderStatistics') `
                            -Arg ('Get-PublicFolderStatistics', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-PublicFolderStatistics
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Queue' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Server},

    [Alias('ov')]
    ${OutVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ReturnPageInfo},

    ${BookmarkIndex},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    ${SortOrder},

    ${SearchForward},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${BookmarkObject},

    ${IncludeBookmark},

    ${Filter},

    ${Include},

    ${Exclude},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Queue') `
                            -Arg ('Get-Queue', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Queue
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-RbacDiagnosticInfo' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    ${UserName},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-RbacDiagnosticInfo') `
                            -Arg ('Get-RbacDiagnosticInfo', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-RbacDiagnosticInfo
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ReceiveConnector' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ReceiveConnector') `
                            -Arg ('Get-ReceiveConnector', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ReceiveConnector
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Recipient' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${SortBy},

    ${Identity},

    ${RecipientPreviewFilter},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Anr},

    ${BookmarkDisplayName},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Credential},

    ${ResultSize},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('ov')]
    ${OutVariable},

    ${RecipientTypeDetails},

    ${Properties},

    ${PropertySet},

    ${DomainController},

    [switch]
    ${ReadFromDomainController},

    [switch]
    ${IgnoreDefaultScope},

    ${Filter},

    [switch]
    ${IncludeSoftDeletedRecipients},

    [Alias('wv')]
    ${WarningVariable},

    ${RecipientType},

    ${Database},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    [Alias('ev')]
    ${ErrorVariable},

    ${IncludeBookmarkObject},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Recipient') `
                            -Arg ('Get-Recipient', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Recipient
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-RecoverableItems' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${SourceFolder},

    ${EntryID},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    ${LastParentFolderID},

    ${FilterEndTime},

    ${FilterStartTime},

    ${ResultSize},

    ${FilterItemType},

    ${SubjectContains},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-RecoverableItems') `
                            -Arg ('Get-RecoverableItems', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-RecoverableItems
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-RemoteMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${Archive},

    [Alias('ev')]
    ${ErrorVariable},

    ${OnPremisesOrganizationalUnit},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    ${DomainController},

    ${Filter},

    ${ResultSize},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-RemoteMailbox') `
                            -Arg ('Get-RemoteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-RemoteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ResourceConfig' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ResourceConfig') `
                            -Arg ('Get-ResourceConfig', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ResourceConfig
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ResubmitRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ResubmitRequest') `
                            -Arg ('Get-ResubmitRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ResubmitRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-RoleAssignmentPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-RoleAssignmentPolicy') `
                            -Arg ('Get-RoleAssignmentPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-RoleAssignmentPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-SecurityPrincipal' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    ${IncludeDomainLocalFrom},

    ${Types},

    ${ResultSize},

    ${Organization},

    ${DomainController},

    ${Filter},

    [switch]
    ${RoleGroupAssignable},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-SecurityPrincipal') `
                            -Arg ('Get-SecurityPrincipal', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-SecurityPrincipal
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ServiceAvailabilityReport' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ReportingPeriod},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ReportingServer},

    [Alias('pv')]
    ${PipelineVariable},

    ${ReportingDatabase},

    [Alias('ev')]
    ${ErrorVariable},

    ${EndDate},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${DailyStatistics},

    ${StartDate},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ServiceAvailabilityReport') `
                            -Arg ('Get-ServiceAvailabilityReport', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ServiceAvailabilityReport
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ServiceStatus' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ReportingServer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${MaintenanceWindowDays},

    ${ReportingDatabase},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ServiceStatus') `
                            -Arg ('Get-ServiceStatus', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ServiceStatus
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-SharingPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-SharingPolicy') `
                            -Arg ('Get-SharingPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-SharingPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-SiteMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${ResultSize},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${DeletedSiteMailbox},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    ${DomainController},

    [switch]
    ${BypassOwnerCheck},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-SiteMailbox') `
                            -Arg ('Get-SiteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-SiteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-SiteMailboxProvisioningPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-SiteMailboxProvisioningPolicy') `
                            -Arg ('Get-SiteMailboxProvisioningPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-SiteMailboxProvisioningPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-SweepRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    ${Provider},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-SweepRule') `
                            -Arg ('Get-SweepRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-SweepRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-TextMessagingAccount' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-TextMessagingAccount') `
                            -Arg ('Get-TextMessagingAccount', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-TextMessagingAccount
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ThrottlingPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${Explicit},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    ${ThrottlingPolicyScope},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ThrottlingPolicy') `
                            -Arg ('Get-ThrottlingPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ThrottlingPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-ThrottlingPolicyAssociation' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${SortBy},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ThrottlingPolicy},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${DomainController},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-ThrottlingPolicyAssociation') `
                            -Arg ('Get-ThrottlingPolicyAssociation', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-ThrottlingPolicyAssociation
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-Trust' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${DomainName},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-Trust') `
                            -Arg ('Get-Trust', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-Trust
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-UnifiedAuditSetting' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-UnifiedAuditSetting') `
                            -Arg ('Get-UnifiedAuditSetting', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-UnifiedAuditSetting
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-User' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AuditLog},

    ${SortBy},

    ${Identity},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${PublicFolder},

    [Alias('pv')]
    ${PipelineVariable},

    ${Anr},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${AuxAuditLog},

    ${Credential},

    ${ResultSize},

    [switch]
    ${Arbitration},

    ${RecipientTypeDetails},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${ReadFromDomainController},

    [switch]
    ${IgnoreDefaultScope},

    ${Filter},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${SupervisoryReviewPolicy},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-User') `
                            -Arg ('Get-User', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-User
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-UserPhoto' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ReadFromDomainController},

    [Alias('ov')]
    ${OutVariable},

    ${SortBy},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationalUnit},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${ResultSize},

    ${PhotoType},

    ${DomainController},

    ${Filter},

    [switch]
    ${Preview},

    ${Anr},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-UserPhoto') `
                            -Arg ('Get-UserPhoto', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-UserPhoto
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Get-UserPrincipalNamesSuffix' `
{
    param(
    
    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ea')]
    ${ErrorAction},

    ${OrganizationalUnit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Get-UserPrincipalNamesSuffix') `
                            -Arg ('Get-UserPrincipalNamesSuffix', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Get-UserPrincipalNamesSuffix
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Import-RecipientDataProperty' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${Picture},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${SpokenName},

    ${DomainController},

    ${FileData},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Import-RecipientDataProperty') `
                            -Arg ('Import-RecipientDataProperty', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Import-RecipientDataProperty
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Mount-Database' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${NewCapacity},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AcceptDataLoss},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Mount-Database') `
                            -Arg ('Mount-Database', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Mount-Database
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Move-ActiveMailboxDatabase' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${SkipActiveCopyChecks},

    [switch]
    ${SkipLagChecks},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ActivatePreferredOnServer},

    ${ActivateOnServer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${MoveComment},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${SkipClientExperienceChecks},

    [switch]
    ${SkipMaximumActiveDatabasesChecks},

    [switch]
    ${SkipMoveSuppressionChecks},

    [switch]
    ${MoveAllDatabasesOrNone},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${SkipHealthChecks},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${MountDialOverride},

    [switch]
    ${SkipCpuChecks},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${TerminateOnWarning},

    [Alias('ev')]
    ${ErrorVariable},

    ${Server},

    [switch]
    ${SkipAllChecks},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Move-ActiveMailboxDatabase') `
                            -Arg ('Move-ActiveMailboxDatabase', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Move-ActiveMailboxDatabase
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Move-DatabasePath' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${EdbFilePath},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${LogFolderPath},

    ${DomainController},

    [switch]
    ${ConfigurationOnly},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Move-DatabasePath') `
                            -Arg ('Move-DatabasePath', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Move-DatabasePath
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-DistributionGroup' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${ModeratedBy},

    ${RequireSenderAuthenticationEnabled},

    ${ModerationEnabled},

    ${DisplayName},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${MemberDepartRestriction},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${IgnoreNamingPolicy},

    [switch]
    ${RoomList},

    ${ArbitrationMailbox},

    [Alias('wv')]
    ${WarningVariable},

    ${BypassNestedModerationEnabled},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${CopyOwnerToMember},

    ${Members},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    ${MemberJoinRestriction},

    [Alias('iv')]
    ${InformationVariable},

    ${Alias},

    ${ManagedBy},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${SamAccountName},

    ${PrimarySmtpAddress},

    ${SendModerationNotifications},

    ${Notes},

    ${OrganizationalUnit},

    ${Name},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-DistributionGroup') `
                            -Arg ('New-DistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-DistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-DynamicDistributionGroup' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${ConditionalCustomAttribute5},

    ${ModeratedBy},

    ${ModerationEnabled},

    ${RecipientFilter},

    ${ConditionalCustomAttribute8},

    ${DisplayName},

    ${ConditionalCustomAttribute10},

    ${Name},

    [Alias('ev')]
    ${ErrorVariable},

    ${ConditionalCustomAttribute9},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ConditionalCustomAttribute2},

    ${IncludedRecipients},

    ${ArbitrationMailbox},

    ${ConditionalCustomAttribute6},

    ${ConditionalCustomAttribute3},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ConditionalCustomAttribute13},

    ${RecipientContainer},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ob')]
    ${OutBuffer},

    ${ConditionalCustomAttribute12},

    [Alias('ov')]
    ${OutVariable},

    ${ConditionalDepartment},

    ${ConditionalStateOrProvince},

    ${DomainController},

    ${ConditionalCustomAttribute7},

    ${ConditionalCustomAttribute14},

    [Alias('pv')]
    ${PipelineVariable},

    ${ConditionalCompany},

    ${ConditionalCustomAttribute4},

    [Alias('iv')]
    ${InformationVariable},

    ${ConditionalCustomAttribute1},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${Alias},

    ${PrimarySmtpAddress},

    ${SendModerationNotifications},

    ${ConditionalCustomAttribute15},

    ${OrganizationalUnit},

    ${ConditionalCustomAttribute11},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-DynamicDistributionGroup') `
                            -Arg ('New-DynamicDistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-DynamicDistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-HybridConfiguration' `
{
    param(
    
    ${Features},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${EdgeTransportServers},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${OnPremisesSmartHost},

    [Alias('wv')]
    ${WarningVariable},

    ${ReceivingTransportServers},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ServiceInstance},

    ${TlsCertificateName},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ExternalIPAddresses},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${ClientAccessServers},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ea')]
    ${ErrorAction},

    ${SendingTransportServers},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${Domains},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-HybridConfiguration') `
                            -Arg ('New-HybridConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-HybridConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-InboxRule' `
{
    param(
    
    ${ExceptIfMyNameNotInToBox},

    ${ExceptIfMyNameInToOrCcBox},

    [Alias('wa')]
    ${WarningAction},

    ${PinMessage},

    ${WithinSizeRangeMaximum},

    ${ReceivedBeforeDate},

    ${ExceptIfFromAddressContainsWords},

    ${ExceptIfWithinSizeRangeMaximum},

    ${WithinSizeRangeMinimum},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${MyNameInToOrCcBox},

    ${ExceptIfReceivedBeforeDate},

    ${Mailbox},

    [Alias('ea')]
    ${ErrorAction},

    ${ExceptIfFrom},

    ${RedirectTo},

    ${ReceivedAfterDate},

    ${ForwardTo},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    ${ExceptIfReceivedAfterDate},

    [Alias('ov')]
    ${OutVariable},

    ${ExceptIfWithImportance},

    ${HeaderContainsWords},

    ${ExceptIfSentOnlyToMe},

    ${ExceptIfSubjectOrBodyContainsWords},

    ${ExceptIfMessageTypeMatches},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ExceptIfHasAttachment},

    ${DeleteMessage},

    ${ExceptIfMyNameInToBox},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${AlwaysDeleteOutlookRulesBlob},

    ${From},

    ${RecipientAddressContainsWords},

    ${FlaggedForAction},

    ${WithSensitivity},

    [Alias('infa')]
    ${InformationAction},

    ${CopyToFolder},

    ${FromMessageId},

    ${ExceptIfSubjectContainsWords},

    ${MarkImportance},

    ${Priority},

    ${ApplyCategory},

    ${SubjectContainsWords},

    ${ExceptIfHeaderContainsWords},

    ${ExceptIfWithSensitivity},

    ${ExceptIfRecipientAddressContainsWords},

    ${HasAttachment},

    ${SubjectOrBodyContainsWords},

    ${ExceptIfFlaggedForAction},

    ${BodyContainsWords},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${StopProcessingRules},

    ${DeleteSystemCategory},

    ${ExceptIfWithinSizeRangeMinimum},

    ${MessageTypeMatches},

    [Alias('wv')]
    ${WarningVariable},

    ${ApplySystemCategory},

    ${MarkAsRead},

    ${MoveToFolder},

    ${SentTo},

    ${MyNameInCcBox},

    [switch]
    ${ValidateOnly},

    ${DomainController},

    ${WithImportance},

    ${MyNameInToBox},

    ${ExceptIfSentTo},

    [switch]
    ${Force},

    ${SentOnlyToMe},

    ${Name},

    ${ForwardAsAttachmentTo},

    ${ExceptIfBodyContainsWords},

    ${ExceptIfMyNameInCcBox},

    ${FromAddressContainsWords},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${MyNameNotInToBox},

    ${HasClassification},

    ${ExceptIfHasClassification},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-InboxRule') `
                            -Arg ('New-InboxRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-InboxRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-LinkedUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${LinkedCredential},

    ${UserPrincipalName},

    ${DisplayName},

    ${CertificateSubject},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${LinkedDomainController},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Name},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ob')]
    ${OutBuffer},

    ${LinkedMasterAccount},

    ${OrganizationalUnit},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-LinkedUser') `
                            -Arg ('New-LinkedUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-LinkedUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-Mailbox' `
{
    param(
    
    ${Initials},

    ${ResourceCapacity},

    ${SamAccountName},

    [switch]
    ${Shared},

    [Alias('wa')]
    ${WarningAction},

    ${RoleAssignmentPolicy},

    ${LinkedCredential},

    ${ArbitrationMailbox},

    ${RoomMailboxPassword},

    [switch]
    ${Migration},

    [switch]
    ${SupervisoryReviewPolicy},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${PrimarySmtpAddress},

    [switch]
    ${LinkedRoom},

    ${Database},

    ${UserPrincipalName},

    [switch]
    ${Room},

    [switch]
    ${Equipment},

    [Alias('ov')]
    ${OutVariable},

    ${OrganizationalUnit},

    ${ImmutableId},

    ${ArchiveDatabase},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Alias},

    [switch]
    ${HoldForMigration},

    ${DisplayName},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AuxAuditLog},

    ${Phone},

    ${LinkedDomainController},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${AccountDisabled},

    ${ResetPasswordOnNextLogon},

    ${ActiveSyncMailboxPolicy},

    ${ThrottlingPolicy},

    [switch]
    ${RemoteArchive},

    ${EnableRoomMailboxAccount},

    ${RetentionPolicy},

    [switch]
    ${Archive},

    ${LastName},

    ${RemotePowerShellEnabled},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${SendModerationNotifications},

    ${IsExcludedFromServingHierarchy},

    ${Office},

    [Alias('wv')]
    ${WarningVariable},

    ${AddressBookPolicy},

    [switch]
    ${AuditLog},

    [switch]
    ${PublicFolder},

    ${SharingPolicy},

    [Alias('ea')]
    ${ErrorAction},

    ${FirstName},

    ${DomainController},

    ${Password},

    [switch]
    ${Force},

    ${Name},

    [switch]
    ${Arbitration},

    ${ModerationEnabled},

    [switch]
    ${Discovery},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ev')]
    ${ErrorVariable},

    ${LinkedMasterAccount},

    [Alias('ob')]
    ${OutBuffer},

    ${ArchiveDomain},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-Mailbox') `
                            -Arg ('New-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailboxDatabase' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${IsExcludedFromProvisioning},

    ${IsSuspendedFromProvisioning},

    ${Server},

    ${Name},

    [switch]
    ${Recovery},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${SkipDatabaseLogFolderCreation},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${IsExcludedFromInitialProvisioning},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${AutoDagExcludeFromMonitoring},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ev')]
    ${ErrorVariable},

    ${PublicFolderDatabase},

    [Alias('wa')]
    ${WarningAction},

    ${LogFolderPath},

    ${DomainController},

    ${EdbFilePath},

    ${OfflineAddressBook},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailboxDatabase') `
                            -Arg ('New-MailboxDatabase', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailboxDatabase
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailboxExportRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${ExcludeDumpster},

    ${ConflictResolutionOption},

    ${AssociatedMessagesCopyOption},

    ${WorkloadType},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${TargetRootFolder},

    ${InternalFlags},

    ${RequestExpiryInterval},

    ${SuspendComment},

    [Alias('wv')]
    ${WarningVariable},

    ${ContentFilterLanguage},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ContentFilter},

    ${IncludeFolders},

    ${LargeItemLimit},

    [switch]
    ${Suspend},

    [Alias('ov')]
    ${OutVariable},

    ${BatchName},

    [Alias('infa')]
    ${InformationAction},

    ${RemoteHostName},

    ${DomainController},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AcceptLargeDataLoss},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    ${BadItemLimit},

    [Alias('pv')]
    ${PipelineVariable},

    ${RemoteCredential},

    ${FilePath},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ExcludeFolders},

    ${SkipMerging},

    ${Name},

    ${SourceRootFolder},

    ${CompletedRequestAgeLimit},

    [switch]
    ${IsArchive},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailboxExportRequest') `
                            -Arg ('New-MailboxExportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailboxExportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailboxImportRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${ExcludeDumpster},

    ${ConflictResolutionOption},

    ${SourceEndpoint},

    ${AssociatedMessagesCopyOption},

    ${WorkloadType},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    ${InternalFlags},

    ${MigrationMailbox},

    ${RequestExpiryInterval},

    ${SuspendComment},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Name},

    ${IncludeFolders},

    ${LargeItemLimit},

    [switch]
    ${Suspend},

    [Alias('iv')]
    ${InformationVariable},

    ${BatchName},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AcceptLargeDataLoss},

    ${ContentCodePage},

    ${BadItemLimit},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${FilePath},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ExcludeFolders},

    ${SkipMerging},

    ${TargetRootFolder},

    ${SourceRootFolder},

    ${CompletedRequestAgeLimit},

    [switch]
    ${IsArchive},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailboxImportRequest') `
                            -Arg ('New-MailboxImportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailboxImportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailboxRelocationRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${IncrementalSyncInterval},

    ${SourceDatabase},

    ${TargetDatabase},

    ${Identity},

    [switch]
    ${ForceOffline},

    ${WorkloadType},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${RequestExpiryInterval},

    ${SuspendComment},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${LargeItemLimit},

    [switch]
    ${Suspend},

    ${BatchName},

    ${SkipMoving},

    [Alias('ov')]
    ${OutVariable},

    ${CompleteAfter},

    ${DomainController},

    ${InternalFlags},

    [switch]
    ${Protect},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AcceptLargeDataLoss},

    [Alias('iv')]
    ${InformationVariable},

    ${BadItemLimit},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailboxRelocationRequest') `
                            -Arg ('New-MailboxRelocationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailboxRelocationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailboxRepairRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${DetectOnly},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${CorruptionType},

    ${StoreMailbox},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${Archive},

    [Alias('wa')]
    ${WarningAction},

    [Alias('Identity')]
    ${Mailbox},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailboxRepairRequest') `
                            -Arg ('New-MailboxRepairRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailboxRepairRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailContact' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${ModeratedBy},

    ${ModerationEnabled},

    ${MacAttachmentFormat},

    ${DisplayName},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${LastName},

    [Alias('wv')]
    ${WarningVariable},

    ${UsePreferMessageFormat},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${ArbitrationMailbox},

    ${MessageBodyFormat},

    ${Initials},

    ${DomainController},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ExternalEmailAddress},

    [Alias('iv')]
    ${InformationVariable},

    ${Alias},

    ${MessageFormat},

    ${FirstName},

    ${PrimarySmtpAddress},

    ${SendModerationNotifications},

    [Alias('ob')]
    ${OutBuffer},

    ${OrganizationalUnit},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailContact') `
                            -Arg ('New-MailContact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailContact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MailUser' `
{
    param(
    
    ${Password},

    [Alias('wa')]
    ${WarningAction},

    ${ModeratedBy},

    ${ModerationEnabled},

    ${MacAttachmentFormat},

    ${DisplayName},

    ${UserPrincipalName},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${LastName},

    ${SamAccountName},

    ${ArbitrationMailbox},

    [Alias('wv')]
    ${WarningVariable},

    ${UsePreferMessageFormat},

    ${ImmutableId},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${MessageBodyFormat},

    ${Initials},

    ${DomainController},

    ${OrganizationalUnit},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ExternalEmailAddress},

    [Alias('iv')]
    ${InformationVariable},

    ${Alias},

    ${MessageFormat},

    ${FirstName},

    ${PrimarySmtpAddress},

    ${SendModerationNotifications},

    [Alias('ob')]
    ${OutBuffer},

    ${RemotePowerShellEnabled},

    ${Name},

    ${ResetPasswordOnNextLogon},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MailUser') `
                            -Arg ('New-MailUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MailUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-MoveRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${IncrementalSyncInterval},

    [Alias('ev')]
    ${ErrorVariable},

    ${TargetDatabase},

    ${Identity},

    [switch]
    ${SuspendWhenReadyToComplete},

    ${MoveOptions},

    ${RemoteArchiveTargetDatabase},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${ForceOffline},

    ${WorkloadType},

    ${StartAfter},

    ${RequestExpiryInterval},

    [Alias('infa')]
    ${InformationAction},

    ${InternalFlags},

    [switch]
    ${Suspend},

    [switch]
    ${PrimaryOnly},

    [switch]
    ${PreventCompletion},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [switch]
    ${ForcePush},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${LargeItemLimit},

    [switch]
    ${AllowLargeItems},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('ov')]
    ${OutVariable},

    ${BatchName},

    ${SkipMoving},

    ${RemoteHostName},

    ${SuspendComment},

    ${CompleteAfter},

    ${DomainController},

    [switch]
    ${Remote},

    [switch]
    ${RemoteLegacy},

    [switch]
    ${DoNotPreserveMailboxSignature},

    [switch]
    ${Protect},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${AcceptLargeDataLoss},

    [switch]
    ${ForcePull},

    [switch]
    ${ArchiveOnly},

    ${ArchiveTargetDatabase},

    ${RemoteTargetDatabase},

    ${BadItemLimit},

    ${ArchiveDomain},

    ${RemoteGlobalCatalog},

    ${TargetDeliveryDomain},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('db')]
    [switch]
    ${Debug},

    ${RemoteCredential},

    ${CompletedRequestAgeLimit},

    [switch]
    ${Outbound},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-MoveRequest') `
                            -Arg ('New-MoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-MoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-OwaMailboxPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-OwaMailboxPolicy') `
                            -Arg ('New-OwaMailboxPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-OwaMailboxPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-PublicFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${EformsLocaleId},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    ${Path},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-PublicFolder') `
                            -Arg ('New-PublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-PublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-PublicFolderMigrationRequest' `
{
    param(
    
    ${CSVStream},

    [Alias('wa')]
    ${WarningAction},

    ${SourceDatabase},

    ${SourceEndpoint},

    ${WorkloadType},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${MigrationMailbox},

    ${RequestExpiryInterval},

    ${SuspendComment},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${LargeItemLimit},

    [switch]
    ${Suspend},

    ${BatchName},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ov')]
    ${OutVariable},

    ${CSVData},

    ${DomainController},

    ${InternalFlags},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AcceptLargeDataLoss},

    [Alias('iv')]
    ${InformationVariable},

    ${BadItemLimit},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${SkipMerging},

    [Alias('ev')]
    ${ErrorVariable},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-PublicFolderMigrationRequest') `
                            -Arg ('New-PublicFolderMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-PublicFolderMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-PublicFolderMoveRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${SuspendWhenReadyToComplete},

    ${WorkloadType},

    ${Name},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Suspend},

    ${RequestExpiryInterval},

    ${SuspendComment},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${AllowLargeItems},

    [Alias('ov')]
    ${OutVariable},

    ${InternalFlags},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AcceptLargeDataLoss},

    [Alias('iv')]
    ${InformationVariable},

    ${BadItemLimit},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${Folders},

    [Alias('ob')]
    ${OutBuffer},

    ${DomainController},

    [Alias('ev')]
    ${ErrorVariable},

    ${CompletedRequestAgeLimit},

    ${TargetMailbox},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-PublicFolderMoveRequest') `
                            -Arg ('New-PublicFolderMoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-PublicFolderMoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-RemoteMailbox' `
{
    param(
    
    ${Password},

    [Alias('wa')]
    ${WarningAction},

    ${ModeratedBy},

    ${ModerationEnabled},

    ${DisplayName},

    ${ResetPasswordOnNextLogon},

    ${UserPrincipalName},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${LastName},

    ${SamAccountName},

    [Alias('wv')]
    ${WarningVariable},

    [switch]
    ${Archive},

    [switch]
    ${Equipment},

    ${ImmutableId},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${OnPremisesOrganizationalUnit},

    [switch]
    ${Shared},

    [Alias('ov')]
    ${OutVariable},

    [switch]
    ${Room},

    ${Initials},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${RemoteRoutingAddress},

    ${DomainController},

    [switch]
    ${AccountDisabled},

    [Alias('iv')]
    ${InformationVariable},

    ${Alias},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${FirstName},

    ${PrimarySmtpAddress},

    ${SendModerationNotifications},

    [Alias('ob')]
    ${OutBuffer},

    ${Name},

    ${RemotePowerShellEnabled},

    [switch]
    ${ACLableSyncedObjectEnabled},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-RemoteMailbox') `
                            -Arg ('New-RemoteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-RemoteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-SweepRule' `
{
    param(
    
    ${DomainController},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Name},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    ${Provider},

    ${SystemCategory},

    [Alias('db')]
    [switch]
    ${Debug},

    ${KeepLatest},

    ${ExceptIfFlagged},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${SourceFolder},

    ${Mailbox},

    ${DestinationFolder},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('ea')]
    ${ErrorAction},

    ${ExceptIfPinned},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${Sender},

    ${KeepForDays},

    ${Enabled},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-SweepRule') `
                            -Arg ('New-SweepRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-SweepRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:New-SyncMailPublicFolder' `
{
    param(
    
    ${WindowsEmailAddress},

    [Alias('wa')]
    ${WarningAction},

    ${CustomAttribute12},

    ${CustomAttribute10},

    ${RequireSenderAuthenticationEnabled},

    ${DeliverToMailboxAndForward},

    ${CustomAttribute8},

    ${DisplayName},

    ${CustomAttribute3},

    ${Name},

    [Alias('ev')]
    ${ErrorVariable},

    ${CustomAttribute7},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${ForwardingAddress},

    [switch]
    ${HiddenFromAddressListsEnabled},

    ${MaxSendSize},

    [Alias('wv')]
    ${WarningVariable},

    ${CustomAttribute6},

    ${CustomAttribute1},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${OverrideRecipientQuotas},

    ${CustomAttribute9},

    ${CustomAttribute14},

    ${RejectMessagesFrom},

    [Alias('ov')]
    ${OutVariable},

    ${MaxReceiveSize},

    ${Contacts},

    [Alias('infa')]
    ${InformationAction},

    ${AcceptMessagesOnlyFrom},

    ${CustomAttribute15},

    ${DomainController},

    ${CustomAttribute5},

    ${OnPremisesObjectId},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ExternalEmailAddress},

    ${CustomAttribute4},

    [Alias('iv')]
    ${InformationVariable},

    ${Alias},

    ${GrantSendOnBehalfTo},

    ${CustomAttribute2},

    ${CustomAttribute13},

    [Alias('ob')]
    ${OutBuffer},

    ${CustomAttribute11},

    ${EmailAddresses},

    ${EntryId},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'New-SyncMailPublicFolder') `
                            -Arg ('New-SyncMailPublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName New-SyncMailPublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Redirect-Message' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Target},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Redirect-Message') `
                            -Arg ('Redirect-Message', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Redirect-Message
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-ActiveSyncDevice' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-ActiveSyncDevice') `
                            -Arg ('Remove-ActiveSyncDevice', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-ActiveSyncDevice
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-DistributionGroup' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-DistributionGroup') `
                            -Arg ('Remove-DistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-DistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-DistributionGroupMember' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Member},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-DistributionGroupMember') `
                            -Arg ('Remove-DistributionGroupMember', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-DistributionGroupMember
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-DynamicDistributionGroup' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-DynamicDistributionGroup') `
                            -Arg ('Remove-DynamicDistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-DynamicDistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-HybridConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-HybridConfiguration') `
                            -Arg ('Remove-HybridConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-HybridConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-InboxRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AlwaysDeleteOutlookRulesBlob},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-InboxRule') `
                            -Arg ('Remove-InboxRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-InboxRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-LinkedUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-LinkedUser') `
                            -Arg ('Remove-LinkedUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-LinkedUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-Mailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${AuditLog},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Permanent},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${PublicFolder},

    [switch]
    ${Force},

    ${StoreMailboxIdentity},

    [switch]
    ${IgnoreDefaultScope},

    [switch]
    ${RemoveLastArbitrationMailboxAllowed},

    [switch]
    ${IgnoreLegalHold},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${AuxAuditLog},

    [switch]
    ${Arbitration},

    [switch]
    ${Migration},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${RemoveArbitrationMailboxWithOABsAllowed},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    ${Database},

    [switch]
    ${SupervisoryReviewPolicy},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-Mailbox') `
                            -Arg ('Remove-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxDatabase' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxDatabase') `
                            -Arg ('Remove-MailboxDatabase', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxDatabase
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxExportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${RequestGuid},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${RequestQueue},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxExportRequest') `
                            -Arg ('Remove-MailboxExportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxExportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxFolderPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxFolderPermission') `
                            -Arg ('Remove-MailboxFolderPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxFolderPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxImportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${RequestGuid},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${RequestQueue},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxImportRequest') `
                            -Arg ('Remove-MailboxImportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxImportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxLocation' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxLocation') `
                            -Arg ('Remove-MailboxLocation', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxLocation
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxPermission' `
{
    param(
    
    ${DomainController},

    [switch]
    ${ClearAutoMapping},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    ${AccessRights},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Deny},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${ResetDefault},

    ${InheritanceType},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${Instance},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxPermission') `
                            -Arg ('Remove-MailboxPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxRepairRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxRepairRequest') `
                            -Arg ('Remove-MailboxRepairRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxRepairRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailboxUserConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailboxUserConfiguration') `
                            -Arg ('Remove-MailboxUserConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailboxUserConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailContact' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailContact') `
                            -Arg ('Remove-MailContact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailContact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MailUser' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IgnoreLegalHold},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MailUser') `
                            -Arg ('Remove-MailUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MailUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-Message' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    ${WithNDR},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Filter},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-Message') `
                            -Arg ('Remove-Message', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-Message
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MobileDevice' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MobileDevice') `
                            -Arg ('Remove-MobileDevice', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MobileDevice
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    ${MailboxGuid},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    ${MoveRequestQueue},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MoveRequest') `
                            -Arg ('Remove-MoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-MRSRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${RequestGuid},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${RequestQueue},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-MRSRequest') `
                            -Arg ('Remove-MRSRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-MRSRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-OwaMailboxPolicy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-OwaMailboxPolicy') `
                            -Arg ('Remove-OwaMailboxPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-OwaMailboxPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-PublicFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [switch]
    ${Recurse},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-PublicFolder') `
                            -Arg ('Remove-PublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-PublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-PublicFolderClientPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-PublicFolderClientPermission') `
                            -Arg ('Remove-PublicFolderClientPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-PublicFolderClientPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-PublicFolderMailboxMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${RequestGuid},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${RequestQueue},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-PublicFolderMailboxMigrationRequest') `
                            -Arg ('Remove-PublicFolderMailboxMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-PublicFolderMailboxMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-PublicFolderMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${RequestGuid},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${RequestQueue},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-PublicFolderMigrationRequest') `
                            -Arg ('Remove-PublicFolderMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-PublicFolderMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-PublicFolderMoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${RequestGuid},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${RequestQueue},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-PublicFolderMoveRequest') `
                            -Arg ('Remove-PublicFolderMoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-PublicFolderMoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-PushNotificationSubscription' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${RemoveStorage},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    ${SubscriptionStoreId},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Force},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-PushNotificationSubscription') `
                            -Arg ('Remove-PushNotificationSubscription', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-PushNotificationSubscription
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-RemoteMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${IgnoreLegalHold},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-RemoteMailbox') `
                            -Arg ('Remove-RemoteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-RemoteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-ResubmitRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-ResubmitRequest') `
                            -Arg ('Remove-ResubmitRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-ResubmitRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-StoreMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${MailboxState},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-StoreMailbox') `
                            -Arg ('Remove-StoreMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-StoreMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-SweepRule' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Mailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-SweepRule') `
                            -Arg ('Remove-SweepRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-SweepRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-SyncMailPublicFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-SyncMailPublicFolder') `
                            -Arg ('Remove-SyncMailPublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-SyncMailPublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Remove-UserPhoto' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${PhotoType},

    ${DomainController},

    [switch]
    ${ClearMailboxPhotoRecord},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Remove-UserPhoto') `
                            -Arg ('Remove-UserPhoto', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Remove-UserPhoto
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Restore-RecoverableItems' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wa')]
    ${WarningAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${SourceFolder},

    ${EntryID},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    ${LastParentFolderID},

    ${FilterEndTime},

    ${FilterStartTime},

    ${ResultSize},

    ${FilterItemType},

    ${SubjectContains},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Restore-RecoverableItems') `
                            -Arg ('Restore-RecoverableItems', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Restore-RecoverableItems
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-MailboxExportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-MailboxExportRequest') `
                            -Arg ('Resume-MailboxExportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-MailboxExportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-MailboxImportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-MailboxImportRequest') `
                            -Arg ('Resume-MailboxImportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-MailboxImportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-Message' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Filter},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-Message') `
                            -Arg ('Resume-Message', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-Message
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-MoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${SuspendWhenReadyToComplete},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-MoveRequest') `
                            -Arg ('Resume-MoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-MoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-MRSRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-MRSRequest') `
                            -Arg ('Resume-MRSRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-MRSRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-PublicFolderMailboxMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-PublicFolderMailboxMigrationRequest') `
                            -Arg ('Resume-PublicFolderMailboxMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-PublicFolderMailboxMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-PublicFolderMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-PublicFolderMigrationRequest') `
                            -Arg ('Resume-PublicFolderMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-PublicFolderMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-PublicFolderMoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-PublicFolderMoveRequest') `
                            -Arg ('Resume-PublicFolderMoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-PublicFolderMoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Resume-Queue' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Filter},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Resume-Queue') `
                            -Arg ('Resume-Queue', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Resume-Queue
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Retry-Queue' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Resubmit},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Filter},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Retry-Queue') `
                            -Arg ('Retry-Queue', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Retry-Queue
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Search-Mailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${IncludeUnsearchableItems},

    ${Identity},

    [switch]
    ${LogOnly},

    [switch]
    ${DoNotIncludeArchive},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${SearchQuery},

    [switch]
    ${Force},

    [Alias('wv')]
    ${WarningVariable},

    ${LogLevel},

    [switch]
    ${SearchDumpster},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${SearchDumpsterOnly},

    ${TargetFolder},

    [switch]
    ${EstimateResultOnly},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${DeleteContent},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${TargetMailbox},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Search-Mailbox') `
                            -Arg ('Search-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Search-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-ADServerSettings' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${ConfigurationDomainController},

    ${ViewEntireForest},

    ${PreferredServer},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${PreferredGlobalCatalog},

    [Alias('ob')]
    ${OutBuffer},

    ${RunspaceServerSettings},

    [Alias('wa')]
    ${WarningAction},

    ${RecipientViewRoot},

    ${SetPreferredDomainControllers},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-ADServerSettings') `
                            -Arg ('Set-ADServerSettings', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-ADServerSettings
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-CalendarProcessing' `
{
    param(
    
    ${MaximumConflictInstances},

    [Alias('wa')]
    ${WarningAction},

    ${ForwardRequestsToDelegates},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Identity},

    ${ResourceDelegates},

    ${DeleteNonCalendarItems},

    ${RemovePrivateProperty},

    ${DeleteComments},

    ${EnforceSchedulingHorizon},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    ${EnableResponseDetails},

    ${RequestInPolicy},

    [switch]
    ${IgnoreDefaultScope},

    ${AllowConflicts},

    ${AllRequestInPolicy},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${BookInPolicy},

    ${ConflictPercentageAllowed},

    ${AutomateProcessing},

    ${AllRequestOutOfPolicy},

    ${AddNewRequestsTentatively},

    [Alias('ov')]
    ${OutVariable},

    ${AllBookInPolicy},

    ${ProcessExternalMeetingMessages},

    ${DeleteAttachments},

    ${ScheduleOnlyDuringWorkHours},

    ${DomainController},

    ${AdditionalResponse},

    ${TentativePendingApproval},

    [Alias('pv')]
    ${PipelineVariable},

    ${MaximumDurationInMinutes},

    ${OrganizerInfo},

    ${RequestOutOfPolicy},

    ${RemoveOldMeetingMessages},

    [Alias('iv')]
    ${InformationVariable},

    ${BookingWindowInDays},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${AddAdditionalResponse},

    ${RemoveForwardedMeetingNotifications},

    ${DeleteSubject},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('db')]
    [switch]
    ${Debug},

    ${AllowRecurringMeetings},

    ${AddOrganizerToSubject},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-CalendarProcessing') `
                            -Arg ('Set-CalendarProcessing', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-CalendarProcessing
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-CASMailbox' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${PopEnableExactRFC822Size},

    ${IsOptimizedForAccessibility},

    ${ImapEnabled},

    ${ImapSuppressReadReceipt},

    ${ActiveSyncSuppressReadReceipt},

    ${Identity},

    ${EwsBlockList},

    ${EwsAllowEntourage},

    ${ECPEnabled},

    ${DisplayName},

    ${PopUseProtocolDefaults},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${MAPIBlockOutlookVersions},

    ${ShowGalAsDefaultView},

    [Alias('infa')]
    ${InformationAction},

    ${ImapEnableExactRFC822Size},

    ${PopForceICalForCalendarRetrievalOption},

    [Alias('pv')]
    ${PipelineVariable},

    ${ImapForceICalForCalendarRetrievalOption},

    ${SamAccountName},

    [switch]
    ${IgnoreDefaultScope},

    ${EmailAddresses},

    ${MAPIEnabled},

    ${EwsAllowOutlook},

    [Alias('ea')]
    ${ErrorAction},

    ${PopEnabled},

    ${PrimarySmtpAddress},

    ${EwsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    ${MAPIBlockOutlookRpcHttp},

    ${EwsAllowMacOutlook},

    ${EwsApplicationAccessPolicy},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ob')]
    ${OutBuffer},

    ${MAPIBlockOutlookExternalConnectivity},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${OWAEnabled},

    ${DomainController},

    ${ActiveSyncEnabled},

    ${ActiveSyncMailboxPolicy},

    ${MAPIBlockOutlookNonCachedMode},

    ${ImapUseProtocolDefaults},

    ${ActiveSyncDebugLogging},

    ${OWAforDevicesEnabled},

    ${ImapMessagesRetrievalMimeFormat},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('wv')]
    ${WarningVariable},

    ${MapiHttpEnabled},

    ${PopSuppressReadReceipt},

    ${OwaMailboxPolicy},

    ${Name},

    ${EwsAllowList},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${PopMessagesRetrievalMimeFormat},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-CASMailbox') `
                            -Arg ('Set-CASMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-CASMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-Contact' `
{
    param(
    
    ${Company},

    [Alias('wa')]
    ${WarningAction},

    ${Phone},

    ${DisplayName},

    ${Identity},

    ${Office},

    ${CountryOrRegion},

    ${OtherTelephone},

    ${Pager},

    [Alias('ev')]
    ${ErrorVariable},

    ${PhoneticDisplayName},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Fax},

    ${PostOfficeBox},

    ${LastName},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ea')]
    ${ErrorAction},

    ${SeniorityIndex},

    ${City},

    ${TelephoneAssistant},

    ${WindowsEmailAddress},

    ${Title},

    ${MobilePhone},

    ${AssistantName},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ov')]
    ${OutVariable},

    ${StateOrProvince},

    [Alias('ob')]
    ${OutBuffer},

    ${Initials},

    [Alias('pv')]
    ${PipelineVariable},

    ${WebPage},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${DomainController},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Manager},

    ${HomePhone},

    ${OtherFax},

    ${SimpleDisplayName},

    [Alias('iv')]
    ${InformationVariable},

    ${Department},

    [Alias('wv')]
    ${WarningVariable},

    ${OtherHomePhone},

    ${FirstName},

    ${Notes},

    ${Name},

    ${GeoCoordinates},

    ${StreetAddress},

    ${PostalCode},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-Contact') `
                            -Arg ('Set-Contact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-Contact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-DistributionGroup' `
{
    param(
    
    ${EmailAddresses},

    ${RejectMessagesFromDLMembers},

    [switch]
    ${RoomList},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    [Alias('wa')]
    ${WarningAction},

    [Alias('iv')]
    ${InformationVariable},

    ${ExtensionCustomAttribute5},

    ${CustomAttribute8},

    ${CustomAttribute5},

    ${SimpleDisplayName},

    [switch]
    ${IgnoreNamingPolicy},

    ${ReportToManagerEnabled},

    ${MailTip},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${GrantSendOnBehalfTo},

    ${AcceptMessagesOnlyFrom},

    ${BypassNestedModerationEnabled},

    ${ModerationEnabled},

    ${MemberDepartRestriction},

    ${MaxReceiveSize},

    [Alias('ov')]
    ${OutVariable},

    ${EmailAddressPolicyEnabled},

    ${CustomAttribute15},

    [switch]
    ${IgnoreDefaultScope},

    ${RejectMessagesFromSendersOrMembers},

    ${WindowsEmailAddress},

    ${RejectMessagesFrom},

    ${Alias},

    ${DisplayName},

    ${ReportToOriginatorEnabled},

    [Alias('pv')]
    ${PipelineVariable},

    ${BypassModerationFromSendersOrMembers},

    ${AcceptMessagesOnlyFromDLMembers},

    ${CustomAttribute1},

    [switch]
    ${ForceUpgrade},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ManagedBy},

    [Alias('infa')]
    ${InformationAction},

    ${ExtensionCustomAttribute1},

    ${CustomAttribute14},

    ${RequireSenderAuthenticationEnabled},

    ${CustomAttribute9},

    ${CustomAttribute6},

    ${SendOofMessageToOriginatorEnabled},

    ${ExtensionCustomAttribute4},

    [Alias('ob')]
    ${OutBuffer},

    ${CustomAttribute7},

    ${ExtensionCustomAttribute2},

    ${CustomAttribute13},

    ${CustomAttribute2},

    ${PrimarySmtpAddress},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${SendModerationNotifications},

    ${MaxSendSize},

    ${MemberJoinRestriction},

    [Alias('wv')]
    ${WarningVariable},

    ${MailTipTranslations},

    [Alias('ea')]
    ${ErrorAction},

    ${CustomAttribute4},

    ${CustomAttribute10},

    ${DomainController},

    ${SamAccountName},

    ${Name},

    ${ExpansionServer},

    ${ExtensionCustomAttribute3},

    ${CustomAttribute12},

    ${CustomAttribute3},

    ${CustomAttribute11},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Identity},

    ${HiddenFromAddressListsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-DistributionGroup') `
                            -Arg ('Set-DistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-DistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-DynamicDistributionGroup' `
{
    param(
    
    ${EmailAddresses},

    ${ConditionalCustomAttribute6},

    ${ModerationEnabled},

    [Alias('wa')]
    ${WarningAction},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    ${ConditionalCustomAttribute7},

    ${CustomAttribute12},

    ${CustomAttribute10},

    ${ExtensionCustomAttribute5},

    ${CustomAttribute8},

    [Alias('ov')]
    ${OutVariable},

    ${CustomAttribute5},

    ${AcceptMessagesOnlyFromDLMembers},

    ${ConditionalCustomAttribute2},

    ${ConditionalCustomAttribute1},

    ${PhoneticDisplayName},

    ${MailTip},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${GrantSendOnBehalfTo},

    [Alias('ea')]
    ${ErrorAction},

    ${AcceptMessagesOnlyFrom},

    [Alias('iv')]
    ${InformationVariable},

    ${ConditionalCustomAttribute9},

    ${MaxReceiveSize},

    ${ConditionalCustomAttribute4},

    ${EmailAddressPolicyEnabled},

    ${CustomAttribute15},

    ${RejectMessagesFromSendersOrMembers},

    ${WindowsEmailAddress},

    ${ConditionalCustomAttribute13},

    ${RejectMessagesFromDLMembers},

    ${RejectMessagesFrom},

    ${Alias},

    ${DisplayName},

    ${ReportToOriginatorEnabled},

    [Alias('pv')]
    ${PipelineVariable},

    ${BypassModerationFromSendersOrMembers},

    ${IncludedRecipients},

    ${ConditionalCustomAttribute12},

    ${CustomAttribute1},

    ${ReportToManagerEnabled},

    [switch]
    ${ForceUpgrade},

    ${ConditionalCustomAttribute14},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ManagedBy},

    [Alias('infa')]
    ${InformationAction},

    ${ExtensionCustomAttribute1},

    ${Notes},

    ${CustomAttribute14},

    ${RequireSenderAuthenticationEnabled},

    ${CustomAttribute9},

    ${RecipientFilter},

    ${CustomAttribute6},

    ${SendOofMessageToOriginatorEnabled},

    ${ExtensionCustomAttribute4},

    ${SimpleDisplayName},

    [Alias('ob')]
    ${OutBuffer},

    ${ConditionalCompany},

    ${CustomAttribute7},

    ${ConditionalStateOrProvince},

    ${CustomAttribute13},

    ${CustomAttribute2},

    ${PrimarySmtpAddress},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ConditionalCustomAttribute15},

    ${SendModerationNotifications},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${MaxSendSize},

    [Alias('wv')]
    ${WarningVariable},

    ${ConditionalCustomAttribute10},

    ${ConditionalCustomAttribute5},

    ${CustomAttribute11},

    ${MailTipTranslations},

    ${ConditionalCustomAttribute8},

    ${CustomAttribute4},

    ${RecipientContainer},

    ${DomainController},

    ${ExtensionCustomAttribute2},

    ${ConditionalCustomAttribute3},

    ${Name},

    ${ExpansionServer},

    ${ExtensionCustomAttribute3},

    ${ConditionalDepartment},

    ${CustomAttribute3},

    ${ConditionalCustomAttribute11},

    [switch]
    ${IgnoreDefaultScope},

    ${Identity},

    ${HiddenFromAddressListsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-DynamicDistributionGroup') `
                            -Arg ('Set-DynamicDistributionGroup', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-DynamicDistributionGroup
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-Group' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    ${IsHierarchicalGroup},

    ${DisplayName},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${SimpleDisplayName},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Universal},

    ${Notes},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ov')]
    ${OutVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${Name},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    ${PhoneticDisplayName},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${ManagedBy},

    ${SeniorityIndex},

    ${DomainController},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${WindowsEmailAddress},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-Group') `
                            -Arg ('Set-Group', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-Group
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-HybridConfiguration' `
{
    param(
    
    ${ServiceInstance},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${EdgeTransportServers},

    ${Name},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ReceivingTransportServers},

    ${TlsCertificateName},

    ${SendingTransportServers},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Features},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ExternalIPAddresses},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${ClientAccessServers},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ea')]
    ${ErrorAction},

    ${OnPremisesSmartHost},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    ${Domains},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-HybridConfiguration') `
                            -Arg ('Set-HybridConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-HybridConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-InboxRule' `
{
    param(
    
    ${ExceptIfMyNameNotInToBox},

    ${ExceptIfMyNameInToOrCcBox},

    [Alias('wa')]
    ${WarningAction},

    ${PinMessage},

    ${WithinSizeRangeMaximum},

    ${ReceivedBeforeDate},

    ${ExceptIfFromAddressContainsWords},

    ${ExceptIfWithinSizeRangeMaximum},

    ${WithinSizeRangeMinimum},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${MyNameInToOrCcBox},

    ${ExceptIfReceivedBeforeDate},

    ${Mailbox},

    [Alias('ea')]
    ${ErrorAction},

    ${ExceptIfFrom},

    ${RedirectTo},

    ${ReceivedAfterDate},

    ${ForwardTo},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    ${ExceptIfReceivedAfterDate},

    [Alias('ov')]
    ${OutVariable},

    ${ExceptIfWithImportance},

    ${HeaderContainsWords},

    ${ExceptIfSentOnlyToMe},

    ${ExceptIfSubjectOrBodyContainsWords},

    ${ExceptIfMessageTypeMatches},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ExceptIfHasAttachment},

    ${DeleteMessage},

    ${ExceptIfMyNameInToBox},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${AlwaysDeleteOutlookRulesBlob},

    ${From},

    ${RecipientAddressContainsWords},

    ${FlaggedForAction},

    ${WithSensitivity},

    [Alias('infa')]
    ${InformationAction},

    ${CopyToFolder},

    ${ExceptIfSubjectContainsWords},

    ${MarkImportance},

    ${Priority},

    ${ApplyCategory},

    ${SubjectContainsWords},

    ${ExceptIfHeaderContainsWords},

    ${ExceptIfWithSensitivity},

    ${ExceptIfRecipientAddressContainsWords},

    ${HasAttachment},

    ${SubjectOrBodyContainsWords},

    ${ExceptIfFlaggedForAction},

    ${BodyContainsWords},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${StopProcessingRules},

    ${DeleteSystemCategory},

    ${ExceptIfWithinSizeRangeMinimum},

    ${MessageTypeMatches},

    [Alias('wv')]
    ${WarningVariable},

    ${ApplySystemCategory},

    ${MarkAsRead},

    ${MoveToFolder},

    ${SentTo},

    ${MyNameInCcBox},

    ${DomainController},

    ${WithImportance},

    ${MyNameInToBox},

    ${ExceptIfSentTo},

    [switch]
    ${Force},

    ${SentOnlyToMe},

    ${Name},

    ${ForwardAsAttachmentTo},

    ${ExceptIfBodyContainsWords},

    ${ExceptIfMyNameInCcBox},

    ${FromAddressContainsWords},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${MyNameNotInToBox},

    ${Identity},

    ${HasClassification},

    ${ExceptIfHasClassification},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-InboxRule') `
                            -Arg ('Set-InboxRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-InboxRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-LinkedUser' `
{
    param(
    
    ${Company},

    [Alias('wa')]
    ${WarningAction},

    ${Phone},

    ${DisplayName},

    ${Identity},

    ${Office},

    ${CountryOrRegion},

    ${OtherTelephone},

    ${UserPrincipalName},

    ${CertificateSubject},

    [Alias('ev')]
    ${ErrorVariable},

    ${PhoneticDisplayName},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Fax},

    ${PostOfficeBox},

    ${LastName},

    ${SamAccountName},

    ${Pager},

    [switch]
    ${IgnoreDefaultScope},

    ${LinkedCredential},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${City},

    ${TelephoneAssistant},

    ${AllowUMCallsFromNonUsers},

    ${Title},

    ${MobilePhone},

    ${AssistantName},

    ${CreateDTMFMap},

    [Alias('ov')]
    ${OutVariable},

    ${StateOrProvince},

    [Alias('ob')]
    ${OutBuffer},

    ${Initials},

    [Alias('pv')]
    ${PipelineVariable},

    ${WebPage},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${DomainController},

    ${LinkedDomainController},

    ${LinkedMasterAccount},

    ${Manager},

    ${HomePhone},

    ${OtherFax},

    ${SimpleDisplayName},

    [Alias('iv')]
    ${InformationVariable},

    ${Department},

    [Alias('wv')]
    ${WarningVariable},

    ${OtherHomePhone},

    ${FirstName},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${WindowsEmailAddress},

    ${Notes},

    ${Name},

    ${ResetPasswordOnNextLogon},

    ${StreetAddress},

    ${PostalCode},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-LinkedUser') `
                            -Arg ('Set-LinkedUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-LinkedUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-Mailbox' `
{
    param(
    
    ${WindowsEmailAddress},

    ${RecoverableItemsWarningQuota},

    ${CustomAttribute1},

    ${UserPrincipalName},

    ${AccountDisabled},

    ${Languages},

    [Alias('ov')]
    ${OutVariable},

    ${CustomAttribute3},

    [switch]
    ${Force},

    ${FolderHierarchyChildrenCountReceiveQuota},

    ${SecondaryAddress},

    ${ArbitrationMailbox},

    ${RetentionUrl},

    ${MaxSafeSenders},

    ${BypassModerationFromSendersOrMembers},

    ${MessageTrackingReadStatusEnabled},

    ${MaxReceiveSize},

    [Alias('infa')]
    ${InformationAction},

    ${RetentionPolicy},

    ${SharingPolicy},

    ${HiddenFromAddressListsEnabled},

    ${LitigationHoldDuration},

    ${CustomAttribute11},

    ${CalendarRepairDisabled},

    ${UMGrammar},

    ${OMEncryption},

    [switch]
    ${RemoveManagedFolderAndPolicy},

    ${StartDateForRetentionHold},

    ${MaxBlockedSenders},

    ${CalendarVersionStoreDisabled},

    [switch]
    ${AuxAuditLog},

    ${GrantSendOnBehalfTo},

    ${CustomAttribute13},

    ${IssueWarningQuota},

    ${AttributesToClear},

    [Alias('ob')]
    ${OutBuffer},

    ${Alias},

    ${FoldersCountWarningQuota},

    [switch]
    ${PublicFolder},

    ${RetentionComment},

    ${QueryBaseDN},

    ${OABGen},

    ${LitigationHoldEnabled},

    ${PstProvider},

    ${Migration},

    ${RetentionHoldEnabled},

    ${RecoverableItemsQuota},

    [switch]
    ${AuditLog},

    ${CustomAttribute4},

    ${FolderHierarchyDepthWarningQuota},

    ${IsHierarchyReady},

    ${StsRefreshTokensValidFrom},

    ${ExtendedPropertiesCountQuota},

    ${RoomMailboxPassword},

    ${ClientExtensions},

    ${SCLDeleteThreshold},

    ${AntispamBypassEnabled},

    ${DumpsterMessagesPerFolderCountWarningQuota},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${SystemMessageSizeShutoffQuota},

    ${AcceptMessagesOnlyFrom},

    ${MailboxMessagesPerFolderCountWarningQuota},

    ${ProhibitSendQuota},

    ${CustomAttribute6},

    ${CustomAttribute15},

    [switch]
    ${RemoveSpokenName},

    ${UserSMimeCertificate},

    ${IsExcludedFromServingHierarchy},

    ${FoldersCountReceiveQuota},

    ${MailTip},

    ${CustomAttribute10},

    ${EmailAddresses},

    ${LitigationHoldDate},

    [switch]
    ${IgnoreDefaultScope},

    ${SCLRejectEnabled},

    ${CustomAttribute12},

    ${RemoteRecipientType},

    ${DumpsterMessagesPerFolderCountReceiveQuota},

    ${DomainController},

    ${ExtensionCustomAttribute5},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    ${RejectMessagesFromSendersOrMembers},

    ${CalendarLoggingQuota},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${ResetPasswordOnNextLogon},

    ${ArchiveStatus},

    ${CustomAttribute5},

    ${SendModerationNotifications},

    ${SimpleDisplayName},

    ${RulesQuota},

    ${SCLQuarantineThreshold},

    ${DefaultPublicFolderMailbox},

    ${PrimarySmtpAddress},

    ${SingleItemRecoveryEnabled},

    ${AddressBookPolicy},

    ${ArchiveDomain},

    ${UseDatabaseQuotaDefaults},

    ${SystemMessageSizeWarningQuota},

    ${CustomAttribute7},

    ${RequireSenderAuthenticationEnabled},

    ${Type},

    ${ExternalOofOptions},

    ${CustomAttribute14},

    ${ExtensionCustomAttribute4},

    [Alias('pv')]
    ${PipelineVariable},

    ${Management},

    ${SCLJunkThreshold},

    ${CustomAttribute9},

    [Alias('iv')]
    ${InformationVariable},

    ${ArchiveName},

    ${MessageTracking},

    ${MessageCopyForSendOnBehalfEnabled},

    ${ModerationEnabled},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${Arbitration},

    ${UMDataStorage},

    ${SCLJunkEnabled},

    ${Office},

    [switch]
    ${RemovePicture},

    ${Name},

    [Alias('wv')]
    ${WarningVariable},

    ${DowngradeHighPriorityMessagesEnabled},

    ${RecipientLimits},

    ${RetainDeletedItemsFor},

    [switch]
    ${ApplyMandatoryProperties},

    ${RetainDeletedItemsUntilBackup},

    ${LinkedMasterAccount},

    ${ForwardingSmtpAddress},

    ${Identity},

    ${UserCertificate},

    ${ModeratedBy},

    ${UseDatabaseRetentionDefaults},

    ${OMEncryptionStore},

    ${DisplayName},

    ${OfflineAddressBook},

    ${LinkedCredential},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ImmutableId},

    ${MailboxMessagesPerFolderCountReceiveQuota},

    ${ResourceCapacity},

    ${SamAccountName},

    ${EndDateForRetentionHold},

    ${LitigationHoldOwner},

    ${ExtensionCustomAttribute2},

    ${MaxSendSize},

    ${EmailAddressPolicyEnabled},

    ${RoleAssignmentPolicy},

    ${RejectMessagesFrom},

    ${FolderHierarchyDepthReceiveQuota},

    ${ProhibitSendReceiveQuota},

    ${ForwardingAddress},

    ${MessageCopyForSentAsEnabled},

    ${GMGen},

    ${RejectMessagesFromDLMembers},

    ${ArchiveWarningQuota},

    ${SCLRejectThreshold},

    ${AcceptMessagesOnlyFromDLMembers},

    [Alias('ev')]
    ${ErrorVariable},

    ${ArchiveQuota},

    [switch]
    ${SkipDualWrite},

    ${CustomAttribute8},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${FolderHierarchyChildrenCountWarningQuota},

    ${ResourceCustom},

    ${DeliverToMailboxAndForward},

    ${ExtensionCustomAttribute1},

    ${IsHierarchySyncEnabled},

    ${LinkedDomainController},

    ${SCLQuarantineEnabled},

    ${SCLDeleteEnabled},

    ${MailTipTranslations},

    ${CustomAttribute2},

    ${EnableRoomMailboxAccount},

    [Alias('ea')]
    ${ErrorAction},

    ${ExtensionCustomAttribute3},

    ${ThrottlingPolicy},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-Mailbox') `
                            -Arg ('Set-Mailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-Mailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxAutoReplyConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    ${ExternalMessage},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    ${ExternalAudience},

    [Alias('db')]
    [switch]
    ${Debug},

    ${StartTime},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${InternalMessage},

    [Alias('wa')]
    ${WarningAction},

    ${AutoReplyState},

    ${DomainController},

    ${EndTime},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxAutoReplyConfiguration') `
                            -Arg ('Set-MailboxAutoReplyConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxAutoReplyConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxCalendarConfiguration' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${ConversationalSchedulingEnabled},

    ${SkipAgendaMailOnFreeDays},

    ${Identity},

    ${AgendaMailEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    ${DefaultMeetingDuration},

    ${WorkingHoursEndTime},

    [Alias('wv')]
    ${WarningVariable},

    ${UseBrightCalendarColorThemeInOwa},

    ${DefaultReminderTime},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${ReminderSoundEnabled},

    ${ShowWeekNumbers},

    ${RemindersEnabled},

    ${WeekStartDay},

    ${FirstWeekOfYear},

    [Alias('ov')]
    ${OutVariable},

    ${WorkingHoursStartTime},

    ${DailyAgendaMailSchedule},

    ${DomainController},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${TimeIncrement},

    ${WorkingHoursTimeZone},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('db')]
    [switch]
    ${Debug},

    ${WorkDays},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxCalendarConfiguration') `
                            -Arg ('Set-MailboxCalendarConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxCalendarConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxCalendarFolder' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${DetailLevel},

    [switch]
    ${UseHttps},

    [switch]
    ${SetAsSharingSource},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${SearchableUrlEnabled},

    ${PublishEnabled},

    ${PublishDateRangeTo},

    ${PublishDateRangeFrom},

    [Alias('ob')]
    ${OutBuffer},

    [switch]
    ${ResetUrl},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxCalendarFolder') `
                            -Arg ('Set-MailboxCalendarFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxCalendarFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxDatabase' `
{
    param(
    
    ${AutoDagExcludeFromMonitoring},

    [Alias('wa')]
    ${WarningAction},

    ${RetainDeletedItemsUntilBackup},

    ${IsSuspendedFromProvisioning},

    ${Identity},

    ${OfflineAddressBook},

    ${AllowFileRestore},

    ${IsExcludedFromProvisioningDueToLogicalCorruption},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ev')]
    ${ErrorVariable},

    ${IssueWarningQuota},

    [Alias('infa')]
    ${InformationAction},

    ${IsExcludedFromProvisioning},

    ${JournalRecipient},

    ${PublicFolderDatabase},

    ${IndexEnabled},

    ${DataMoveReplicationConstraint},

    ${BackgroundDatabaseMaintenance},

    ${QuotaNotificationSchedule},

    ${MaintenanceSchedule},

    [Alias('ea')]
    ${ErrorAction},

    ${RecoverableItemsQuota},

    ${CalendarLoggingQuota},

    ${IsExcludedFromProvisioningReason},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${CircularLoggingEnabled},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ProhibitSendQuota},

    [Alias('ov')]
    ${OutVariable},

    ${ProhibitSendReceiveQuota},

    ${IsExcludedFromInitialProvisioning},

    ${DomainController},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${MailboxRetention},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${EventHistoryRetentionPeriod},

    ${MountAtStartup},

    ${RecoverableItemsWarningQuota},

    [Alias('ob')]
    ${OutBuffer},

    ${Name},

    ${DeletedItemRetention},

    ${DatabaseGroup},

    ${IsExcludedFromProvisioningByOperator},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxDatabase') `
                            -Arg ('Set-MailboxDatabase', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxDatabase
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxExportRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${RequestExpiryInterval},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${SkipMerging},

    ${LargeItemLimit},

    [Alias('ov')]
    ${OutVariable},

    ${BatchName},

    [switch]
    ${RehomeRequest},

    ${RemoteHostName},

    ${DomainController},

    ${InternalFlags},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${AcceptLargeDataLoss},

    [Alias('iv')]
    ${InformationVariable},

    ${BadItemLimit},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    ${RemoteCredential},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxExportRequest') `
                            -Arg ('Set-MailboxExportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxExportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxFolderPermission' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    ${AccessRights},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${User},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxFolderPermission') `
                            -Arg ('Set-MailboxFolderPermission', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxFolderPermission
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxImportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    ${LargeItemLimit},

    ${Priority},

    [Alias('ov')]
    ${OutVariable},

    ${BadItemLimit},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${InternalFlags},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${BatchName},

    ${SkipMerging},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${AcceptLargeDataLoss},

    ${RequestExpiryInterval},

    [switch]
    ${RehomeRequest},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxImportRequest') `
                            -Arg ('Set-MailboxImportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxImportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxJunkEmailConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    ${TrustedSendersAndDomains},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${TrustedListsOnly},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    ${BlockedSendersAndDomains},

    [Alias('wa')]
    ${WarningAction},

    ${ContactsTrusted},

    ${DomainController},

    ${TrustedRecipientsAndDomains},

    ${Enabled},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxJunkEmailConfiguration') `
                            -Arg ('Set-MailboxJunkEmailConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxJunkEmailConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxLocation' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxLocation') `
                            -Arg ('Set-MailboxLocation', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxLocation
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxMessageConfiguration' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${AutoAddSignature},

    ${NewItemNotification},

    ${SignatureText},

    ${ShowPreviewTextInListView},

    ${ShowReadingPaneOnFirstLoad},

    ${Identity},

    ${LinkPreviewEnabled},

    ${AfterMoveOrDeleteBehavior},

    ${DefaultFontColor},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${GlobalReadingPanePosition},

    ${PreviewMarkAsReadDelaytime},

    [Alias('ev')]
    ${ErrorVariable},

    ${AlwaysShowFrom},

    ${ShowSenderOnTopInListView},

    [Alias('pv')]
    ${PipelineVariable},

    ${IsReplyAllTheDefaultResponse},

    ${SignatureHtml},

    [switch]
    ${IgnoreDefaultScope},

    ${UseDefaultSignatureOnMobile},

    ${DefaultFontName},

    ${NavigationPaneViewOption},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${EmailComposeMode},

    ${AutoAddSignatureOnReply},

    ${HideDeletedItems},

    ${ShowConversationAsTree},

    ${CheckForForgottenAttachments},

    ${IsFavoritesFolderTreeCollapsed},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ov')]
    ${OutVariable},

    ${SignatureTextOnMobile},

    ${IsMailRootFolderTreeCollapsed},

    [Alias('ob')]
    ${OutBuffer},

    ${ConversationSortOrder},

    ${ShowUpNext},

    ${PreferAccessibleContent},

    ${EmptyDeletedItemsOnLogoff},

    ${ReadReceiptResponse},

    [Alias('wv')]
    ${WarningVariable},

    ${DefaultFontSize},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('db')]
    [switch]
    ${Debug},

    ${MailFolderPaneExpanded},

    ${AlwaysShowBcc},

    ${DomainController},

    ${AutoAddSignatureOnMobile},

    ${PreviewMarkAsReadBehavior},

    ${DefaultFontFlags},

    ${DefaultFormat},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxMessageConfiguration') `
                            -Arg ('Set-MailboxMessageConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxMessageConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxRegionalConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${DateFormat},

    ${TimeFormat},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${LocalizeDefaultFolderName},

    ${TimeZone},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Language},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxRegionalConfiguration') `
                            -Arg ('Set-MailboxRegionalConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxRegionalConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxRelocationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Priority},

    ${SkipMoving},

    ${BadItemLimit},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${BatchName},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${AcceptLargeDataLoss},

    ${RequestExpiryInterval},

    [switch]
    ${RehomeRequest},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxRelocationRequest') `
                            -Arg ('Set-MailboxRelocationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxRelocationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxRestoreRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    ${LargeItemLimit},

    ${Priority},

    [Alias('ov')]
    ${OutVariable},

    ${BadItemLimit},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${InternalFlags},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${BatchName},

    ${SkipMerging},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${RemoteHostName},

    ${DomainController},

    [switch]
    ${AcceptLargeDataLoss},

    ${RequestExpiryInterval},

    [switch]
    ${RehomeRequest},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxRestoreRequest') `
                            -Arg ('Set-MailboxRestoreRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxRestoreRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailboxSpellingConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${DictionaryLanguage},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${CheckBeforeSend},

    [Alias('ev')]
    ${ErrorVariable},

    ${IgnoreMixedDigits},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${IgnoreUppercase},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailboxSpellingConfiguration') `
                            -Arg ('Set-MailboxSpellingConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailboxSpellingConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailContact' `
{
    param(
    
    ${EmailAddresses},

    ${RejectMessagesFromDLMembers},

    ${ModerationEnabled},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    [Alias('wa')]
    ${WarningAction},

    ${ExtensionCustomAttribute5},

    ${CustomAttribute8},

    ${CustomAttribute5},

    [switch]
    ${IgnoreDefaultScope},

    [switch]
    ${RemovePicture},

    ${MailTip},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${GrantSendOnBehalfTo},

    ${AcceptMessagesOnlyFrom},

    ${MessageBodyFormat},

    [Alias('iv')]
    ${InformationVariable},

    ${MaxReceiveSize},

    [Alias('ov')]
    ${OutVariable},

    ${EmailAddressPolicyEnabled},

    ${CustomAttribute15},

    ${RejectMessagesFromSendersOrMembers},

    ${WindowsEmailAddress},

    ${RejectMessagesFrom},

    ${Alias},

    ${DisplayName},

    [Alias('pv')]
    ${PipelineVariable},

    ${BypassModerationFromSendersOrMembers},

    ${AcceptMessagesOnlyFromDLMembers},

    ${CustomAttribute1},

    [switch]
    ${ForceUpgrade},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('infa')]
    ${InformationAction},

    ${MessageFormat},

    ${ExtensionCustomAttribute1},

    ${CustomAttribute14},

    ${RequireSenderAuthenticationEnabled},

    ${CustomAttribute9},

    ${CustomAttribute6},

    ${ExtensionCustomAttribute4},

    ${SimpleDisplayName},

    [Alias('ob')]
    ${OutBuffer},

    ${UsePreferMessageFormat},

    ${CustomAttribute7},

    ${CustomAttribute10},

    ${ExtensionCustomAttribute2},

    ${CustomAttribute13},

    ${CustomAttribute2},

    ${PrimarySmtpAddress},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${UseMapiRichTextFormat},

    ${SendModerationNotifications},

    ${ExternalEmailAddress},

    ${MaxSendSize},

    [Alias('wv')]
    ${WarningVariable},

    ${SecondaryAddress},

    ${MaxRecipientPerMessage},

    ${MailTipTranslations},

    [Alias('ea')]
    ${ErrorAction},

    ${CustomAttribute4},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${DomainController},

    ${Name},

    ${ExtensionCustomAttribute3},

    ${CustomAttribute12},

    ${MacAttachmentFormat},

    ${CustomAttribute3},

    ${CustomAttribute11},

    [switch]
    ${RemoveSpokenName},

    ${Identity},

    ${HiddenFromAddressListsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailContact') `
                            -Arg ('Set-MailContact', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailContact
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailPublicFolder' `
{
    param(
    
    ${EmailAddresses},

    ${RejectMessagesFromDLMembers},

    ${ModerationEnabled},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    ${CustomAttribute14},

    [Alias('wa')]
    ${WarningAction},

    ${DeliverToMailboxAndForward},

    ${ExtensionCustomAttribute5},

    ${CustomAttribute8},

    ${ArbitrationMailbox},

    ${CustomAttribute5},

    ${SimpleDisplayName},

    ${PhoneticDisplayName},

    ${MailTip},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${GrantSendOnBehalfTo},

    ${AcceptMessagesOnlyFrom},

    [Alias('iv')]
    ${InformationVariable},

    ${MaxReceiveSize},

    [Alias('ov')]
    ${OutVariable},

    ${EmailAddressPolicyEnabled},

    ${CustomAttribute15},

    [switch]
    ${IgnoreDefaultScope},

    ${RejectMessagesFromSendersOrMembers},

    ${WindowsEmailAddress},

    ${RejectMessagesFrom},

    ${Alias},

    ${DisplayName},

    ${IgnoreMissingFolderLink},

    [Alias('pv')]
    ${PipelineVariable},

    ${BypassModerationFromSendersOrMembers},

    ${AcceptMessagesOnlyFromDLMembers},

    ${CustomAttribute1},

    ${Contacts},

    ${UMDtmfMap},

    [Alias('infa')]
    ${InformationAction},

    ${ExtensionCustomAttribute1},

    ${EntryId},

    ${RequireSenderAuthenticationEnabled},

    ${CustomAttribute9},

    ${CustomAttribute6},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ExtensionCustomAttribute4},

    [Alias('ob')]
    ${OutBuffer},

    ${CustomAttribute7},

    ${ExtensionCustomAttribute2},

    ${CustomAttribute13},

    ${CustomAttribute2},

    ${PrimarySmtpAddress},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${SendModerationNotifications},

    ${ExternalEmailAddress},

    ${MaxSendSize},

    ${CreateDTMFMap},

    [Alias('wv')]
    ${WarningVariable},

    ${MailTipTranslations},

    [Alias('ea')]
    ${ErrorAction},

    ${CustomAttribute4},

    ${CustomAttribute10},

    ${DomainController},

    ${OnPremisesObjectId},

    ${Name},

    ${ExtensionCustomAttribute3},

    ${ForwardingAddress},

    ${CustomAttribute12},

    ${CustomAttribute3},

    ${CustomAttribute11},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Identity},

    ${HiddenFromAddressListsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailPublicFolder') `
                            -Arg ('Set-MailPublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailPublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MailUser' `
{
    param(
    
    ${EmailAddresses},

    ${RejectMessagesFromDLMembers},

    ${ModerationEnabled},

    [Alias('wa')]
    ${WarningAction},

    ${SamAccountName},

    ${UserCertificate},

    ${CustomAttribute10},

    ${ExtensionCustomAttribute5},

    ${CustomAttribute8},

    ${CustomAttribute5},

    ${UserPrincipalName},

    ${SimpleDisplayName},

    ${ExchangeGuid},

    [switch]
    ${RemovePicture},

    ${MailTip},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${GrantSendOnBehalfTo},

    [Alias('ea')]
    ${ErrorAction},

    ${UserSMimeCertificate},

    ${AcceptMessagesOnlyFrom},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    ${MessageBodyFormat},

    [Alias('iv')]
    ${InformationVariable},

    ${MaxReceiveSize},

    [Alias('ov')]
    ${OutVariable},

    ${EmailAddressPolicyEnabled},

    ${CustomAttribute15},

    [switch]
    ${IgnoreDefaultScope},

    ${ImmutableId},

    ${WindowsEmailAddress},

    [switch]
    ${SkipDualWrite},

    ${RejectMessagesFrom},

    ${Alias},

    ${RejectMessagesFromSendersOrMembers},

    ${DisplayName},

    [Alias('pv')]
    ${PipelineVariable},

    ${BypassModerationFromSendersOrMembers},

    ${AcceptMessagesOnlyFromDLMembers},

    ${CustomAttribute1},

    [switch]
    ${ForceUpgrade},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ArchiveGuid},

    [Alias('infa')]
    ${InformationAction},

    ${MessageFormat},

    ${ExtensionCustomAttribute1},

    ${CustomAttribute14},

    ${RequireSenderAuthenticationEnabled},

    ${CustomAttribute9},

    ${CustomAttribute6},

    ${ExtensionCustomAttribute4},

    [Alias('ob')]
    ${OutBuffer},

    ${UsePreferMessageFormat},

    ${RecoverableItemsQuota},

    ${ExtensionCustomAttribute2},

    ${CustomAttribute13},

    ${CustomAttribute2},

    ${PrimarySmtpAddress},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${UseMapiRichTextFormat},

    ${SendModerationNotifications},

    ${ExternalEmailAddress},

    ${MaxSendSize},

    [Alias('wv')]
    ${WarningVariable},

    ${RecipientLimits},

    ${SecondaryAddress},

    ${MailTipTranslations},

    ${CustomAttribute7},

    ${CustomAttribute4},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RecoverableItemsWarningQuota},

    ${DomainController},

    ${ArchiveName},

    ${Name},

    ${ExtensionCustomAttribute3},

    ${CustomAttribute12},

    ${MacAttachmentFormat},

    ${CustomAttribute3},

    ${CustomAttribute11},

    [switch]
    ${RemoveSpokenName},

    ${Identity},

    ${HiddenFromAddressListsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MailUser') `
                            -Arg ('Set-MailUser', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MailUser
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-MoveRequest' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${IncrementalSyncInterval},

    ${TargetDatabase},

    ${Identity},

    ${SuspendWhenReadyToComplete},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('infa')]
    ${InformationAction},

    ${InternalFlags},

    ${RequestExpiryInterval},

    ${PreventCompletion},

    [Alias('wv')]
    ${WarningVariable},

    ${Priority},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${LargeItemLimit},

    [Alias('ov')]
    ${OutVariable},

    ${BatchName},

    ${SkipMoving},

    ${RemoteHostName},

    ${ArchiveTargetDatabase},

    ${CompleteAfter},

    ${DomainController},

    ${MoveOptions},

    ${Protect},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${AcceptLargeDataLoss},

    ${StartAfter},

    [Alias('iv')]
    ${InformationVariable},

    ${BadItemLimit},

    ${RemoteGlobalCatalog},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('db')]
    [switch]
    ${Debug},

    ${RemoteCredential},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-MoveRequest') `
                            -Arg ('Set-MoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-MoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-Notification' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    ${NotificationEmails},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-Notification') `
                            -Arg ('Set-Notification', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-Notification
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-OrganizationConfig' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${DefaultPublicFolderAgeLimit},

    ${HierarchicalAddressBookRoot},

    [Alias('ev')]
    ${ErrorVariable},

    ${DistributionGroupNameBlockedWordsList},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${DistributionGroupDefaultOU},

    [Alias('wv')]
    ${WarningVariable},

    ${DefaultPublicFolderProhibitPostQuota},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RemotePublicFolderMailboxes},

    ${PublicFolderMailboxesMigrationComplete},

    ${DefaultPublicFolderMovedItemRetention},

    [Alias('ov')]
    ${OutVariable},

    ${DefaultPublicFolderDeletedItemRetention},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${PublicFolderMailboxesLockedForNewConnections},

    ${DefaultPublicFolderMaxItemSize},

    ${DefaultPublicFolderIssueWarningQuota},

    ${PublicFoldersEnabled},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${PublicFoldersLockedForMigration},

    ${PublicFolderMigrationComplete},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    ${DistributionGroupNamingPolicy},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-OrganizationConfig') `
                            -Arg ('Set-OrganizationConfig', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-OrganizationConfig
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-OwaMailboxPolicy' `
{
    param(
    
    [Alias('cf')]
    [switch]
    ${Confirm},

    ${DefaultClientLanguage},

    ${WebReadyDocumentViewingOnPublicComputersEnabled},

    ${ContactsEnabled},

    ${WebReadyDocumentViewingForAllSupportedTypes},

    [Alias('wa')]
    ${WarningAction},

    ${ExplicitLogonEnabled},

    ${WebPartsFrameOptionsType},

    ${BlockedFileTypes},

    ${WebReadyFileTypes},

    ${JunkEmailEnabled},

    ${OneDriveAttachmentsEnabled},

    ${WebReadyDocumentViewingSupportedMimeTypes},

    ${DirectFileAccessOnPrivateComputersEnabled},

    ${ChangePasswordEnabled},

    ${GoogleDriveAttachmentsEnabled},

    ${AllowedMimeTypes},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${WacViewingOnPublicComputersEnabled},

    [Alias('ea')]
    ${ErrorAction},

    ${WacEditingEnabled},

    ${ExternalSPMySiteHostURL},

    ${ReferenceAttachmentsEnabled},

    ${NotesEnabled},

    ${JournalEnabled},

    [Alias('ov')]
    ${OutVariable},

    ${SpellCheckerEnabled},

    ${DisplayPhotosEnabled},

    ${TasksEnabled},

    ${GroupCreationEnabled},

    ${ForceSaveFileTypes},

    ${ForceWacViewingFirstOnPublicComputers},

    ${WebReadyDocumentViewingOnPrivateComputersEnabled},

    ${WacViewingOnPrivateComputersEnabled},

    ${TextMessagingEnabled},

    ${SearchFoldersEnabled},

    ${WebReadyMimeTypes},

    ${UserVoiceEnabled},

    ${CalendarEnabled},

    [Alias('pv')]
    ${PipelineVariable},

    ${SMimeEnabled},

    ${GlobalAddressListEnabled},

    ${IRMEnabled},

    ${DirectFileAccessOnPublicComputersEnabled},

    ${SetPhotoURL},

    ${SignaturesEnabled},

    ${WSSAccessOnPublicComputersEnabled},

    ${ForceSaveMimeTypes},

    ${ForceWebReadyDocumentViewingFirstOnPrivateComputers},

    ${WacOMEXEnabled},

    ${WacExternalServicesEnabled},

    ${InternalSPMySiteHostURL},

    [Alias('infa')]
    ${InformationAction},

    ${SatisfactionEnabled},

    ${UNCAccessOnPublicComputersEnabled},

    ${InstantMessagingType},

    ${ActiveSyncIntegrationEnabled},

    ${WebReadyDocumentViewingSupportedFileTypes},

    ${DefaultTheme},

    ${SetPhotoEnabled},

    ${ClassicAttachmentsEnabled},

    ${AllowCopyContactsToDeviceAddressBook},

    ${BoxAttachmentsEnabled},

    ${UseISO885915},

    [Alias('iv')]
    ${InformationVariable},

    ${OutboundCharset},

    ${UNCAccessOnPrivateComputersEnabled},

    ${ReportJunkEmailEnabled},

    ${ForceWacViewingFirstOnPrivateComputers},

    ${RecoverDeletedItemsEnabled},

    ${ForceWebReadyDocumentViewingFirstOnPublicComputers},

    ${InstantMessagingEnabled},

    ${DropboxAttachmentsEnabled},

    ${DelegateAccessEnabled},

    ${ActionForUnknownFileAndMIMETypes},

    ${ThirdPartyAttachmentsEnabled},

    ${PublicFoldersEnabled},

    ${ForceSaveAttachmentFilteringEnabled},

    ${LogonAndErrorLanguage},

    [Alias('wv')]
    ${WarningVariable},

    ${WSSAccessOnPrivateComputersEnabled},

    ${AllAddressListsEnabled},

    ${PremiumClientEnabled},

    ${BlockedMimeTypes},

    ${UMIntegrationEnabled},

    ${SilverlightEnabled},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${IsDefault},

    ${DomainController},

    ${AllowOfflineOn},

    ${AllowedFileTypes},

    ${RulesEnabled},

    ${FreCardsEnabled},

    ${Name},

    ${ThemeSelectionEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    ${OrganizationEnabled},

    ${UseGB18030},

    ${OWALightEnabled},

    [Alias('db')]
    [switch]
    ${Debug},

    ${RemindersAndNotificationsEnabled},

    ${SaveAttachmentsToCloudEnabled},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    ${SkipCreateUnifiedGroupCustomSharepointClassification},

    ${OnSendAddinsEnabled},

    ${PhoneticSupportEnabled},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-OwaMailboxPolicy') `
                            -Arg ('Set-OwaMailboxPolicy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-OwaMailboxPolicy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-PublicFolder' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    ${OverrideContentMailbox},

    [Alias('ev')]
    ${ErrorVariable},

    ${IssueWarningQuota},

    [Alias('infa')]
    ${InformationAction},

    ${ProhibitPostQuota},

    [switch]
    ${Force},

    [Alias('wv')]
    ${WarningVariable},

    ${Path},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Name},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    ${EformsLocaleId},

    ${MailRecipientGuid},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${AgeLimit},

    [Alias('pv')]
    ${PipelineVariable},

    ${RetainDeletedItemsFor},

    ${MailEnabled},

    ${PerUserReadStateEnabled},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('iv')]
    ${InformationVariable},

    ${MaxItemSize},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-PublicFolder') `
                            -Arg ('Set-PublicFolder', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-PublicFolder
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-PublicFolderMailboxMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    ${LargeItemLimit},

    ${Priority},

    [Alias('ov')]
    ${OutVariable},

    ${BadItemLimit},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${InternalFlags},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${SkipMerging},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${AcceptLargeDataLoss},

    ${RequestExpiryInterval},

    [switch]
    ${RehomeRequest},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-PublicFolderMailboxMigrationRequest') `
                            -Arg ('Set-PublicFolderMailboxMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-PublicFolderMailboxMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-PublicFolderMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    ${LargeItemLimit},

    ${Priority},

    [Alias('ov')]
    ${OutVariable},

    ${BadItemLimit},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${InternalFlags},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${BatchName},

    ${SkipMerging},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${PreventCompletion},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${AcceptLargeDataLoss},

    ${RequestExpiryInterval},

    [switch]
    ${RehomeRequest},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-PublicFolderMigrationRequest') `
                            -Arg ('Set-PublicFolderMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-PublicFolderMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-PublicFolderMoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('iv')]
    ${InformationVariable},

    ${LargeItemLimit},

    ${Priority},

    [Alias('ov')]
    ${OutVariable},

    ${BadItemLimit},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${InternalFlags},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${SuspendWhenReadyToComplete},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [switch]
    ${AcceptLargeDataLoss},

    ${RequestExpiryInterval},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${CompletedRequestAgeLimit},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-PublicFolderMoveRequest') `
                            -Arg ('Set-PublicFolderMoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-PublicFolderMoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-RemoteMailbox' `
{
    param(
    
    ${EmailAddresses},

    ${RejectMessagesFromDLMembers},

    ${ModerationEnabled},

    ${SamAccountName},

    ${Type},

    [Alias('wa')]
    ${WarningAction},

    ${ExtensionCustomAttribute5},

    ${CustomAttribute8},

    ${CustomAttribute5},

    [switch]
    ${IgnoreDefaultScope},

    ${ExchangeGuid},

    [switch]
    ${RemovePicture},

    ${MailTip},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    ${ModeratedBy},

    ${GrantSendOnBehalfTo},

    ${UserPrincipalName},

    ${AcceptMessagesOnlyFromSendersOrMembers},

    [Alias('iv')]
    ${InformationVariable},

    [Alias('ov')]
    ${OutVariable},

    ${EmailAddressPolicyEnabled},

    ${CustomAttribute15},

    ${RejectMessagesFromSendersOrMembers},

    ${WindowsEmailAddress},

    ${RejectMessagesFrom},

    ${Alias},

    ${DisplayName},

    [Alias('pv')]
    ${PipelineVariable},

    ${BypassModerationFromSendersOrMembers},

    ${AcceptMessagesOnlyFromDLMembers},

    ${CustomAttribute1},

    ${CustomAttribute10},

    [Alias('db')]
    [switch]
    ${Debug},

    ${ArchiveGuid},

    [Alias('infa')]
    ${InformationAction},

    ${ExtensionCustomAttribute1},

    ${ResetPasswordOnNextLogon},

    ${CustomAttribute14},

    ${RequireSenderAuthenticationEnabled},

    ${CustomAttribute9},

    ${CustomAttribute6},

    ${ExtensionCustomAttribute4},

    [Alias('ob')]
    ${OutBuffer},

    ${RemoteRoutingAddress},

    ${CustomAttribute7},

    ${RecoverableItemsQuota},

    ${ImmutableId},

    ${ExtensionCustomAttribute2},

    ${CustomAttribute13},

    ${CustomAttribute2},

    ${PrimarySmtpAddress},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${ACLableSyncedObjectEnabled},

    ${SendModerationNotifications},

    [Alias('wv')]
    ${WarningVariable},

    ${MailTipTranslations},

    [Alias('ea')]
    ${ErrorAction},

    ${CustomAttribute4},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${RecoverableItemsWarningQuota},

    ${DomainController},

    ${ArchiveName},

    ${AcceptMessagesOnlyFrom},

    ${Name},

    ${ExtensionCustomAttribute3},

    ${CustomAttribute12},

    ${CustomAttribute3},

    ${CustomAttribute11},

    [switch]
    ${RemoveSpokenName},

    ${Identity},

    ${HiddenFromAddressListsEnabled},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-RemoteMailbox') `
                            -Arg ('Set-RemoteMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-RemoteMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-ResubmitRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Enabled},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-ResubmitRequest') `
                            -Arg ('Set-ResubmitRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-ResubmitRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-SweepRule' `
{
    param(
    
    [Alias('wa')]
    ${WarningAction},

    ${Sender},

    ${Identity},

    ${Enabled},

    ${Mailbox},

    ${DestinationFolder},

    ${KeepForDays},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('wv')]
    ${WarningVariable},

    ${SourceFolder},

    ${Provider},

    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${Name},

    [Alias('ev')]
    ${ErrorVariable},

    ${ExceptIfFlagged},

    [Alias('infa')]
    ${InformationAction},

    [Alias('ov')]
    ${OutVariable},

    ${KeepLatest},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${SystemCategory},

    [Alias('pv')]
    ${PipelineVariable},

    ${ExceptIfPinned},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ob')]
    ${OutBuffer},

    ${DomainController},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-SweepRule') `
                            -Arg ('Set-SweepRule', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-SweepRule
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-UnifiedAuditSetting' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${RetentionDays},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    ${RefreshInterval},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${AlternativeTenantId},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('wa')]
    ${WarningAction},

    ${IngestionEnabled},

    ${LoadBalancerCount},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-UnifiedAuditSetting') `
                            -Arg ('Set-UnifiedAuditSetting', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-UnifiedAuditSetting
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-User' `
{
    param(
    
    ${Company},

    [Alias('wa')]
    ${WarningAction},

    ${Phone},

    ${DisplayName},

    ${Identity},

    ${Office},

    ${CountryOrRegion},

    ${OtherTelephone},

    ${UserPrincipalName},

    ${CertificateSubject},

    [Alias('ev')]
    ${ErrorVariable},

    ${PhoneticDisplayName},

    [Alias('infa')]
    ${InformationAction},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Fax},

    ${PostOfficeBox},

    ${LastName},

    ${SamAccountName},

    ${Pager},

    [switch]
    ${IgnoreDefaultScope},

    [switch]
    ${PermanentlyClearPreviousMailboxInfo},

    ${LinkedCredential},

    ${ResetPasswordOnNextLogon},

    [Alias('ea')]
    ${ErrorAction},

    ${SeniorityIndex},

    ${City},

    ${TelephoneAssistant},

    ${WindowsEmailAddress},

    ${Title},

    ${MobilePhone},

    ${AssistantName},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('ov')]
    ${OutVariable},

    ${StateOrProvince},

    [Alias('ob')]
    ${OutBuffer},

    ${Initials},

    [Alias('pv')]
    ${PipelineVariable},

    ${WebPage},

    [switch]
    ${SkipDualWrite},

    ${DomainController},

    ${LinkedDomainController},

    ${LinkedMasterAccount},

    ${Manager},

    ${HomePhone},

    ${OtherFax},

    ${SimpleDisplayName},

    [Alias('iv')]
    ${InformationVariable},

    ${Department},

    [Alias('wv')]
    ${WarningVariable},

    ${OtherHomePhone},

    ${FirstName},

    [switch]
    ${PublicFolder},

    ${Notes},

    ${RemotePowerShellEnabled},

    ${Name},

    ${GeoCoordinates},

    ${StreetAddress},

    ${PostalCode},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-User') `
                            -Arg ('Set-User', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-User
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Set-UserPhoto' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    ${PictureData},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('db')]
    [switch]
    ${Debug},

    [switch]
    ${Cancel},

    ${PictureStream},

    [switch]
    ${Save},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [switch]
    ${IgnoreDefaultScope},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${PhotoType},

    ${DomainController},

    [switch]
    ${Preview},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Set-UserPhoto') `
                            -Arg ('Set-UserPhoto', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Set-UserPhoto
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Start-AuditAssistant' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    ${FolderTimeRangeSpecifierUTC},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${BacklogAssistant},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('ov')]
    ${OutVariable},

    ${ExpectedFoldersCount},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Start-AuditAssistant') `
                            -Arg ('Start-AuditAssistant', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Start-AuditAssistant
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-MailboxExportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-MailboxExportRequest') `
                            -Arg ('Suspend-MailboxExportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-MailboxExportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-MailboxImportRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-MailboxImportRequest') `
                            -Arg ('Suspend-MailboxImportRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-MailboxImportRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-Message' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Filter},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-Message') `
                            -Arg ('Suspend-Message', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-Message
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-MoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-MoveRequest') `
                            -Arg ('Suspend-MoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-MoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-MRSRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-MRSRequest') `
                            -Arg ('Suspend-MRSRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-MRSRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-PublicFolderMailboxMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-PublicFolderMailboxMigrationRequest') `
                            -Arg ('Suspend-PublicFolderMailboxMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-PublicFolderMailboxMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-PublicFolderMigrationRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-PublicFolderMigrationRequest') `
                            -Arg ('Suspend-PublicFolderMigrationRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-PublicFolderMigrationRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-PublicFolderMoveRequest' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${SuspendComment},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-PublicFolderMoveRequest') `
                            -Arg ('Suspend-PublicFolderMoveRequest', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-PublicFolderMoveRequest
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Suspend-Queue' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    ${Filter},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${Identity},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Suspend-Queue') `
                            -Arg ('Suspend-Queue', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Suspend-Queue
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Test-MAPIConnectivity' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [switch]
    ${Archive},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Test-MAPIConnectivity') `
                            -Arg ('Test-MAPIConnectivity', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Test-MAPIConnectivity
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-DatabaseSchema' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${MinorVersion},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${MajorVersion},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-DatabaseSchema') `
                            -Arg ('Update-DatabaseSchema', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-DatabaseSchema
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-DistributionGroupMember' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    ${Members},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-DistributionGroupMember') `
                            -Arg ('Update-DistributionGroupMember', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-DistributionGroupMember
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-HybridConfiguration' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('infa')]
    ${InformationAction},

    [switch]
    ${SuppressOAuthWarning},

    [switch]
    ${ForceUpgrade},

    ${OnPremisesCredentials},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${TenantCredentials},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-HybridConfiguration') `
                            -Arg ('Update-HybridConfiguration', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-HybridConfiguration
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-MailboxDatabaseCopy' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Server},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-MailboxDatabaseCopy') `
                            -Arg ('Update-MailboxDatabaseCopy', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-MailboxDatabaseCopy
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-PublicFolderMailbox' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [switch]
    ${ForceOnlineSync},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [switch]
    ${CreateAssociatedDumpster},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('ev')]
    ${ErrorVariable},

    [switch]
    ${InvokeSynchronizer},

    [switch]
    ${SuppressStatus},

    [Alias('wa')]
    ${WarningAction},

    [switch]
    ${ReconcileFolders},

    [Alias('ov')]
    ${OutVariable},

    ${DomainController},

    [switch]
    ${FullSync},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${FolderId},

    ${Identity},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-PublicFolderMailbox') `
                            -Arg ('Update-PublicFolderMailbox', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-PublicFolderMailbox
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-Recipient' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    ${Credential},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-Recipient') `
                            -Arg ('Update-Recipient', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-Recipient
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Update-StoreMailboxState' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    ${Database},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    [Alias('ev')]
    ${ErrorVariable},

    ${Identity},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Update-StoreMailboxState') `
                            -Arg ('Update-StoreMailboxState', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Update-StoreMailboxState
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
& $script:SetItem 'function:script:Write-AdminAuditLog' `
{
    param(
    
    [Alias('ea')]
    ${ErrorAction},

    [Alias('vb')]
    [switch]
    ${Verbose},

    [Alias('ov')]
    ${OutVariable},

    [Alias('infa')]
    ${InformationAction},

    [Alias('wv')]
    ${WarningVariable},

    [Alias('db')]
    [switch]
    ${Debug},

    [Alias('pv')]
    ${PipelineVariable},

    [Alias('cf')]
    [switch]
    ${Confirm},

    ${Comment},

    [Alias('ev')]
    ${ErrorVariable},

    [Alias('ob')]
    ${OutBuffer},

    [Alias('wa')]
    ${WarningAction},

    ${DomainController},

    [Alias('wi')]
    [switch]
    ${WhatIf},

    [Alias('iv')]
    ${InformationVariable},

    [switch]
    ${AsJob})

    Begin {
        try {
            $positionalArguments = & $script:NewObject collections.arraylist
            foreach ($parameterName in $PSBoundParameters.BoundPositionally)
            {
                $null = $positionalArguments.Add( $PSBoundParameters[$parameterName] )
                $null = $PSBoundParameters.Remove($parameterName)
            }
            $positionalArguments.AddRange($args)

            $clientSideParameters = Get-PSImplicitRemotingClientSideParameters $PSBoundParameters $True

            $scriptCmd = { & $script:InvokeCommand `
                            @clientSideParameters `
                            -HideComputerName `
                            -Session (Get-PSImplicitRemotingSession -CommandName 'Write-AdminAuditLog') `
                            -Arg ('Write-AdminAuditLog', $PSBoundParameters, $positionalArguments) `
                            -Script { param($name, $boundParams, $unboundParams) & $name @boundParams @unboundParams } `
                         }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($myInvocation.ExpectingInput, $ExecutionContext)
        } catch {
            throw
        }
    }
    Process { 
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
 }
    End { 
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
 }

    # .ForwardHelpTargetName Write-AdminAuditLog
    # .ForwardHelpCategory Function
    # .RemoteHelpRunspace PSSession
}
        
##############################################################################

& $script:ExportModuleMember -Function @('Add-DistributionGroupMember', 'Add-MailboxFolderPermission', 'Add-MailboxLocation', 'Add-MailboxPermission', 'Add-PublicFolderClientPermission', 'Add-ResubmitRequest', 'Clear-ActiveSyncDevice', 'Clear-MobileDevice', 'Connect-Mailbox', 'Disable-DistributionGroup', 'Disable-InboxRule', 'Disable-Mailbox', 'Disable-MailboxQuarantine', 'Disable-MailContact', 'Disable-MailPublicFolder', 'Disable-MailUser', 'Disable-PushNotificationProxy', 'Disable-RemoteMailbox', 'Disable-ServiceEmailChannel', 'Disable-SweepRule', 'Dismount-Database', 'Enable-DistributionGroup', 'Enable-InboxRule', 'Enable-Mailbox', 'Enable-MailboxQuarantine', 'Enable-MailContact', 'Enable-MailPublicFolder', 'Enable-MailUser', 'Enable-PushNotificationProxy', 'Enable-RemoteMailbox', 'Enable-ServiceEmailChannel', 'Enable-SweepRule', 'Export-Message', 'Get-AcceptedDomain', 'Get-ActiveSyncDevice', 'Get-ActiveSyncDeviceStatistics', 'Get-ActiveSyncMailboxPolicy', 'Get-AddressBookPolicy', 'Get-ADServerSettings', 'Get-CalendarNotification', 'Get-CalendarProcessing', 'Get-CASMailbox', 'Get-Contact', 'Get-DefaultFolderHistory', 'Get-DistributionGroup', 'Get-DistributionGroupMember', 'Get-DomainController', 'Get-DynamicDistributionGroup', 'Get-EligibleDistributionGroupForMigration', 'Get-ExchangeServer', 'Get-ExchangeServerAccessLicense', 'Get-ExchangeServerAccessLicenseUser', 'Get-Group', 'Get-HybridConfiguration', 'Get-InboxRule', 'Get-LinkedUser', 'Get-LogonStatistics', 'Get-Mailbox', 'Get-MailboxAutoReplyConfiguration', 'Get-MailboxCalendarConfiguration', 'Get-MailboxCalendarFolder', 'Get-MailboxDatabase', 'Get-MailboxDatabaseRedundancy', 'Get-MailboxExportRequest', 'Get-MailboxExportRequestStatistics', 'Get-MailboxFolderPermission', 'Get-MailboxFolderStatistics', 'Get-MailboxImportRequest', 'Get-MailboxImportRequestStatistics', 'Get-MailboxJunkEmailConfiguration', 'Get-MailboxLocation', 'Get-MailboxMessageConfiguration', 'Get-MailboxPermission', 'Get-MailboxPreferredLocation', 'Get-MailboxRegionalConfiguration', 'Get-MailboxRelocationRequestStatistics', 'Get-MailboxRepairRequest', 'Get-MailboxServer', 'Get-MailboxServerRedundancy', 'Get-MailboxSpellingConfiguration', 'Get-MailboxStatistics', 'Get-MailboxUserConfiguration', 'Get-MailContact', 'Get-MailPublicFolder', 'Get-MailUser', 'Get-ManagementRoleAssignment', 'Get-Message', 'Get-MessageCategory', 'Get-MessageClassification', 'Get-MobileDevice', 'Get-MobileDeviceMailboxPolicy', 'Get-MobileDeviceStatistics', 'Get-MoveRequest', 'Get-MoveRequestStatistics', 'Get-MRSRequest', 'Get-MRSRequestStatistics', 'Get-Notification', 'Get-OfflineAddressBook', 'Get-OnlineMeetingConfiguration', 'Get-OrganizationalUnit', 'Get-OwaMailboxPolicy', 'Get-PhysicalAvailabilityReport', 'Get-PublicFolder', 'Get-PublicFolderClientPermission', 'Get-PublicFolderDatabase', 'Get-PublicFolderItemStatistics', 'Get-PublicFolderMailboxDiagnostics', 'Get-PublicFolderMailboxMigrationRequest', 'Get-PublicFolderMailboxMigrationRequestStatistics', 'Get-PublicFolderMigrationRequest', 'Get-PublicFolderMigrationRequestStatistics', 'Get-PublicFolderMoveRequest', 'Get-PublicFolderMoveRequestStatistics', 'Get-PublicFolderStatistics', 'Get-Queue', 'Get-RbacDiagnosticInfo', 'Get-ReceiveConnector', 'Get-Recipient', 'Get-RecoverableItems', 'Get-RemoteMailbox', 'Get-ResourceConfig', 'Get-ResubmitRequest', 'Get-RoleAssignmentPolicy', 'Get-SecurityPrincipal', 'Get-ServiceAvailabilityReport', 'Get-ServiceStatus', 'Get-SharingPolicy', 'Get-SiteMailbox', 'Get-SiteMailboxProvisioningPolicy', 'Get-SweepRule', 'Get-TextMessagingAccount', 'Get-ThrottlingPolicy', 'Get-ThrottlingPolicyAssociation', 'Get-Trust', 'Get-UnifiedAuditSetting', 'Get-User', 'Get-UserPhoto', 'Get-UserPrincipalNamesSuffix', 'Import-RecipientDataProperty', 'Mount-Database', 'Move-ActiveMailboxDatabase', 'Move-DatabasePath', 'New-DistributionGroup', 'New-DynamicDistributionGroup', 'New-HybridConfiguration', 'New-InboxRule', 'New-LinkedUser', 'New-Mailbox', 'New-MailboxDatabase', 'New-MailboxExportRequest', 'New-MailboxImportRequest', 'New-MailboxRelocationRequest', 'New-MailboxRepairRequest', 'New-MailContact', 'New-MailUser', 'New-MoveRequest', 'New-OwaMailboxPolicy', 'New-PublicFolder', 'New-PublicFolderMigrationRequest', 'New-PublicFolderMoveRequest', 'New-RemoteMailbox', 'New-SweepRule', 'New-SyncMailPublicFolder', 'Redirect-Message', 'Remove-ActiveSyncDevice', 'Remove-DistributionGroup', 'Remove-DistributionGroupMember', 'Remove-DynamicDistributionGroup', 'Remove-HybridConfiguration', 'Remove-InboxRule', 'Remove-LinkedUser', 'Remove-Mailbox', 'Remove-MailboxDatabase', 'Remove-MailboxExportRequest', 'Remove-MailboxFolderPermission', 'Remove-MailboxImportRequest', 'Remove-MailboxLocation', 'Remove-MailboxPermission', 'Remove-MailboxRepairRequest', 'Remove-MailboxUserConfiguration', 'Remove-MailContact', 'Remove-MailUser', 'Remove-Message', 'Remove-MobileDevice', 'Remove-MoveRequest', 'Remove-MRSRequest', 'Remove-OwaMailboxPolicy', 'Remove-PublicFolder', 'Remove-PublicFolderClientPermission', 'Remove-PublicFolderMailboxMigrationRequest', 'Remove-PublicFolderMigrationRequest', 'Remove-PublicFolderMoveRequest', 'Remove-PushNotificationSubscription', 'Remove-RemoteMailbox', 'Remove-ResubmitRequest', 'Remove-StoreMailbox', 'Remove-SweepRule', 'Remove-SyncMailPublicFolder', 'Remove-UserPhoto', 'Restore-RecoverableItems', 'Resume-MailboxExportRequest', 'Resume-MailboxImportRequest', 'Resume-Message', 'Resume-MoveRequest', 'Resume-MRSRequest', 'Resume-PublicFolderMailboxMigrationRequest', 'Resume-PublicFolderMigrationRequest', 'Resume-PublicFolderMoveRequest', 'Resume-Queue', 'Retry-Queue', 'Search-Mailbox', 'Set-ADServerSettings', 'Set-CalendarProcessing', 'Set-CASMailbox', 'Set-Contact', 'Set-DistributionGroup', 'Set-DynamicDistributionGroup', 'Set-Group', 'Set-HybridConfiguration', 'Set-InboxRule', 'Set-LinkedUser', 'Set-Mailbox', 'Set-MailboxAutoReplyConfiguration', 'Set-MailboxCalendarConfiguration', 'Set-MailboxCalendarFolder', 'Set-MailboxDatabase', 'Set-MailboxExportRequest', 'Set-MailboxFolderPermission', 'Set-MailboxImportRequest', 'Set-MailboxJunkEmailConfiguration', 'Set-MailboxLocation', 'Set-MailboxMessageConfiguration', 'Set-MailboxRegionalConfiguration', 'Set-MailboxRelocationRequest', 'Set-MailboxRestoreRequest', 'Set-MailboxSpellingConfiguration', 'Set-MailContact', 'Set-MailPublicFolder', 'Set-MailUser', 'Set-MoveRequest', 'Set-Notification', 'Set-OrganizationConfig', 'Set-OwaMailboxPolicy', 'Set-PublicFolder', 'Set-PublicFolderMailboxMigrationRequest', 'Set-PublicFolderMigrationRequest', 'Set-PublicFolderMoveRequest', 'Set-RemoteMailbox', 'Set-ResubmitRequest', 'Set-SweepRule', 'Set-UnifiedAuditSetting', 'Set-User', 'Set-UserPhoto', 'Start-AuditAssistant', 'Suspend-MailboxExportRequest', 'Suspend-MailboxImportRequest', 'Suspend-Message', 'Suspend-MoveRequest', 'Suspend-MRSRequest', 'Suspend-PublicFolderMailboxMigrationRequest', 'Suspend-PublicFolderMigrationRequest', 'Suspend-PublicFolderMoveRequest', 'Suspend-Queue', 'Test-MAPIConnectivity', 'Update-DatabaseSchema', 'Update-DistributionGroupMember', 'Update-HybridConfiguration', 'Update-MailboxDatabaseCopy', 'Update-PublicFolderMailbox', 'Update-Recipient', 'Update-StoreMailboxState', 'Write-AdminAuditLog')
        
##############################################################################

& $script:ExportModuleMember -Alias @()
        