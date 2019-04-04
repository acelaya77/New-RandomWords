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
	[string]$txtUser = $user
    $date = get-date
	if(gv -Name user,file,stream,stream2 -ErrorAction SilentlyContinue){rv -Name user,file,stream,stream2 -ErrorAction SilentlyContinue}

	Try{
        $user = Get-ADUser $txtUser -Properties * -ErrorAction Stop -Server $DomainController }
	Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
		 Write-Verbose "Error: User not found exception"
		 Write-Verbose $_
		 break }
	Catch{
		Write-Verbose "Error: $_"
		break }

	Try{ 
        $a = Get-ADUser $user.SamAccountName -Properties Mail,ProxyAddresses -ErrorAction Stop -Server $DomainController }
	Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
		 Write-Verbose "Error: User not found in AD"
		 Write-Verbose $_
		 break }
	Catch{ 
		Write-Verbose "Error: $_"
		break }
    
    if(Get-Variable -Name mail -ErrorAction SilentlyContinue){rv -Name mail -ErrorAction SilentlyContinue}
    
    if(!([string]::IsNullOrEmpty($a.Mail)) -and ($a.Mail -notmatch "my.scccd.edu")){
        Try{
            $mail = Get-Mailbox $user.SamAccountName -DomainController $DomainController -ErrorAction:Stop
            $CASmail = Get-CASMailbox $user.SamAccountName -DomainController $DomainController -ErrorAction:Stop }
        Catch{
            Write-Verbose "Error:"
            Write-Verbose $_ }
    }

	$proxyAddresses = @()

	$strFilePath = (Join-Path "\\sdofs1-08e\is`$\Continuity\Celaya\AD\" "New_Accounts")
    $strFilePath2 = (Join-Path "C:\Users\ac007\TrackIT-Export" "Logs")
	$strFileName = "{0}_{1}_{2}_{3}_{4}{5}.log" -f $(get-date $($user.whenCreated -as [datetime]) -Format "yyyyMMdd-HHmmss"),$($user.samAccountName),$($user.EmployeeID),$user.GivenName.ToLower(),$user.Surname.ToLower(),$(if($PSBoundParameters.ContainsKey('update')){"_update"}else{$null})
    $file = (Join-Path $strFilePath $strFileName)
    $file2 = (Join-Path $strFilePath2 $strFileName)

	$path = [string]::join(',',$($user.DistinguishedName.split(',')[1..$($($user.DistinguishedName.split(',')).count)]))

    if($($mail.EmailAddresses | Where-Object {($_ -cmatch 'smtp*') -and ($_ -inotlike '*.net')}).count -ge 1){
        Write-Verbose "Enumerating filtered email addresses"
        $proxyAddresses = $($mail.EmailAddresses | Where-Object {($_ -cmatch 'smtp*') -and ($_ -inotlike '*.net')}).AddressString }
	else{
		$proxyAddresses = $null }

	$strProxy = @()
	if($proxyAddresses.count -gt 1){
		for($i=1;$i -lt $($proxyAddresses.count + 1);$i++){
			$strProxy += "ProxyAddress$($i)........: $($proxyAddresses[$i - 1])"
		} }
	elseif(($proxyAddresses -eq 0) -or ($proxyAddresses -eq $null)){
		$strProxy = "ProxyAddress.........: $null" }
	else{
		$strProxy = "ProxyAddress.........: $proxyAddresses" }
}#end Begin{}

Process{

	write-verbose $(if($update){"$true"}else{"$false"})
	$fileOut = @"
$(get-date $date -f 'MM-dd-yyyy HH:mm:ss')
$(if($PSBoundParameters.ContainsKey('update')){"Updated"}else{"New"}) Account Information:

SamAccountName.......: $($user.samAccountName)
$(Switch($ShowPass){
        $true{ "Password.............: $Password " }
        Default{""} })

whenCreated..........: $($user.whenCreated)
UserPrincipalName....: $($user.UserPrincipalName)
Name.................: $($user.Name)
GivenName............: $($user.GivenName)
Surname..............: $($user.Surname)
Suffix...............: $($user.generationQualifier)
DisplayName..........: $($user.DisplayName)
SimpleDisplayName....: $($mail.SimpleDisplayName)
EmployeeID...........: $($user.EmployeeID)
ExtensionAttribute1..: $($user.ExtensionAttribute1)
Description..........: $($user.Description)
Title................: $($user.Title)
Department...........: $($user.Department)
Mail.................: $($mail.PrimarySmtpAddress)
$(if($strProxy){$([string]::join("`r`n",$strProxy))}else{"ProxyAddress.........: "})
ActiveSyncEnabled....: $($CASmail.ActiveSyncEnabled)
OWAEnabled...........: $($CASmail.OWAEnabled)
ECPEnabled...........: $($CASmail.ECPEnabled)
PopEnabled...........: $($CASmail.PopEnabled)
ImapEnabled..........: $($CASmail.ImapEnabled)
MAPIEnabled..........: $($CASmail.MAPIEnabled)
OWAMailboxPolicy.....: $($CASmail.OWAMailboxPolicy)
Company..............: $($user.Company)
StreetAddress........: $($user.StreetAddress)
City.................: $($user.City)
State................: $($user.State)
PostalCode...........: $($user.PostalCode)
wWWHomePage..........: $(if($user.wWWHomePage -ne $null){$($($user.wWWHomePage).replace(' ',''))}else{$null})
Path.................: $path

"@

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

}#end Process{}

}

<#

Remove-Module Add-SCCCDAccountLogEntry
Import-Module Add-SCCCDAccountLogEntry

#>

