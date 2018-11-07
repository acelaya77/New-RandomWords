#region :: Header
<#

NAME        : Update-ADUser.psm1
GROUP       : N/A
IDENTITY    : N/A
MODERATORS  : N/A
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Updates SCCCD Employee AD account: Title,Department,Company,Site,SMTP Address,etc.
UPDATED     : 08-09-2018
VERSION     : 1.3


Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE
1.1 01-29-2018 ac007  Updated user object creation
1.2 03-12-2018 ac007  Added SMTP processing; Updated header.
1.3 08-09-2018 ac007  Added explicit domain controller to query.

#>
#endregion


<#
.SYNOPSIS
Updates existing user in SCCCD.NET domain with new Site-specific info as well as new Title and Department info.
.DESCRIPTION
For SCCCD Employee AD Account, performs the following tasks:
- Updates Title
- Updates Department
- Updates Site information, i.e. Address, Company, HomePage, etc.
- Moves AD object to Site New Accounts OU
.NOTES
Requires RSAT and PowerShell AD Modules

.PARAMETER SamAccountName
User's Login ID in SCCCD.NET
.PARAMETER Site
Site choices
 - "FCC" - Fresno City College
 - "CCC" - Clovis Community College
 - "DO"  - District Office
 - "RC"  - Reedley College
 - "MC"  - Madera Center
#>
Function Update-ADUser{
[CmdletBinding()]

Param(
[Parameter(Position=0,
	Mandatory=$true,
	ValueFromPipeline=$true,
	ValueFromPipelineByPropertyName=$true,
	HelpMessage="Please enter user's SamAccountName")]
	[string]$sAMAccountName,
[Parameter(Position=1,
	Mandatory=$false,
	ValueFromPipeline=$true,
	ValueFromPipelineByPropertyName=$true,
	HelpMessage="Please submit the user's Site (FCC,CCC,DO,RC,MC)")]
	[string]$Site,
[Parameter(Position=2,
	Mandatory=$false,
	ValueFromPipelineByPropertyName=$true,
	ValueFromPipeLine=$true)]
	[string]$Title,
[Parameter(Position=3,
	Mandatory=$false,
	ValueFromPipelineByPropertyName=$true,
	ValueFromPipeline=$true)]
	[string]$Department,
[Parameter(Position=4,
	Mandatory=$false,
	ValueFromPipelineByPropertyName=$true,
	ValueFromPipeline=$true)]
	[string]$Description,
[Parameter(Mandatory=$false,
	HelpMessage="Set this option to move the object to the site new account OU")]
	[switch]$Move = $false,
[Parameter(Mandatory=$false,
    HelpMessage = "Set this option to add new primary SMTP address")]
    [Switch]$AddEmail
)#Param()

	Begin{
		$thisSite = get-SiteInfo -Site $Site
		$country = [PSCustomObject]@{
			c = "US"
			co = "UNITED STATES"
			countryCode = "840"
		}#[PSCustomObject]
        #$DomainController = $(Get-DomainController)[0].Name
        $DomainController = $(Get-ADDomainController -Discover -DomainName "scccd.net" -Service "PrimaryDC").Name
        $DomainController
	}#Begin{}

	Process{
		try{
			$objUser = Get-ADUser $sAMAccountName -Properties * -Server $DomainController
			Log-ADUserGroups "$($objUser.SamAccountName)"
		}
		Catch{
			#write-host "No user found"
            Write-Output "No user found"
			Write-Verbose $_
			Break
		}#catch


		Write-Verbose @"
Updating user account...: $($objUser.DistinguishedName)

StreetAddress...........: "$($thisSite.StreetAddress)"
l (City)................: "$($thisSite.City)"
Company.................: "$($thisSite.Company)"
PostalCode..............: "$($thisSite.PostalCode)"
wWWHomePage.............: "$($thisSite.HomePage)"
Department..............: "$Department"
Description.............: "$Description"
Country.................: "$($thisSite.Country)"
State...................: "$($thisSite.State)"
Clearing................: Office (physicalDeliveryOfficeName)
ResetPassword...........: $(if($resetPassword){"$True"}else{$false})
$(if($ResetPassword){$pass = Get-DefaultPassword -User $objUser.samAccountName;"Password................: $($pass.text)"}else{""})
"@

#region :: New Code =====================================================

<#
$site = "FCC"
#>
$Params = @{}

if($site){
	$NewSite = Get-SiteInfo -site $site
	$Params.Add('PostalCode', $NewSite.PostalCode)
	$Params.Add('City',$NewSite.City)
	$Params.Add('State',$NewSite.State)
	$Params.Add('Company',$NewSite.Company)
	$Params.Add('StreetAddress',$NewSite.StreetAddress)
	$Params.Add('HomePage',$NewSite.HomePage)
	$Params.Add('Country',"US")
}

if($title){
    $Params.Add('Title',$title)
}
if($Department){
    $Params.Add('Department',$Department)
}
if($Description){
    $Params.Add('Description',$Description)
}


#endregion :: New Code ==================================================
		

#region :: Old Code
<#
        $objUser | Set-ADUser -StreetAddress "$($thisSite.streetAddress)"
		$objUser | Set-ADUser -City "$($thisSite.City)"
		$objUser | Set-ADUser -Company "$($thisSite.Company)"
		$objUser | Set-ADUser -PostalCode "$($thisSite.PostalCode)"
		$objUser | Set-ADUser -HomePage "$($thisSite.HomePage)"
		$objUser | Set-ADUser -Country "$($thisSite.Country)"
		$objUser | Set-ADUser -State "$($thisSite.State)"
		$objUser | Set-ADUser -Replace @{'Department'="$Department";'Description'="$Description";'Title'="$Title"}
		$objUser | Set-ADUser -Clear "physicalDeliveryOfficeName"
#>
#endregion

        $objUser | Set-ADUser @Params        
        
        Switch ($ResetPassword){
            $true{
                Write-Verbose "Resetting password to default. (See Get-DefaultPassword)"
                $objUser | Set-ADAccountPassword -NewPassword $pass.secure -Confirm:$false
            }
            Default{}
        }

		switch($move){
			$true{
				Write-Verbose @"
Moving object from:
$($objUser.DistinguishedName)
to:
$($thisSite.ou)
"@
				$objUser | Move-ADObject -TargetPath "$($thisSite.ou)"
			}#true
			$false{
				write-verbose "No move"
			}#$false
		}#switch($move)

		#region :: update log
		$xx = 0
		$counter = 1
		if($title){
            Do{
			    $tmpResults = $null
			    try{$tmpResults = Get-ADUser $objUser.SamAccountName -Properties * -Server $DomainController}catch{write-verbose "Trying again..."}
			    $xx++
			    if($($tmpResults.Title) -eq $Title){Write-Output "$($tmpResults.Title)"}
			    if($counter -gt 79){
				    Write-Host "."
				    $counter = 1
			    }
			    Write-Host -NoNewline "."
			    $counter++
		    }
		    Until(($($tmpResults.Title) -eq $Title))
		    Write-Host "."
        }
        elseif($site){
            Do{
			    $tmpResults = $null
			    try{$tmpResults = Get-ADUser $objUser.SamAccountName -Properties * -Server $DomainController}catch{write-verbose "Trying again..."}
			    $xx++
			    if($($tmpResults.Company) -eq $thisSite.Company){Write-Output "$($tmpResults.Company)"}
			    if($counter -gt 79){
				    Write-Host "."
				    $counter = 1
			    }
			    Write-Host -NoNewline "."
			    $counter++
		    }
		    Until(($($tmpResults.Company) -eq $thisSite.Company))
		    Write-Host "."

        }

        switch($AddEmail){
            $true{
                #$NewMail = "$($objUser.givenname.toLower()).$($objUser.Surname.ToLower())"+"$($thisSite.Domain)"
                #$NewMail = "$($objUser.givenname.toLower()).$($objUser.Surname.ToLower())@$($thisSite.Domain)"
                $NewMail = "{0}.{1}@{2}" -f $($objUser.givenname.toLower()),$($objUser.Surname.ToLower()),$($thisSite.Domain)
                Write-Verbose $NewMail
                
                if($(Get-PSSession).ConfigurationName -notlike "Microsoft.Exchange"){Connect-Exchange}else{}
                #Get-16Mailbox $objUser.samaccountname -DomainController $DomainController | Set-16Mailbox -PrimarySmtpAddress $NewMail -DomainController $DomainController
                Get-Mailbox $objUser.samaccountname -DomainController $DomainController | Set-Mailbox -PrimarySmtpAddress $NewMail -DomainController $DomainController

                $xx = 0
                $counter = 1
                $counter2 = 1
                do{
                    $tmpResults = $null
                    try{$tmpResults = Get-ADUser $objUser.samaccountname -Properties Mail -Server $DomainController}catch{Write-Verbose "Trying again..."}
                    $xx++
                    if($tmpResults.Mail -eq $NewMail){Write-Output "$($tmpResults.Mail)"}
                    if($counter -gt 79){
                        Write-Host " "
                        $counter = 1
                    }
                    Write-Host -NoNewline "."
                    $counter++
                    $counter2++
                }Until(($tmpResults.Mail -eq $NewMail) -or ($counter2 -gt 800))
                Write-Host " "
            }
            Default{}
        }

		Add-SCCCDAccountLogEntry -user "$($objUser.samAccountName)" -update
        #Add-SCCCDAccountLogEntry -user sg002 -update
        Switch($ResetPassword){
            $true{
                $file = gci I:\Continuity\Celaya\AD\New_Accounts\* -Include "*_$($objUser.samaccountName)_$($objuser.employeeid)_update.*"
                $contents = gc $file
                $contents[2] = $contents[2]+"`r`nPasswordReset........: $($pass.text)"
                $contents
                $contents | Out-File $file
            }
            Default{}
        }
		#endregion
	}#Process{}

	End{}#End{}
}#Function Update-ADUser{}

<# 

Remove-Module Update-ADUser
Import-Module Update-ADUser

#>
