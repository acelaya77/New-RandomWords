Function Get-NextSamAccountName {
	[CmdletBinding(DefaultParameterSetName="Normal")]
	[OutputType([string])]
	Param(
		[Parameter(Mandatory= $true, ParameterSetName="Normal")]
		[Parameter(ParameterSetName="Student")]
		[ValidatePattern("^[\w]{2}$")]
		[string]$Initials,

		[Parameter(Mandatory=$false, ParameterSetName="Normal")]
		[Parameter(ParameterSetName="Student")]
		[string[]]$Exclude,

		[Parameter(Mandatory=$false, ParameterSetName="Student")]
		[switch]$Student,

		[Parameter(Mandatory=$false, ParameterSetName="Student")]
		[string]$EmployeeID
	)#</Param()>

	Begin{
		$counter = 001
		if(![string]::IsNullOrWhiteSpace($initials)){
			$testLogin = $initials + $($counter.ToString('000'))
		} #</if()>
		$testMe = "$testLogin"
	} #</Begin{}>

	Process{
		Switch($student){
			$true{
				$results = $initials.ToLower() + $EmployeeID
			}#</True{}>
			$false{
				do{
					$j = $null
					$testMe = "$($initials + $counter.ToString('000'))"

					if($testMe -in $exclude){
						write-verbose "Excluded: $testMe"
						$counter++
						$j = $testMe
						continue
					} #</if()>

					if($($(get-aduser -filter {sAMAccountName -eq $testMe} -ErrorAction SilentlyContinue).sAMAccountName)){
						$j = $($(get-aduser -filter {sAMAccountName -eq $testMe} -ErrorAction SilentlyContinue).sAMAccountName)
					} #</if()>

                    Switch($(get-aduser -Filter {sAMAccountName -eq $testMe} -ErrorAction SilentlyContinue).sAMAccountName){
                        {$_ -eq ""}{
                            #$true
                            #$j
                        }
                        Default{
                            #$false
                            $j = $_
                            #Write-Host -ForegroundColor DarkCyan $j
                        }
                    }#</switch{}>


					if($j -eq $null){
						break
					} #</if()>
					else{

					} #</else()>
					$counter++
				} #</do{}>
				while($j -ne $null) #</while()>

				$results = "$($initials.ToLower() + $counter.ToString('000'))"
			}#</$false{}>
		}#</switch($student){}>
		Return $results
	}#</Process{}>

	End{}#</End{}>
} #</Get-NextSamAccountName{}>