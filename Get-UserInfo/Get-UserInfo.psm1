#region :: Header
<#

NAME        : Get-UserInfo.psm1 
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Get AD user info and output to screen for research and account discovery
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 
UPDATED     : 05-30-2019
VERSION     : 1.4



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 04-25-2017 ac007  INITIAL RELEASE
1.1 04-27-2017 ac007  Added module to computer UserAccountControl; removed code from this module.
1.2 04-28-2017 ac007  Added -Screen parameter to facilitate output formatted for notes in Track-It! resolutions.
1.3 05-05-2017 ac007  Added {HomePhone,ipPhone,MobilePhone,OfficePhone,telephoneNumber} to putput
1.4 02-19-2019 ac007  Changed parametersets to allow for both ANR and sAMAccountName queries; also allows sAMAccountName as default without parameter name.


Remove-Module Get-UserInfo;Import-Module Get-UserInfo

#>
#endregion


Function Get-UserInfo{
        Param(
        [Parameter(Mandatory=$true
            ,ParameterSetName='Default'
            ,Position=0)]
        [string]$sAMAccountName,
        
        [Parameter(Mandatory=$false)]
        [switch]$NoOutput=$false,
        
        <#
        [Parameter(Mandatory=$false)]
        [string]$server=$DomainController,
        #>

        [Parameter(Mandatory=$false)]
        [switch]$Students,
        
        [Parameter(Mandatory=$true
            ,ParameterSetName='Anr')]
        [string]$Anr,
        
        [Parameter(Mandatory=$false)]
        [switch]$screen,
        
        [Parameter(Mandatory=$false)]
        [switch]$ShowPass,
        
        [Parameter(Mandatory=$false)]
        [switch]$UpdateLogs
        )

        Begin{
            #$outputLogs = @()
        } #end Begin{}

        Process{
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
                             'wWWHomePage'
                    #Server = $DomainController
            }
            #$props

            $UserList = @()
            write-verbose "Querying host: $($props.server)"
            #foreach($user in $UserNames){

                Switch($PSCmdlet.ParameterSetName){
                    {$_ -eq "Anr"}{
                        if($Students){
                            $props.Add('Server',"STUDENTS")
                            $userList += $(Get-AdUser -Filter "Anr -eq '$Anr'" @props)
                        }#end if{}
                        Else{
                            $props.Add('Server',$DomainController)
                            $userList += $(Get-AdUser -Filter "Anr -eq '$Anr'" @props)
                        }#end Else{}                        
                    }
                    Default{
                    #{$_ -eq "sAM"}{
                        if($Students){
                            $props.Add('Server',"STUDENTS")
                            $userList += $(Get-AdUser -Filter "sAMAccountName -eq '$sAMAccountName'" @props)
                        }#end if{}
                        Else{
                            $props.Add('Server',$DomainController)
                            $userList += $(Get-AdUser -Filter "sAMAccountName -eq '$sAMAccountName'" @props)
                        }#end Else{}                        
                    }
                }

            #} #end foreach($user in $userNames){}

            #region :: removed 2018-06-22 :: return object, pipe to show screen
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
                    , @{N='UAC-Converted'; E={Get-ReadableUAC -userAccountControl $_.UserAccountControl}}
                    , @{N='ChangePasswordNextLogon';E={[bool]$(if($_.'msDS-UserPasswordExpiryTimeComputed' -eq 0){$true}else{$false})}}
                    , 'Enabled'
                    , 'PasswordExpired'
                    , 'PasswordLastSet'
                    , @{N='PasswordExpiry'; E={if($_.'msDS-UserPasswordExpiryTimeComputed' -ne 0){[datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed')}else{$null}}}
                    , @{N='PasswordRemaining'; E={if($_.'msDS-UserPasswordExpiryTimeComputed' -ne 0){$([datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') - (get-date)).Days}else{"Change at next logon"}}}
                    , 'AccountExpirationDate'
                    , 'whenCreated'
                    , 'whenChanged'
                    , 'LastLogonDate'
                    , 'Mail'
                    , 'MailNickname'
                    , @{N='ProxyAddresses'; E={$($($($_.ProxyAddresses).Where( {$_ -clike "smtp*"}).replace("smtp:", "")).split(",")) -join "`r`n"}}
                )
            }
            $UserList = $UserList | Select-Object -Unique | Select-Object @splat
            
            $userList

            switch ($PSBoundParameters.ContainsKey('UpdateLogs')){
                $true{
                    foreach($item in $UserList){
                        Switch($PSBoundParameters.ContainsKey('ShowPass')){
                            $true{Add-SCCCDAccountLogEntry -user $item.sAMAccountName -update -ShowPass}
                            Default{Add-SCCCDAccountLogEntry -user $item.sAMAccountName -update}
                        }
                    }
                }
                Default{}
            }#end switch()

        } #end Process{}

        End{} #end End{}
    } #end Function Get-UserInfo{}

Function Show-User{
        Param(
            [parameter(mandatory=$true, ValueFromPipeLine=$true)]$user,
            [Parameter(Mandatory=$false)][switch]$screen
        )

        Begin{	} #end Begin{}

        Process{

            $flags = $user.UserAccountControl | Get-ReadableUAC #$($flags -join ",")

            #write-host "`nUsername: `"$($user.UserPrincipalName)`"`n______________________________________________________________________"
            Write-Host @"
Username: `"{0}`"
______________________________________________________________________
"@ -f $user.UserPrincipalName
            #region :: New Method

            $proxyAddresses = @()
            #$path = [string]::join(',',$($user.DistinguishedName.split(',')[1..$($($user.DistinguishedName.split(',')).count)]))

            if($user.ProxyAddresses.count -gt 0){
                $proxyAddresses = $user.ProxyAddresses | Where-Object{$_.ToLower() -match "smtp:*"}
                $proxyAddresses = $proxyAddresses | Where-Object{($_ -notmatch $user.Mail) -and ($_ -notmatch $user.UserPrincipalName)}
                $proxyAddresses = $proxyAddresses | ForEach-Object{$_.ToLower().Replace('smtp:','')}

                if($proxyAddresses.count -gt 0){
                    Write-Verbose "$([string]::join(";",$($proxyAddresses)))"
                    Write-Host $null
                }
                else{
                    Write-Verbose "$([string]$($item.Mail))"
                    Write-Host $null
                }
            }
            else{
                $proxyAddresses = $null
            }

            $strProxy = @()
            if($proxyAddresses.count -gt 1){
                for($i=1;$i -lt $($proxyAddresses.count + 1);$i++){
                    $strProxy += "ProxyAddress$($i)       : $($proxyAddresses[$i - 1])"
                }
            }
            elseif($proxyAddresses -eq 0){
                $strProxy = $null
            }
            else{
                $strProxy = "ProxyAddress        : $proxyAddresses"
            }

            #endregion
            $properties = @()
            switch ($PSBoundParameters.ContainsKey('Screen')){
                $false{
                    #region :: Properties version 2
                    $properties = @(
                        "sAMAccountName",
                        "UserPrincipalName",
                        "Name",
                        "DisplayName",
                        "GivenName",
                        "SurName",
                        "GenerationQualifier",
                        "EmployeeID",
                        "ExtensionAttribute1",
                        "Description",
                        "CanonicalName",
                        "Office",
                        "OfficePhone",
                        "IpPhone",
                        "MobilePhone",
                        "Title",
                        "EmployeeType",
                        "Department",
                        "Company",
                        "StreetAddress",
                        "City",
                        "St",
                        "PostalCode",
                        "Country",
                        "HomeDrive",
                        "HomeDirectory",
                        "ScriptPath",
                        "MsNPAllowDialin",
                        "Enabled",
                        "PasswordExpired",
                        "wWWHomePage",
                        "AccountExpirationDate",
                        @{N="AccountExpires";E={"$([datetime]::FromFileTime("$($_.AccountExpires)"))"}},
                        "PasswordLastSet",
                        "WhenCreated",
                        "WhenChanged",
                        "LastLogonDate",
                        @{N="UserAccountControl"; E={$flags}},
                        @{N="PwdExpiryDays"; E={"$(([datetime]::FromFileTime(($($_.'msDS-UserPasswordExpiryTimeComputed'))) - (get-date)).Days) days"}},
                        @{N="PwdExpiryDate"; E={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}},
                        @{N="X400";E={[string]::join("`n",($_.ProxyAddresses | Where-Object{($_ -match "X400:*")}).Replace('X400:','').Replace('x400:',''))}},
                        @{N="EUM";E={[string]::join("`n",(($_.ProxyAddresses | Where-Object{($_ -match "EUM:*")})).Replace('EUM:',''))}},
                        "mailNickname",
                        "Mail",
                        @{N='ProxyAddresses';E={[string]::join("`n",$($proxyAddresses.replace('smtp:','')))}}
                        )
                    #endregion
                }#end $false{}

                $true{
                    #$tmpMail = $($user.Mail)
                    if(![string]::IsNullOrEmpty($user.mail)){
                        if($user.proxyAddresses.count -gt 3){
                            #region :: ProxyAddresses
                            $proxyAddresses = @()
                            #endregion
                        }
                    }#end if
                    write-host @"
Account Information:

SamAccountName      : $($user.sAMAccountName)
$(if($ShowPass){"AccountPassword     : $($(Get-DefaultPassword -User $($user.samaccountname)).Text)`n"}else{$null})
whenCreated         : $($user.whenCreated)
UserPrincipalName   : $($user.UserPrincipalName)
Name                : $($user.Name)
GivenName           : $($user.GivenName)
Surname             : $($user.Surname)
DisplayName         : $($user.DisplayName)
EmployeeID          : $($user.EmployeeID)
ExtensionAttribute1 : $($user.ExtensionAttribute1)
MailNickname        : $($user.Mail)
Mail                : $($user.Mail)
$([string]::join("`r`n",$strProxy))
Description         : $($user.Description)
EmployeeType        : $($user.EmployeeType)
Title               : $($user.Title)
Company             : $($user.Company)
StreetAddress       : $($user.StreetAddress)
City                : $($user.City)
State               : $($user.St)
PostalCode          : $($user.PostalCode)
Department          : $($user.Department)
wWWHomePage         : $($user.wWWHomePage)
Path                : $($user.DistinguishedName)
"@
                }#end $true{}
            }#end switch

            if(!$screen){
                $user | Select-Object -property:$properties | Format-List #-Property:$properties
                write-host "______________________________________________________________________"
            }
        } #end Process{}

        End{
            if(get-variable -name:user -ErrorAction:SilentlyContinue){remove-variable -name User}
        } #end End{}
    } #end Function Show-User{}

<#
Remove-Module Get-UserInfo;Import-Module Get-UserInfo
#>
