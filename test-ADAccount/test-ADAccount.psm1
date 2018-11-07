Function test-ADAccount{
	[CmdletBinding()]
	[OutputType([Bool])]
	
	Param(
		[Parameter(Mandatory=$false,
			ValueFromPipelineByPropertyName=$true,
			Position=0)]
		[string]$sAMAccountName,
		
		[Parameter(Mandatory=$false,
			ValueFromPipelineByPropertyName=$true,
			Position=1)]
		[Alias('FirstName')]
		[string]$GivenName,

		[Parameter(Mandatory=$false,
			ValueFromPipelineByPropertyName=$true,
			Position=2)]
		[Alias('Sn','LastName')]
		[string]$Surname,

		[Parameter(Mandatory=$false,
			ValueFromPipelineByPropertyName=$true,
			Position=3)]
		[ValidatePattern('^[\d]{7}$')]
		[Alias('EID')]
		[string]$EmployeeID,

		[Parameter(Mandatory=$false,
			Position=1)]
		[ValidateSet("SCCCD.NET","STUDENTS.SCCCD.NET")]
		[string]$Domain = "SCCCD.NET"
	) #end Param()
	
	Begin{
		#$output = [bool]0
		$objUser = [PSCustomObject] @{
			EmployeeID = if($EmployeeID){"$EmployeeID"}Else{$null}
			Anr = if($GivenName -or $Surname){"$GivenName $Surname"}else{$null}
			GivenName = if($GivenName){"$GivenName"}Else{$null}
			Surname = if($Surname){"$Surname"}Else{$null}
			SamAccountName = if($sAMAccountName){"$sAMAccountName"}else{$null}
		}
	} #end Begin
	
	Process{
		<# Removed: 12/21/2016::ac007::Changed Parameter to include validation
		switch($studentDomain){
			$true{[string]$domain = "STUDENT.SCCCD.EDU"}
			$false{[string]$domain = "SCCCD.NET"}
		} #end switch()
		#>
		
		#region :: testing
		<#
		if($EmployeeID -eq ""){"Equals: $EmployeeID"}
		elseif($EmployeeID -eq $null){ "Equals: $null"}
		else{"Equals: $EmployeeID"}
		#>
		#endregion         

		<#
		switch -regex ($employeeID){
			#$null {$LDAPFilter = "(|(anr=$Givenname $Surname)(sAMAccountName=$SamAccountName))"}
			"^[\d]{7}$" {
				#"Case: include EmployeeID"
				switch (($sAMAccountName -eq $null) -or ($sAMAccountName -like "")){
					$true{
						[string]$LDAPFilter = "(|(anr=$givenname $surname)(EmployeeID=$EmployeeID))"
					}
					Default{
						[string]$LDAPFilter = "(|(anr=$Givenname $Surname)(sAMAccountName=$SamAccountName)(EmployeeID=$EmployeeID))"
					}
				}
			}
			Default {
				#"Case: no EmployeeID (default)"
				Switch (($SamAccountName -eq $null) -or ($sAMAccountName -like "")){
					$true{
						[string]$LDAPFilter = "(anr=$GivenName $Surname)"
					}
					Default{
						[string]$LDAPFilter = "(|(anr=$Givenname $Surname)(sAMAccountName=$SamAccountName))"
					}
			   }
			}
		} #end Switch($EmployeeID)	
		#>	
#region :: old
<#
		[string]$LDAPFilter = "(|"
		if($SamAccountName){$LDAPFilter += "(SamAccountName=$SamAccountName)"}
		if($GivenName){$LDAPFilter += "(GivenName=$GivenName)"}
		if($Surname){$LDAPFilter += "(Surname=$Surname)"}
		if($EmployeeID){$LDAPFilter += "(EmployeeID=$EmployeeID)"
		$LDAPFilter += ")"

		$result = get-aduser -Properties * -LDAPFilter $LDAPFilter -server $Domain
		
		#Write-Verbose "LDAPFilter: $LDAPFilter"
		$result = get-aduser -Properties * -LDAPFilter $LDAPFilter -server $Domain
		
		
		if($result -ne $null){
			[bool]1
		} #end if()
		else{
			[bool]0
		} #end else()
	} #end Process{}


#>
#endregion        


<#
		write-verbose @"
		`n
	EmployeeID:		$EmployeeID
	sAMAccountName:	$sAMAccountName
	Givenname:		$GivenName
	Surname:		$Surname

"@
#>
		$Result = $null
		Write-Verbose $objUser

		while($quit -ne $true){
			
			if($($objUser.SamAccountName)){
				$a = "$($objUser.SamAccountName)"
				$Result = Get-ADUser -Filter {SamAccountName -eq $a} -Verbose
				if($Result.UserPrincipalName){
					$output = [Bool]1
					$quit = [bool]1
					Write-Verbose "SamAccountName...: $($Result.UserPrincipalName)"
					Return $output
				}
			}

			if($($objUser.ANR)){
				$a = "$($objUser.Anr)"
				$Result = Get-ADUser -Filter {Anr -eq $a} -Verbose
				if($($Result.UserPrincipalName)){
					$output = [Bool]1
					$quit = [bool]1
					Write-Verbose "ANR...............: $($Result.UserPrincipalName)"
					Return $output
				}
			}

			if($($objUser.EmployeeID)){
				$a = "$($objUser.EmployeeID)"
				$Result = Get-ADUser -Filter {EmployeeID -eq $a} -Verbose
				if(($Result.UserPrincipalName) -or ($output -eq $false)){
					$output = [Bool]1
					$quit = [bool]1
					Write-Verbose "EmployeeID........: $($Result.UserPrincipalName)"
					Return $output
				}
			}else{
				$output = [Bool]0
				$quit = [bool]1
				Return $output
			}
		}

		Return $output
	
	}#end process{}
	
	End{
		if(gv -ErrorAction SilentlyContinue -Name LDAPFilter){rv -ErrorAction SilentlyContinue -Force -Name LDAPFilter}
		if(gv -ErrorAction SilentlyContinue -Name sAMAccountName){rv -ErrorAction SilentlyContinue -Force -Name sAMAccountName}
		if(gv -ErrorAction SilentlyContinue -Name Givenname){rv -ErrorAction SilentlyContinue -Force -Name Givenname}
		if(gv -ErrorAction SilentlyContinue -Name Surname){rv -ErrorAction SilentlyContinue -Force -Name Surname}
		if(gv -ErrorAction SilentlyContinue -Name EmployeeID){rv -ErrorAction SilentlyContinue -Force -Name EmployeeID}
	} #end End{}
	
} #end Function test-ADAccount{}