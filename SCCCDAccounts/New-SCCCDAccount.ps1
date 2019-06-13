
#region :: Header
<#

NAME        : New-SCCCDAccount.ps1 
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Home funtion for new SCCCD accounts.
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 
UPDATED     : 02-11-2019
VERSION     : 1.3



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE
1.1 12-13-2018 ac007  Removed all functions to separate files.
1.2 01-07-2019 ac007  Updated to include new filter switch to Initialize-TrackitInformation function, which will only include 'Open' tickets.
1.3 02-11-2019 ac007  Added OWA Outlook policy '2016 OWA Policy' as default.

#>
#endregion


Function New-SCCCDAccount{
    [CmdletBinding(SupportsShouldProcess)]
    Param(
         [Parameter(Mandatory=$true,ParameterSetName='Default')]
         [Parameter(Mandatory=$true,ParameterSetName='WithAttributes')]
         [string]$EmployeeID
        
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')]
         [Parameter(Mandatory=$false,ParameterSetName='WithAttributes')]
         [switch]$HasEmail = $false
        
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')]
         [Parameter(Mandatory=$false,ParameterSetName='WithAttributes')]
         [switch]$IsStudent = $false
        
        ,[Parameter(Mandatory=$false,ParameterSetName='Initialize')]
         [switch]$Initialize = $false
        
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')]
         [Parameter(Mandatory=$false,ParameterSetName='WithAttributes')]
         [switch]$DebugMe = $false
        
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')]
         [string]$PreferredName
        
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')]
         [Parameter(Mandatory=$false,ParameterSetName='WithAttributes')]
         [switch]$NoPosition
        
        ,[Parameter(Mandatory=$true,ParameterSetName='WithAttributes')]
         [string]$Department
        
        ,[Parameter(Mandatory=$true,ParameterSetName='WithAttributes')]
         [string]$Campus
        
        ,[Parameter(Mandatory=$true,ParameterSetName='WithAttributes')]
         [string]$EmployeeType

        ,[Parameter(Mandatory=$true,ParameterSetName='WithAttributes')]
         [string]$Title
    )

    Try{
        Remove-Variable -Name secondarySMTP,primarySMTP,sqlResults,accountSplat,missingAttributes, `
            newAccount,AccountSuccess,thisOutput,password,primarySMTPAddress,newMailbox,DomainController, `
            date,accountexists,trackItInfo,strSamAccountName,strSite -ErrorAction SilentlyContinue
    }
    Catch{
        Write-Verbose "Error removing variables"
    }
    Switch($Initialize){
        $true{
            #Initialize-TrackItExportFile
            Initialize-TrackItInformation -Filter
            Break
        }
        Default{
            $Initialize = $false
            #Return
        }
    }
    if($PSCmdlet.ParameterSetName -eq 'Initialize'){
        Break
    }
    Switch($DebugMe){
        $true{
            $previousDebugPreference = $DebugPreference
            $DebugPreference = 'Inquire'
        }
        Default{}
    }
    #region :: Variables
    #$DomainController = $(Get-16DomainController)[0].Name
    #$DomainController = 'SDODC1-08e'
    $DomainController = $(Get-ADDomainController -Discover -DomainName "scccd.net" -Service "PrimaryDC").Name
    $date = get-date
    $password = New-RandomPassword -length 10
    
    Switch($PSBoundParameters.ContainsKey('NoPosition')){
        #Student or other user who has no PERSTAT or POS
        Default{
            $sqlResults = Get-SQLWebAdvisorID -EmployeeID $EmployeeID
            if([string]::IsNullOrEmpty($sqlResults)){
                #Wait-Debugger
                Write-Debug "No SQL Results"
                $sqlResults = Get-SQLWebAdvisorID -EmployeeID $EmployeeID -NoPosition
            }
        }
        #Has PERSTAT or POS
        $true{
            $sqlResults = Get-SQLWebAdvisorID -EmployeeID $EmployeeID -NoPosition
            if([string]::IsNullOrEmpty($sqlResults)){
                #Wait-Debugger
                Write-Debug "No SQL Results"
                break
            }
        }
    }



    if(![string]::IsNullOrEmpty($sqlResults.sAMAccountName)){
        [bool]$accountExists = $true
        break
    }
    else{
        [bool]$accountExists = Test-ADAccountExist -EmployeeID $EmployeeID
    }

    $trackItInfo = Get-TrackItInfo -EmployeeID $EmployeeID

    Switch(($PSCmdlet.ParameterSetName -eq 'WithAttributes') -or ([string]::IsNullOrEmpty($trackItInfo))){

        $true{
            Wait-Debugger
            write-host "Wait here"

            $trackItInfo = @{}
            $trackItInfo.Site = $Campus
            $trackItInfo.Department = $Department
            $trackItInfo.EmployeeType = $EmployeeType
            $trackItInfo.Title = $Title
        }
        
        Default{
            #Wait-Debugger
            write-host "Wait here"
        }

    }

    $strSamAccountName = Get-NextSamAccountName -Initials $("{0}{1}" -f $sqlResults.GIVENNAME.Substring(0,1).ToLower(),$sqlResults.SURNAME.Substring(0,1).ToLower())
    #enregion

    if(![string]::IsNullOrEmpty($trackItInfo.Site)){
        $strSite = $trackItInfo.Site
    }
    elseif(![string]::IsNullOrEmpty($sqlResults.SITE)){
        $strSite = $sqlResults.SITE
    }
    else{
        $strSite = $null
    }

    if([string]::IsNullOrEmpty($strSite)){
        $strSite = $(get-SiteInfo -help).Site
    }

    $site = get-SiteInfo $strSite

    if([string]::IsNullOrEmpty($sqlResults.EXTENSIONATTRIBUTE1)){
        Write-Output $("WARNING: No ExtensionAttribute1 for {2}, {0} {1}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID)
        $temp_SQL_Results = Get-SQLWebAdvisorID -EmployeeID $EmployeeID -NoPosition
        if([string]::IsNullOrEmpty($temp_SQL_Results.EXTENSIONATTRIBUTE1)){
            $sqlResults.EXTENSIONATTRIBUTE1 = $temp_SQL_Results.EXTENSIONATTRIBUTE1
        }
        else{
            $sqlResults.EXTENSIONATTRIBUTE1 = Read-Host $("What is the WebAdvisorID (ExtensionAttribute1) for ({0}, {1} {2})?" -f $sqlResults.EMPLOYEEID,$sqlResults.GIVENNAME,$sqlResults.SURNAME)
        }
    }

    if($accountExists){
        #Write-Debug $("{0} {1}" -f $sqlResults.Givenname,$sqlResults.Surname)
        try{
            Remove-Variable -Name g -Force -ErrorAction SilentlyContinue
        }
        catch{
        }

        $tempUser = Get-UserInfo -Anr $("{0} {1}" -f $($sqlResults.Givenname),$($sqlResults.Surname))
        #$tempUser | Get-Member
        Wait-Debugger
        Write-Host "Testing"
        write-Host $($tempUser.sAMAccountName)
        #Remove-Module SCCCDAccounts;Import-Module SCCCDAccounts
        $tempUser | Format-List

        #Wait-Debugger
        #Write-Debug $($str)
        if(![string]::IsNullOrEmpty($tempUser.EmployeeID) -and ($tempUser.EmployeeID -ne $sqlResults.EmployeeID)){
            #Write-Output "Found existing user by name, but has EmployeeID which doesn't match"
            Write-Output "Found existing user by name, but has EmployeeID which doesn't match"
            $accountExists = $false
        }
        elseif([string]::IsNullOrEmpty($tempUser.EmployeeID) -and ([string]::IsNullOrEmpty())){
            #Write-Host "Found matching AD user by name, but has no EmployeeID"
            Write-Host "Found matching AD user by name, but has no EmployeeID"
            $accountExists = $false
        }
        else{
            break
        }
    }


    Switch($IsStudent){
        $true{
            $strSamAccountName = $("{0}{1}{2}" -f $sqlResults.GIVENNAME.Substring(0,1).ToLower(),$sqlResults.SURNAME.Substring(0,1).ToLower(),$sqlResults.EMPLOYEEID)
        }
    }

    if(-not $PSBoundParameters.ContainsKey('IsStudent')){
        if(($sqlResults.EMPLOYEETYPE -eq $trackItInfo.EmployeeType -and ![string]::IsNullOrEmpty($sqlResults.DEPARTMENT))) {
            $EmployeeType = $sqlResults.EMPLOYEETYPE
        }
        elseif(![string]::IsNullOrEmpty($trackItInfo.EmployeeType)){
            $EmployeeType = $trackItInfo.EmployeeType
        }
        elseif(($sqlResults.CHANGEDATE -gt $($(get-date).AddDays(-30))) -and ![string]::IsNullOrEmpty($sqlResults.EMPLOYEETYPE)) {
            $EmployeeType = $sqlResults.EMPLOYEETYPE
        }
        else{
            $EmployeeType = $(Read-Host -Prompt "Employee type? (Classified,Management,Faculty,Adjunct,Student)")
        }
    }
    else{
        $EmployeeType = "Student"
    }

    if($EmployeeType -notin @("Classified","Management","Faculty","Adjunct","Student")){
        Switch($EmployeeType){
            {$_ -in @("Intern","Non-Bargaining")}{
                $EmployeeType = "Classified"
            }
            Default{
                $EmployeeType = $(Read-Host -Prompt "Employee type? (Classified,Management,Faculty,Adjunct,Student)")
            }
        }
    }

    Write-Verbose $EmployeeType

    if([string]::IsNullOrEmpty($trackItInfo.Department)){
        Wait-Debugger
        #$department = $sqlResults.DEPARTMENT
        if(![string]::IsNullOrEmpty($sqlResults.DEPARTMENT)){
            Write-Debug -Message "SQL Results for DEPARTMENT are blank or NULL"
            #Wait-Debugger
            $department = $sqlResults.DEPARTMENT
        }
        else{
            Wait-Debugger
            $department = Read-Host -Prompt $("What is the DEPARTMENT for ({2}, {0} {1})" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID)
        }    
    }else{
        $Department = $trackItInfo.Department
    }
    
    Write-Verbose $Department
     
    if(($PSCmdlet.ParameterSetName -eq "WithAttributes") -and ![string]::IsNullOrEmpty($Title)){
        $Title
    }
    elseif(![string]::IsNullOrEmpty($sqlResults.TITLE)){
        $Title = $sqlResults.TITLE
    }
    elseif(![string]::IsNullOrEmpty($trackItInfo.Title)){
        $Title = $trackItInfo.Title
    }
    else{
        $title = $null
        #$title = Read-Host -Prompt $("What is the TITLE for ({2}, {0} {1})" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID)

    }

    $accountSplat = @{
        AccountPassword       = $password.secure
        EmployeeID            = $EmployeeID
        Enabled               = $true
        Whatif                = $false
        sAMAccountName        = $strSamAccountName
        #UserPrincipalName     = $("{0}@SCCCD.NET" -f $strSamAccountName)
        ChangePasswordAtLogon = $true
    }

    if(![string]::IsNullOrEmpty($department)){
        $accountSplat.Add('Department',$department)
    }

    if(![string]::IsNullOrEmpty($title)){
        $accountSplat.Add('Title',$title)
    }

    if(![string]::IsNullOrEmpty($sqlResults.EXTENSIONATTRIBUTE1)){
        $accountSplat.Add('OtherAttributes',@{ExtensionAttribute1=$sqlResults.EXTENSIONATTRIBUTE1})
    }

    if($PSBoundParameters.ContainsKey('IsStudent')){
        $accountSplat.UserPrincipalName = $("{0}@SCCCD.NET" -f $strSamAccountName)
    }

    if($PSBoundParameters.ContainsKey('HasEmail')){
        $mailboxSplat = @{
            Alias = $strSamAccountName
            Database = $(Get-ExchangeDatabase -Site $site.Site -EmployeeType $EmployeeType)
        }
    }

    if(!(($site -like "") -or ($null -eq $site))){
        $accountSplat.Add('City',$site.City)
        $accountSplat.Add('Company',$site.Company)
        $accountSplat.Add('State',$site.State)
        $accountSplat.Add('PostalCode',$site.PostalCode)
        $accountSplat.Add('StreetAddress',$site.StreetAddress)
        $accountSplat.Add('Country',$site.Country)
        $accountSplat.Add('HomePage',$site.HomePage)
        $accountSplat.Add('Description',$("{0} - {1} - {2}" -f $site.Site,$department,$EmployeeType.Substring(0,1)))
        $accountSplat.Add('Path',$site.OU)
    }

    #Wait-Debugger
    Write-Debug $($accountSplat.GetEnumerator() | Out-String)

    if($sqlResults.PREFERREDNAME -ne "" -or $preferredName -ne ""){
        if($PreferredName -ne ''){
            $accountSplat.Add('DisplayName',$("{0} {1}" -f $PreferredName,$sqlResults.SURNAME))
            $prefFirstName = $PreferredName
            $LastName = $sqlResults.SURNAME
        }
        elseif($sqlResults.PREFERREDNAME -ne ''){
            $accountSplat.Add('DisplayName',$("{0}" -f $sqlResults.PREFERREDNAME,$sqlResults.SURNAME))
            $prefFirstName = $sqlResults.PREFERREDNAME.Split(" ")[0]
            $LastName = $sqlResults.PREFERREDNAME.Split(" ")[-1]
        }
        if($PSBoundParameters.ContainsKey('HasEmail')){
            $secondarySMTP = $("{0}.{1}@{2}" -f $prefFirstName.ToLower().Replace(' ','-'),$LastName.ToLower().Replace(' ','-'),$site.Domain)
        }
    }
    else{
        $accountSplat.Add('DisplayName',$("{0} {1}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME))
    }
    $accountSplat.Add('Givenname',$("{0}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME))
    $accountSplat.Add('Surname',$("{1}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME))
    #$accountSplat.Add('Name',$accountSplat.DisplayName)
    $accountSplat.Add('Name',$("{0} {1}" -f $accountSplat.Givenname,$accountSplat.Surname))

    $primarySMTPAddress = $("{0}.{1}@{2}" -f $sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower(),$site.Domain)
    #Write-Debug $primarySMTPAddress

    if($EmployeeType -ne "Student"){
        $accountSplat.UserPrincipalName = $("{0}@{1}" -f $strSamAccountName,$primarySMTPAddress.Split('@')[1])
    }

    $accountSplat.GetEnumerator() #| fl

    #$continue = Read-Host "Continue? [Y|N]"
    $continue = 'y'
    if($continue -notmatch "y|Y|yes|Yes|true|1"){break}
    if($continue -match "y|Y|yes|Yes|true|1"){
        $strTeeFilename = (Join-Path (Join-Path ([Environment]::GetFolderPath("UserProfile")) "TrackIt-Export") $("{0}_{1}_{2}_{3}_{4}_pw.log" -f $(get-date $date -f 'yyyyMMdd-HHmmss'),$strSamAccountName,$EmployeeID,$sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower()))
        if(!($accountExists)){

            $missingAttributes = Test-MissingAttributes $accountSplat
            if($missingAttributes){
                $("Missing Attributes: {0}" -f $missingAttributes)
            }
            if($missingAttributes -eq 'None'){
                #region :: Create Account; log password

                Write-Debug $($(@"
Login:             {0}
Givenname:         {1}
Surname:           {2}
EmployeeID:        {3}
UserPrincipalName: {4}
IsStudent:         {5}
Database:          {6}
"@) -f $accountSplat.sAMAccountName,$accountSplat.Givenname,$accountSplat.Surname,$accountSplat.EmployeeID,$accountSplat.UserPrincipalName,$($PSBoundParameters.ContainsKey('IsStudent')),$mailboxSplat.Database)

                if($PSCmdlet.ShouldProcess("SCCCD", "Adding $($accountSplat.sAMAccountName) to ")) {
                    New-ADUser @accountSplat -Server $DomainController -PassThru | Tee-Object $strTeeFilename
                    $("`r`nPassword          : $($password.text)`r`nPasswordPhonetic  : $($password.Phonetic)`r`n") | Out-String | Out-File -Append $strTeeFilename
                }
                #endregion
            }
            else{
                Write-Debug "Missing values"
                $missingAttributes
                break
                #$halt = $true
            }
        }

        $Counter = 0
        do{
            Try{
                $newAccount = Get-ADUser $accountSplat.sAMAccountName -Properties * -ErrorAction Stop -Server $DomainController
                [bool]$AccountSuccess = $true
            }
            Catch{
                [bool]$AccountSuccess = $false
            }
            if(($counter -gt 0) -and ([string]::IsNullOrEmpty($newAccount.UserPrincipalName))){
                Write-Output $("{0} Seconds. Waiting to try again." -f $($counter * 30))
                Start-Sleep -Seconds 30
            }
            $counter++

        }
        Until((![string]::IsNullOrEmpty($newAccount.UserPrincipalName)) -or ($counter -gt 5))

        if(Get-Variable -Name thisOutput -ErrorAction SilentlyContinue){Remove-Variable -Force thisOutput -ErrorAction SilentlyContinue}
#region :: Output
        $thisOutput = @"
$(get-date $date -f 'MM/dd/yyyy HH:mm:ss')

SamAccountName...... : $($newAccount.SamAccountName)
Password............ : $($password.Text)
MustChangeOnLogon... : $true

UserPrincipalName... : $($newAccount.UserPrincipalName)
Name................ : $($newAccount.Name)
DisplayName......... : $($newAccount.DisplayName)
GivenName........... : $($newAccount.Givenname)
Surname............. : $($newAccount.Surname)
EmployeeID.......... : $($newAccount.EmployeeID)
ExtensionAttribute1. : $($newAccount.ExtensionAttribute1)
Company............. : $($newAccount.Company)
Department.......... : $($newAccount.Department)
Description......... : $($newAccount.Description)
StreetAddress....... : $($newAccount.StreetAddress)
City................ : $($newAccount.City)
State............... : $($newAccount.State)
PostalCode.......... : $($newAccount.PostalCode)
Country............. : $($newAccount.Country)
HomePage............ : $($newAccount.HomePage)
Enabled............. : $($newAccount.Enabled)
ObjectClass......... : $($newAccount.ObjectClass)
ObjectGUID ......... : $($newAccount.ObjectGUID)
SID................. : $($newAccount.SID)
DistinguishedName... : $($newAccount.DistinguishedName)
Path................ : $($newAccount.DistinguishedName.Split(",")[1..4] -join ",")

"@
#endregion
    }
    
    Remove-FromTrackItExport -User $newAccount.EmployeeID
    
    $hashFile = (Join-Path $([environment]::GetFolderPath("UserProfile")) "ADHash.xml")
    $Global:ADHash[$newAccount.EmployeeID] = $newAccount.sAMAccountName
    $Global:ADHash | Export-CliXml -Path $hashFile
    $Global:ADHash.GetEnumerator() | Select-Object Key,Value | Sort-Object Key | Export-Csv -Delimiter "," -NoTypeInformation $hashFile.replace('.xml','.csv')

    Switch(($HasEmail) -and (!$accountExists)){
        $true{
            $primarySMTPAddress = $("{0}.{1}@{2}" -f $sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower(),$site.Domain)

            #$emailAddressAvailable = Test-EmailAddressAvailable -EmailAddress $primarySMTPAddress

            $count = 0
            Do{
                $emailAddressAvailable = Test-EmailAddressAvailable -EmailAddress $primarySMTPAddress
                if($count -gt 1 -or (!$emailAddressAvailable)){
                    $primarySMTPAddress = Read-Host -Prompt $("What is the next email address for ({2}, {0} {1})" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID,$site.Domain)
                    $count++
                    Start-Sleep -Seconds 3
                }
            }
            Until($emailAddressAvailable)

            $mailboxSplat.Add('PrimarySMTPAddress',$primarySMTPAddress)
            $mailboxSplat.Add('Identity',$strSamAccountName)


            if($PSCmdlet.ShouldProcess("SCCCD Exchange","Adding $mailboxSplat to")){
                Try{
                    if($issues){pause}
                    #Write-Output $mailboxSplat.PrimarySMTPAddress

                    Write-Debug $($mailboxSplat.PrimarySMTPAddress)
                    Enable-Mailbox @mailboxSplat -DomainController $DomainController | Out-Null
                    
                    $tmpCounter = 0
                    do{
                        $tmpCounter++
                        if($tmpCounter -gt 3){Wait-Debugger}
                        $tmpMailbox = $Null
                        $tmpMailbox = Get-Mailbox $mailboxSplat.Alias -DomainController $DomainController
#region 
                        if(![string]::IsNullOrEmpty($tmpMailbox.Alias)){
                            Try{
                                #Wait-Debugger
                                Write-Host "$($tmpMailbox.Alias)"
                                Write-Host $(@'
Get-Mailbox {0} -DomainController {1} | Set-CASMailbox -OwaMailboxPolicy '2016 OWA Policy' -DomainController {1} -ErrorAction Stop
'@ -f $tmpMailbox.Alias,$DomainController)
                                
                                Start-Sleep -Seconds 5
                                Get-Mailbox $tmpMailbox.Alias -DomainController $DomainController | Set-CASMailbox -OwaMailboxPolicy '2016 OWA Policy' -DomainController $DomainController -ErrorAction Stop
                            }
                            Catch{
                                Write-Output "Couldn't set OWA Policy"
                                Throw $_
                                Write-Output "Get-Mailbox $($tmpMailbox.Alias) -DomainController $($DomainController) | set-CASMailbox -OwaMailboxPolicy '2016 OWA Policy' -DomainController $($DomainController)"
                            }
                        }

#endregion

                    }
                    While([string]::IsNullOrEmpty($tmpMailbox.Alias))
                    Remove-Variable -Name tmpCounter -ErrorAction SilentlyContinue


                    [bool]$MailboxSuccess = $true
                }
                Catch{
                    [bool]$MailboxSuccess = $false
                }

                if(![string]::IsNullOrEmpty($secondarySMTP)){
                    if((Test-EmailAddressAvailable -EmailAddress $secondarySMTP)){
                        $c = 0
                        $m = $null
                        do{
                            $m = Get-Mailbox $mailboxSplat.Alias -DomainController $DomainController
                            if($c -gt 0){
                                Start-Sleep -Seconds 30
                            }
                            $c++
                        }
                        Until((![string]::IsNullOrEmpty($m.PrimarySMTPAddress)) -or ($c -gt 5))
                        
                        if(Test-EmailAddressAvailable -EmailAddress $secondarySMTP){
                            Try{
                                #$strAddresses = $("`"SMTP:{0}`",`"smtp:{1}`"" -f $secondarySMTP,$primarySMTPAddress)
                                #Get-Mailbox $mailboxSplat.Alias | Set-Mailbox -EmailAddresses $strAddresses  -DomainController $DomainController
                                #Wait-Debugger
                                Write-Debug -Message "Check Secondary SMTP Address: $secondarySMTP"

                                #Get-Mailbox $mailboxSplat.Alias | Set-Mailbox -EmailAddresses "SMTP:$($secondarySMTP)","smtp:$($primarySMTPAddress)" -DomainController $DomainController
                                $thisMailbox = Get-Mailbox $mailboxSplat.Alias -DomainController $DomainController
                                Set-Mailbox $thisMailbox.Alias -PrimarySMTPAddress $secondarySMTP -DomainController $DomainController
                                Set-Mailbox $thisMailbox.Alias -SimpleDisplayName $("{0} {1}" -f $prefFirstName,$accountSplat.SURNAME) -DomainController $DomainController

                                $c = 0
                                $m = $null
                                do{
                                    $m = get-mailbox $mailboxSplat.Alias -DomainController $DomainController
                                    if($c -gt 0){Start-Sleep -Seconds 15}
                                    $c++
                                }Until($m.PrimarySMTPAddress -eq $secondarySMTP)
                                Write-Debug -Message $("Added secondary SMTP address, {0}" -f $secondarySMTP)
                            }
                            Catch{
                                Write-Verbose "Error $_"
                            }
                        }
                    }
                }
            }
            if(Get-Variable -Name newMailbox -ErrorAction SilentlyContinue){Remove-Variable -Name newMailbox -Force -ErrorAction SilentlyContinue}
            $counter = 0
            do{
                Try{
                    $newMailbox = Get-Mailbox $mailboxSplat.Alias -ErrorAction Stop -DomainController $DomainController
                }
                Catch{
                    Write-Verbose "Error $_"
                }
                if(($counter -gt 0) -and ([string]::IsNullOrEmpty($newMailbox.PrimarySMTPAddress))){
                    Write-Output @("{0} Seconds. Waiting to try again." -f $($counter * 30))
                    Start-Sleep -Seconds 30
                }
                $counter++
            }
            Until((![string]::IsNullOrEmpty($newMailbox.PrimarySMTPAddress)) -or ($counter -gt 5))
            #Mail................ : $($newAccount.Mail)
            $thisOutput += @"
PrimaryMail......... : $($newMailbox.PrimarySmtpAddress)
SecondaryMail....... : $(if($newMailbox.EmailAddresses.Where({$_ -clike "smtp*"}).count -gt 0 ){$newMailbox.EmailAddresses.Where({$_ -clike "smtp*"}).replace('smtp:','')}else{$null})
SimpleDisplayName... : $(if(![string]::IsNullOrEmpty($newMailbox.SimpleDisplayName)){$newMailbox.SimpleDisplayName}else{$null})
"@
        }
        Default{
        }
    }
    if(!$accountExists){
        $strOutputFilename = (Join-Path (Join-Path ([Environment]::GetFolderPath("UserProfile")) "TrackIt-Export") $("{0}_{1}_{2}_{3}_{4}.log" -f $(get-date $date -f 'yyyyMMdd-HHmmss'),$strSamAccountName,$EmployeeID,$sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower()))
        $stream = [system.io.streamwriter]::new($strOutputFilename)
        Try{
            $thisOutput | Out-String | ForEach-Object{
                $stream.WriteLine($_)
            }
        }
        Finally{
            $stream.Close()
            Copy-Item -Path $strOutputFilename -Destination (Join-Path '\\sdofs1-08e\is$\Continuity\Celaya\AD\New_Accounts' (Split-Path $strOutputFilename -Leaf))
            if($AccountSuccess){
                Remove-Item $strTeeFilename
            }
            #np++ $strOutputFilename
        }
    }

    $DebugPreference = $previousDebugPreference
}

<#
Remove-Module SCCCDAccounts
Import-Module SCCCDAccounts
#>
