Function Log-ADUserGroups{
[CmdletBinding()]

Param(
    [Parameter(Mandatory=$true)]
    [Alias('userName')]
    [string]$strUser,
    [string]$Notes
)
    $groups = $null
    $user = Get-ADUser -Identity $strUser -Properties * <# -Properties Memberof,DisplayName,CanonicalName,ScriptPath,HomeDrive,HomeDirectory,ProxyAddresses #>
    #$strFileName = "$(get-date -f 'yyyyMMdd-hhmmss')-$($user.SAMACCOUNTNAME)-$($user.Givenname.ToLower().replace(" ","-"))-$($user.Surname.ToLower().replace(" ","-")).txt"
    $strFileName = "{0}-{1}-{2}-{3}.txt" -f `
         $(get-date -f 'yyyyMMdd-hhmmss') `
        ,$($user.SAMACCOUNTNAME) `
        ,$(Switch($user.Givenname){{$_ -ne $null}{$_.ToLower().replace(" ","-")};Default{"null"}}) `
        ,$(Switch($user.Surname){{$_ -ne $Null}{$_.ToLower().replace(" ","-")};Default{"null"}})

    $file = (Join-Path "\\sdofs1-08e\is`$\Security Group Logs\" $strFileName)

    $SamAccountName = "$($user.SamAccountName)"
    $DisplayName = "$($user.DisplayName)"
    $CanonicalName = "$($user.CanonicalName)"
    $homeDrive = "$($user.HomeDrive)"
    $homePath = "$($user.HomeDirectory)"
    $script = "$($user.ScriptPath)"
	$groups = $User.MemberOf | Get-ADGroup | select Name
    if(($user.ProxyAddresses -ne $null)){
        $ProxyAddresses = [string]::join("`n                 ",(($user.ProxyAddresses | ?{$_ -match "smtp:*"}).ToLower().Replace('smtp:','')))
    }
    Else{
        $ProxyAddresses = [string]::("`n                 ")
    }
    $header = @"

================================================================================
 TITLE......: AD Account Information Log
 DATE.......: $(get-date -Format 'MM-dd-yyyy')
 TIME.......: $(get-date -Format 'hh:mm:ss tt')
 NOTES......: $Notes
================================================================================

"@
    $notes = @"
	Name..................: $($User.Name)
	SamAccountName........: $($User.SamAccountName)
	UserPrincipalName.....: $($User.UserPrincipalName)
	EmployeeID............: $($User.EmployeeID)
	ExtensionAttribute1...: $($User.ExtensionAttribute1)
	GivenName.............: $($User.GivenName)
	Surname...............: $($User.Surname)
	DisplayName...........: $($User.DisplayName)
	CanonicalName.........: $($User.CanonicalName)
	Company...............: $($User.Company)
	Department............: $($User.Department)
	Title.................: $($User.Title)
	Description...........: $($User.Description)
	HomeDrive.............: $($User.HomeDrive)
	HomeDirectory.........: $($User.HomeDirectory)
	ScriptPath............: $($User.ScriptPath)
	msNPAllowDialin.......: $($User.msNPAllowDialin)
	Mail..................: $($User.Mail)
	SMTP_Addresses........: $(try{[string]::join("`r`n`t......................: ",($(try{$($($($User.ProxyAddresses) | ?{!($_ -match $($User.Mail)) -and !($_ -match $($User.UserPrincipalName)) -and ($_ -cmatch "smtp:*")} | sort).Replace('smtp:',''))}catch{''})))}catch{''})
	Description...........: $($User.Description)
	HomePage..............: $($User.HomePage)
	StreetAddress.........: $($User.StreetAddress)
	City..................: $($User.City)
	PostalCode............: $($User.PostalCode)
	State.................: $($User.State)
	Country...............: $($User.Country)
	whenCreated...........: $($User.whenCreated)
	whenChanged...........: $($User.whenChanged)
	LastLogonDate.........: $($User.LastLogonDate)
	PasswordLastSet.......: $($($User.PasswordLastSet) )
	PasswordExpired.......: $($User.PasswordExpired)
	Enabled...............: $($User.Enabled)
	UserAccountControl....: $(Convert-UserAccountControl $user.UserAccountControl)
	X400..................: $(try{[string]::join("`r`n",($User.ProxyAddresses | ?{($_ -match "X400:*")}).Replace('X400:',''))}catch{''})
	EUM...................: $(try{[string]::join("`r`n",($User.ProxyAddresses | ?{($_ -match "EUM:*")}).Replace('EUM:',''))}catch{''})

Groups:

	$(if($groups.count -gt 0){$([string]::join("`r`n`t",$($($groups  | sort Name).Name)))}else{""})
"@

<#    $header = @"
********************************************************************************
Date:            $(get-date -f 'yyyy/MM/dd hh:mm:ss')
Tech:            $($env:USERNAME)
Name:            $($user.DisplayName)
SamAccountName:  $($user.sAMAccountName)
AD Location:     $($user.CanonicalName)
Logon Script:    $($user.ScriptPath)
Home Drive:      $($user.HomeDrive)
Home Directory:  $($user.HomeDirectory)
ProxyAddresses:  $ProxyAddresses
********************************************************************************

Security Groups:
"@
    <# Removed: 12/12/2016, depricated for the here-string that precedes

    #"Group Membership for $DisplayName ($SamAccountName) as of $(get-date -f 'yyyy/MM/dd hh:mm:ss')" | Out-File -FilePath $file
    "Date: $(get-date -f 'yyyy/MM/dd hh:mm:ss')" | Out-File -FilePath $file
    "Name: $DisplayName" | Out-File -FilePath $file -Append
    "SamAccountName: $SamAccountName" | Out-File -FilePath $file -Append
    
    #12/12/2016: Added to document original account object location, Logon Script, Home path and home directory within AD
    "Account location: $CanonicalName" | Out-File -FilePath $file -Append
    "Logon Script: $script" | Out-File -FilePath $file -Append
    "Home Drive: $homeDrive" | Out-File -FilePath $file -Append
    "Home Path: $homePath" | Out-File -FilePath $file -Append
    #>
    $output = $header
    $output += $Notes
    $output += "`r`n"
    #$header + "`r`n" > $file
    $stream = [System.IO.StreamWriter]::new($file)
    Try{
        $output | Out-String -Stream | ForEach-Object{
            $stream.WriteLine($_.Trim())
        }
    }Finally{
        $stream.Close()
    }

<#
    #$groups = Get-ADPrincipalGroupMembership -Identity "$this"
    $groups = $user.memberof
    $groups = $groups | Get-ADObject | sort Name -Unique
    $counter = 0
    foreach($group in $groups){
        #$counter++
        #Write-Progress -Activity "Removing Groups" -Status "$($counter): Removing group $($group.Name)" -PercentComplete ($counter/$groups.count*100)
        #$($group.Name) | Out-File -FilePath $file -Append
        $($group.name) | Out-File -FilePath $file -Append
    } #end foreach()
#>
    ii $file
}

<#
Remove-Module Log-ADUserGroups
Import-Module Log-ADUserGroups
#>