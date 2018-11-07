Function Convert-UserAccountControl{
	[CmdletBinding()]
	Param(
		[Parameter(ValueFromPipelineByPropertyName=$True)]
		#[Alias('userAccountControl')]
		$userAccountControl
        ,[Parameter(ValueFromPipelineByPropertyName=$true)]
        [Switch]$csvOutput
	) # Param()

	#region :: Switch for converting userAccountControl to readable values in text
	$flags = @()
    switch ($userAccountControl){ 
		{($userAccountControl -bor 0x0001    ) -eq $userAccountControl}{$flags += "SCRIPT"}
		{($userAccountControl -bor 0x0002    ) -eq $userAccountControl}{$flags += "ACCOUNTDISABLE"}
		{($userAccountControl -bor 0x0008    ) -eq $userAccountControl}{$flags += "HOMEDIR_REQUIRED"}
		{($userAccountControl -bor 0x0010    ) -eq $userAccountControl}{$flags += "LOCKOUT"}
		{($userAccountControl -bor 0x0020    ) -eq $userAccountControl}{$flags += "PASSWD_NOTREQD"}
		{($userAccountControl -bor 0x0040    ) -eq $userAccountControl}{$flags += "PASSWD_CANT_CHANGE"}
		{($userAccountControl -bor 0x0080    ) -eq $userAccountControl}{$flags += "ENCRYPTED_TEXT_PWD_ALLOWED"}
		{($userAccountControl -bor 0x0100    ) -eq $userAccountControl}{$flags += "TEMP_DUPLICATE_ACCOUNT"}
		{($userAccountControl -bor 0x0200    ) -eq $userAccountControl}{$flags += "NORMAL_ACCOUNT"}
		{($userAccountControl -bor 0x0220    ) -eq $userAccountControl}{$flags += "MUST_CHANGE_PASSWORD"}
		{($userAccountControl -bor 0x0800    ) -eq $userAccountControl}{$flags += "INTERDOMAIN_TRUST_ACCOUNT"}
		{($userAccountControl -bor 0x1000    ) -eq $userAccountControl}{$flags += "WORKSTATION_TRUST_ACCOUNT"}
		{($userAccountControl -bor 0x2000    ) -eq $userAccountControl}{$flags += "SERVER_TRUST_ACCOUNT"}
		{($userAccountControl -bor 0x10000   ) -eq $userAccountControl}{$flags += "DONT_EXPIRE_PASSWORD"}
		{($userAccountControl -bor 0x20000   ) -eq $userAccountControl}{$flags += "MNS_LOGON_ACCOUNT"}
		{($userAccountControl -bor 0x40000   ) -eq $userAccountControl}{$flags += "SMARTCARD_REQUIRED"}
		{($userAccountControl -bor 0x80000   ) -eq $userAccountControl}{$flags += "TRUSTED_FOR_DELEGATION"}
		{($userAccountControl -bor 0x100000  ) -eq $userAccountControl}{$flags += "NOT_DELEGATED"}
		{($userAccountControl -bor 0x200000  ) -eq $userAccountControl}{$flags += "USE_DES_KEY_ONLY"}
		{($userAccountControl -bor 0x400000  ) -eq $userAccountControl}{$flags += "DONT_REQ_PREAUTH"}
		{($userAccountControl -bor 0x800000  ) -eq $userAccountControl}{$flags += "PASSWORD_EXPIRED"}
		{($userAccountControl -bor 0x1000000 ) -eq $userAccountControl}{$flags += "TRUSTED_TO_AUTH_FOR_DELEGATION"}
		{($userAccountControl -bor 0x04000000) -eq $userAccountControl}{$flags += "PARTIAL_SECRETS_ACCOUNT"}
	} #switch()
	#endregion :: Switch for converting userAccountControl to readable values in text
	
	#format as CSV
	Switch($csvOutput){
        $true{
            $flags = $($flags -join ",")
        }
        Default{
        }
    }
	
	Return $flags
} # Function Convert-UserAccountControl{}

<#
Try{Remove-Module Convert-UserAccountControl -ErrorAction SilentlyContinue}
Finally{Import-Module Convert-UserAccountControl}
#>