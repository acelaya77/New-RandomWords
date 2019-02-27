<#
2018-10-03 12:40:00
Log New Accounts

#>
#region :: Header
<#

NAME        : Add-SCCCDAccountLogEntry.psm1
GROUP       : N/A
IDENTITY    : N/A
MODERATORS  : N/A
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Adds log entry for an existing account in AD.
UPDATED     : 11-30-2018
VERSION     : 1.4


Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE
1.1 01-29-2018 ac007  Updated user object creation
1.2 03-12-2018 ac007  Added SMTP processing; Updated header.
1.3 08-09-2018 ac007  Added explicit domain controller to query.
1.4 11-30-2018 ac007  Fixed proxyAddresses.
#>
#endregion


Function Add-SCCCDAccountLogEntry{
#Function Log-NewSCCCDAccount {
[CmdletBinding()]
Param(
	[string]$user,
    [switch]$ShowPass,
	[switch]$update = $false,
    [string]$password
)

Begin{
    #$DomainController = $(Get-DomainController)[0].Name
    #$DomainController
    #$DomainController = $(Get-ADDomainController -Discover -DomainName "scccd.net" -Service "PrimaryDC").Name

	[string]$txtUser = $user
    
	if(gv -Name user,file,stream,stream2 -ErrorAction SilentlyContinue){rv -Name user,file,stream,stream2 -ErrorAction SilentlyContinue}

	Try{
		$user = Get-ADUser $txtUser -Properties * -ErrorAction Stop -Server $DomainController

	}
	Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
		 Write-Verbose "Error: User not found exception"
		 Write-Verbose $_
		 break
	}
	Catch{
		Write-Verbose "Error: $_"
		break
	}

	Try{ $a = Get-ADUser $user.SamAccountName -Properties Mail,ProxyAddresses -ErrorAction Stop -Server $DomainController}
	Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
		 Write-Verbose "Error: User not found in AD"
		 Write-Verbose $_
		 break
	}
	Catch{ 
		Write-Verbose "Error: $_"
		break
	}
    if(gv -Name mail -ErrorAction SilentlyContinue){rv -Name mail -Force -ErrorAction SilentlyContinue}
    
    if(($null -ne $a.Mail) -and ($a.Mail -notmatch "my.scccd.edu")){
        Try{
            $mail = Get-Mailbox $user.SamAccountName -DomainController $DomainController
        }
        Catch{
            Write-Verbose "Error:"
            Write-Verbose $_
        }
    }
    else{
        #$false
    }
	$proxyAddresses = @()

	$strFilePath = (Join-Path "\\sdofs1-08e\is`$\Continuity\Celaya\AD\" "New_Accounts")
    $strFilePath2 = (Join-Path "C:\Users\ac007\TrackIT-Export" "Logs")
	$strFileName = "{0}_{1}_{2}_{3}_{4}_update.txt" -f $(get-date $($user.whenCreated -as [datetime]) -Format "yyyyMMdd-HHmmss"),$($user.samAccountName),$($user.EmployeeID),$user.GivenName.ToLower(),$user.Surname.ToLower()
    $file = (Join-Path $strFilePath $strFileName)
    $file2 = (Join-Path $strFilePath2 $strFileName)

	$path = [string]::join(',',$($user.DistinguishedName.split(',')[1..$($($user.DistinguishedName.split(',')).count)]))

	#$accountPassword = Get-DefaultPassword -User $user.SamAccountName
    #$accountPassword = $password

	#if($a.ProxyAddresses.count -gt 0){
    if($mail.EmailAddresses.count -gt 1){
        Write-Verbose "Enumerating filtered email addresses"
        $proxyAddresses = $($mail.EmailAddresses | Where-Object {($_ -cmatch 'smtp*') -and ($_ -inotlike '*.net')})
        if($proxyAddresses.count -gt 0){
            $proxyAddresses = $proxyAddresses.replace('smtp:','')
        }
         
		if($proxyAddresses.count -gt 0){
			Write-Verbose "$([string]::join(";",$($proxyAddresses)))"
			Write-Host $null
		}
		else{
			Write-Verbose "$([string]::join(';',$($user.Mail)))"
			Write-Host $null
		}
	}
	else{
		$proxyAddresses = $null
	}

	$strProxy = @()
	if($proxyAddresses.count -gt 1){
		for($i=1;$i -lt $($proxyAddresses.count + 1);$i++){
			$strProxy += "ProxyAddress$($i)........: $($proxyAddresses[$i - 1])"
		}
	}
	elseif($proxyAddresses -eq 0){
		$strProxy = $null
	}
	else{
		$strProxy = "ProxyAddress.........: $proxyAddresses"
	}
}#end Begin{}

Process{

	write-verbose $(if($update){"$true"}else{"$false"})
	Switch($update){
		$true {
			$fileOut = @"
$(get-date -f 'MM-dd-yyyy HH:mm:ss')
Updated Account Information:

SamAccountName.......: $($user.samAccountName)
$(Switch($ShowPass){
        $true{
            "Password.............: $Password " # $($accountPassword.Text)"
        }
        Default{""}
})

whenCreated..........: $($user.whenCreated)
UserPrincipalName....: $($user.UserPrincipalName)
Name.................: $($user.Name)
GivenName............: $($user.GivenName)
Surname..............: $($user.Surname)
Suffix...............: $($user.generationQualifier)
DisplayName..........: $($user.DisplayName)
EmployeeID...........: $($user.EmployeeID)
ExtensionAttribute1..: $($user.ExtensionAttribute1)
Mail.................: $($mail.PrimarySmtpAddress)
$(if($strProxy){$([string]::join("`r`n",$strProxy))}else{"ProxyAddress.........: "})
Description..........: $($user.Description)
Title................: $($user.Title)
Company..............: $($user.Company)
StreetAddress........: $($user.StreetAddress)
City.................: $($user.City)
State................: $($user.State)
PostalCode...........: $($user.PostalCode)
Department...........: $($user.Department)
wWWHomePage..........: $(if($user.wWWHomePage -ne $null){$($($user.wWWHomePage).replace(' ',''))}else{$null})
Path.................: $path

"@
		$strFileName = "{0}_{1}_{2}_{3}_{4}_update.txt" -f $(get-date $($user.whenCreated -as [datetime]) -Format "yyyyMMdd-HHmmss"),$($user.samAccountName),$($user.EmployeeID),$user.Givenname.ToLower(),$user.Surname.ToLower()
		}#end $true Case
		Default {
		$fileOut = @"
$(get-date -f 'MM-dd-yyyy HH:mm:ss')
New Account Information:

SamAccountName.......: $($user.samAccountName)
$(Switch($ShowPass){
        $true{
            "AccountPassword......: $Password" #$($accountPassword.Text)"}
        }
        Default{""}
})

whenCreated..........: $($user.whenCreated)
UserPrincipalName....: $($user.UserPrincipalName)
Name.................: $($user.Name)
GivenName............: $($user.GivenName)
Surname..............: $($user.Surname)
Suffix...............: $($user.generationQualifier)
DisplayName..........: $($user.DisplayName)
EmployeeID...........: $($user.EmployeeID)
ExtensionAttribute1..: $($user.ExtensionAttribute1)
Mail.................: $($mail.PrimarySMTPAddress)
$(if($strProxy){$([string]::join("`r`n",$strProxy))}else{"ProxyAddress.........: "})
Description..........: $($user.Description)
Title................: $($user.Title)
Company..............: $($user.Company)
StreetAddress........: $($user.StreetAddress)
City.................: $($user.City)
State................: $($user.State)
PostalCode...........: $($user.PostalCode)
Department...........: $($user.Department)
wWWHomePage..........: $(if($user.wWWHomePage -ne $null){$($($user.wWWHomePage).replace(' ',''))}else{$null})
Path.................: $path

"@

		}#end $false case
	}#end switch($update){}

#$fileOut | Out-File -FilePath "$($strFilePath)\$($strFileName)" -Force

$stream = [system.io.streamwriter]::new($file)
$stream2 = [system.io.streamwriter]::new($file2)

Try{
    $fileOut | Out-String -Stream | foreach-object{
        $stream.WriteLine($_.Trim())
        $stream2.WriteLine($_.Trim())
    }
}
Finally{
    $stream.Close()
    $stream2.Close()
}

#$strFileCopy = "{0}-{1}-{2}-{3}.log" -f $user.SamAccountName, $(Switch($user.EmployeeID){{$null -ne $_}{$_};Default{$null}}), $(Switch($user.GivenName){{$null -ne $_}{$_.Replace(" ","-").ToLower()};Default{$null}}),$(Switch($user.Surname){{$null -ne $_}{$_.Replace(" ","-").Tolower()};Default{}})
#$thisCopy = Copy-Item $file -Destination (Join-Path "C:\Users\ac007\TrackIT-Export\" $strFileCopy) -PassThru | Select-Object -ExpandProperty FullName
#$thisCopy = Copy-Item $file -Destination (Join-Path "C:\Users\ac007\TrackIT-Export\Logs" $strFileName) -PassThru | Select-Object -ExpandProperty FullName
#np++ (Join-Path "C:\Users\ac007\TrackIT-Export\" $strFileCopy)
#np++ $thisCopy

}#end Process{}

}

<#

Remove-Module Add-SCCCDAccountLogEntry
Import-Module Add-SCCCDAccountLogEntry

#>

