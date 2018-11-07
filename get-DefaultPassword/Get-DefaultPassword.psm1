Function Get-DefaultPassword{
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
		[Alias('UID','LoginName','sAMAccountName')]
		[string]$User,

		[Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,Position=1)]
		[Alias('EID','ID')]
		[string]$EmployeeID
		
		<#
		,[Parameter(
			Mandatory=$false,
			ValueFromPipelineByPropertyName=$true,
			Position=1)]
		[Alias('ID')]
		[string]$EmployeeID
		#>

	) #end Param()
	
	Begin{
		try{
			$objUser = Get-ADUser $User -Properties EmployeeID -ErrorAction Stop
		}
		Catch{
			Write-Debug "No AD User Found"
			Write-Verbose "No AD User Found"
		}
		if(($objUser.EmployeeID -ne "") -or ($objUser.EmployeeID -ne $null)){
			$EmployeeID = $objUser.EmployeeID
		}
		else{
			$EmployeeID = $null
		}
	} #end Begin{}
	
	Process{
		$password = @{}
		if($EmployeeID){
			if(($User -like "*$($employeeID)") -OR ($User -like "*$($employeeID.substring(0,3))") -OR ($($EmployeeID -eq $null))) {
				Write-Output "$($User)"
				Write-Output "$($EmployeeID)"
				$password.Secure = (ConvertTo-SecureString -AsPlainText "#Welcome559!" -Force)
				$password.Text = "#Welcome559!"
			} #end if()
			else{
				$password.Secure = (ConvertTo-SecureString -AsPlainText "#$($User.subString(0,2).ToUpper())$($employeeID)!" -Force)
				$password.Text = "#$($User.subString(0,2).ToUpper())$($employeeID)!"
			} #end Else{}
		}
		else{
			<#
			$password.Secure = (ConvertTo-SecureString -Force -AsPlainText "#Welcome559!")
			$password.Text = "#Welcome559!"
			#>
			$a = New-RandomPassword -length 8
			$password.Text = $a.Text
			$password.Secure = $a.secure
		}

		return $password
	} #end Process{}
	
	End{} #end End{}
	
} #end Function Get-DefaultPassword{}

<#

Remove-Module get-DefaultPassword
Import-Module get-DefaultPassword

#>

