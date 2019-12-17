#region :: Header
<#

NAME        : Get-UserInfo.psm1 
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Get AD user info and output to screen for research and account discovery
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 
UPDATED     : 05-30-2019
VERSION     : 2.1



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 04-25-2017 ac007  INITIAL RELEASE
1.1 04-27-2017 ac007  Added module to computer UserAccountControl; removed code from this module.
1.2 04-28-2017 ac007  Added -Screen parameter to facilitate output formatted for notes in Track-It! resolutions.
1.3 05-05-2017 ac007  Added {HomePhone,ipPhone,MobilePhone,OfficePhone,telephoneNumber} to putput
2.0 02-19-2019 ac007  Changed parametersets to allow for both ANR and sAMAccountName queries; also allows sAMAccountName as default without parameter name.
2.1 11-04-2019 ac007  Remove extra/old code/comments; Utilize ValueFromPipeline=$true.

Import-Module Get-UserInfo -Force

#>
#endregion


Function Get-UserInfo {
    [CmdletBinding(DefaultParameterSetName = 'samAccountName')]
    
    Param(
        [Parameter(Mandatory = $true
            , ParameterSetName = 'samAccountName'
            , Position = 0
            , ValueFromPipeline = $true
            , ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $true
            , ParameterSetName = 'Student'
            , Position = 0
            , ValueFromPipeline = $true
            , ValueFromPipelineByPropertyName = $true)]
        [Alias('Identity','Id')]
        [string]$sAMAccountName,
        
        [Parameter(Mandatory = $true
            , ParameterSetName = 'Anr')]
        [Parameter(Mandatory = $true
            , ParameterSetName = 'Student')]
        [string]$Anr,
        
        
        [Parameter(Mandatory = $false
            , ParameterSetName = "samAccountName")]
        [switch]$ShowPass,

        [Parameter(Mandatory = $false
            , ParameterSetName = "samAccountName")]
        [String]$PwdString,
                
        [Parameter(Mandatory = $false, ParameterSetName = "samAccountName")]
        [Parameter(Mandatory = $false, ParameterSetName = "Student")]
        [switch]$NoOutput,
        
        [Parameter(Mandatory = $false, ParameterSetName = "Student")]
        [Parameter(Mandatory = $false, ParameterSetName = "Anr")]
        [switch]$Students,

        [Parameter(Mandatory = $false, ParameterSetName = "samAccountName")]
        [Parameter(Mandatory = $false, ParameterSetName = "Student")]
        [switch]$screen,

        [Parameter(Mandatory = $false, ParameterSetName = "samAccountName")]
        [switch]$UpdateLogs,

        [Parameter(Mandatory=$false, ParameterSetName = "samAccountName")]
        $workOrder
    )

    Begin {
        $props = @{
            Properties = 'sAMAccountName',
            'DisplayName',
            'GivenName',
            'SurName',
            'Name',
            'GenerationQualifier',
            'ExtensionAttribute1',
            'UserPrincipalName',
            'CanonicalName',
            'Description',
            'Title',
            'EmployeeType',
            'Department',
            'Office',
            'OfficePhone',
            'HomePhone',
            'MobilePhone',
            'IpPhone',
            'TelephoneNumber',
            'Company',
            'StreetAddress',
            'City',
            'St',
            'PostalCode',
            'Country',
            'Mail',
            'mailNickname',
            'EmailAddress',
            'msExchRemoteRecipientType',
            'MsExchWhenMailboxCreated',
            'WhenCreated',
            'WhenChanged',
            'LastLogonDate',
            'HomeDrive',
            'HomeDirectory',
            'ScriptPath',
            'AccountExpires',
            'AccountExpirationDate',
            'PassWordExpired',
            'ProxyAddresses',
            'PasswordLastSet',
            'MemberOf',
            'MsNPAllowDialIn',
            'MsDS-UserPasswordExpiryTimeComputed',
            'EmployeeId',
            'UserAccountControl',
            'Enabled',
            "msExchUMCallingLineIDs",
            'wWWHomePage',
            'ExtensionAttribute10'
            #Server = "$($DomainController.HostName)"
        }#end $props
        $splat = @{
            Property = @(
                'sAMAccountName'
                , 'UserPrincipalName'
                , 'Name'
                , 'DisplayName'
                , 'Givenname'
                , 'Surname'
                , 'GenerationQUalifier'
                , 'EmployeeID'
                , 'ExtensionAttribute1'
                , 'Description'
                , 'CanonicalName'
                , 'Office'
                , 'OfficePhone'
                , 'IpPhone'
                , "msExchUMCallingLineIDs"
                , 'MobilePhone'
                , 'Title'
                , 'EmployeeType'
                , 'Department'
                , 'Company'
                , 'StreetAddress'
                , 'City'
                , 'St'
                , 'PostalCode'
                , 'Country'
                , 'wWWHomePage'
                , 'HomeDrive'
                , 'HomeDirectory'
                , 'ScriptPath'
                , 'msNPAllowDialin'
                , 'userAccountControl'
                , @{N = 'UAC-Converted'; E = { Get-ReadableUAC -userAccountControl $_.UserAccountControl } }
                , @{N = 'ChangePasswordNextLogon'; E = { [bool]$(if ($_.'msDS-UserPasswordExpiryTimeComputed' -eq 0) { $true }else { $false }) } }
                , 'Enabled'
                , 'PasswordExpired'
                , 'PasswordLastSet'
                , @{N = 'PasswordExpiry'; E = { if ($_.'msDS-UserPasswordExpiryTimeComputed' -ne 0) { [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') }else { $null } } }
                , @{N = 'PasswordRemaining'; E = { if ($_.'msDS-UserPasswordExpiryTimeComputed' -ne 0) { $([datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') - (Get-Date)).Days }else { "Change at next logon" } } }
                , 'AccountExpirationDate'
                , 'whenCreated'
                , 'whenChanged'
                , 'LastLogonDate'
                , 'Mail'
                , 'MailNickname'
                , 'msExchRemoteRecipientType'
                , @{N = 'SmtpAliases'; E = { $($($($_.ProxyAddresses).Where( { $_ -clike "smtp*" }).replace("smtp:", "")).split(",")) -join "`r`n" } }
                , 'ProxyAddresses'
                , 'DistinguishedName'
                , 'ExtensionAttribute10'
                , @{N='Path';E={$_.DistinguishedName.Split(",").Where({$_ -notmatch "CN="}) -join ","}}
            )
        }#end $splat

    } #end Begin{}

    Process {

        $UserList = @()
        Write-Verbose "Querying host: $($props.server)"

        Switch ($PSCmdlet.ParameterSetName) {
            { $_ -eq "Anr" } {
                if ($PSBoundParameters.ContainsKey('Students')) {
                    $props.Add('Server', "STUDENTS")
                    $props.Add('Filter', "Anr -eq '$Anr'")
                }#end if{}
                Else {
                    $props.Add('Server', "$($DomainController.HostName)")
                    $props.Add('Filter', "Anr -eq '$Anr'")
                }#end Else{}                        
            }
            Default {
                if ($PSBoundParameters.ContainsKey('Students')) {
                    $props.Add('Server', "STUDENTS")
                    $props.Add('Filter', "samAccountName -eq '$samAccountName'")
                }#end if{}
                Else {
                    $props.Add('Server', "$($DomainController.HostName)")
                    $props.Add('Filter', "samAccountName -eq '$samAccountName'")
                }#end Else{}                        
            }
        }
        
        $UserList += Get-ADUser @props | Select-Object @splat

        #region :: removed 2018-06-22 :: return object, pipe to show screen
        $UserList = $UserList | Sort-Object samAccountName -Unique | Select-Object @splat
        
        
        switch ($PSBoundParameters.ContainsKey('UpdateLogs')) {
            $true {
                foreach ($item in $UserList) {
                    Switch ($PSBoundParameters.ContainsKey('ShowPass')) {
                        $true { New-AccountLogEntry -newUser $item -Pass $PwdString -workOrder $workOrder}
                        Default { New-AccountLogEntry -newUser $item -exists -workOrder $workOrder}
                    }
                }
            }
            Default { }
        }#end switch()
        
        $userList
    } #end Process{}

    End { } #end End{}
} #end Function Get-UserInfo{}

