Function Update-MyUser {
[cmdletbinding(SupportsShouldProcess)]
	Param(
	[Parameter(Position = 0, Mandatory, HelpMessage = "Enter a user name")]
	[ValidateNotNullorEmpty()]
	[Microsoft.ActiveDirectory.Management.ADUser]$Identity,
	[Parameter(Position = 1, Mandatory, HelpMessage = "Enter a hashtable of parameter values for Set-ADUser")]
	[ValidateNotNullorEmpty()]
	[hashtable]$Settings
	)
 
	Write-Verbose "Updating $Identity"
 
	Write-Verbose ($Settings | Out-String)
	Try {
		$user = Get-ADuser $Identity -ErrorAction stop
		Write-Verbose $user.distinguishedname
	}
	Catch {
		Throw $_
	}

	$user | Set-ADUser @Settings
    
}