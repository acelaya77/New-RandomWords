Function Initialize-NewAccounts{
	[CmdletBinding()]
	Param(

	)

	$stopWatch = [System.Diagnostics.Stopwatch]::StartNew()

	$strTestPath = $(Join-Path $env:USERPROFILE "TrackIt-Export")
	Switch ($strTestPath) {
		{Test-Path $_} {}
		Default {
			$(Split-Path $_)
			New-Item -Path $(Split-Path $_) -Name "TrackIT-Export" -ItemType Directory
		}
	}

	#$textInfo = (get-culture).TextInfo

	if (Test-Path $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "newMailboxes.csv")) {
		$file = Get-Item $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "newMailboxes.csv")
		$newFile = Join-Path $(Split-Path $file) "newMailboxes-$(get-date -f 'yyyyMMdd_hhmmss').csv"
		try {
			$stream = [System.IO.StreamWriter]::new($newFile)
			$thisContent = [System.IO.File]::ReadAllLines((Resolve-Path $file.FullName))
			$thisContent | ConvertTo-Csv -NoTypeInformation |
				ForEach-Object {
				$stream.WriteLine($_)
			}
		} finally {
			$stream.Close()
		}
	}
	else{
		New-Item -ItemType File -Path $(Join-Path $env:USERPROFILE "TrackIt-Export") -Name "newMailboxes.csv"
	}

	$createMeFile = $(Resolve-Path "$(Join-Path $env:USERPROFILE "TrackIt-Export")\Create-Me.csv")
	$newMailboxesFile = $(Resolve-Path "$(Join-Path $env:USERPROFILE "TrackIt-Export")\newMailboxes.csv")
	$createMeImport = Import-Csv $createMeFile

	#$createMeImport | Format-Table -AutoSize

	$sqlBuffer = Get-SQLWebAdvisorID -EmployeeIDs $($($createMeImport.EmployeeID | ForEach-Object{"`'$_`'"}) -join ",")
    $sqlResults = @()
	$sqlResults +=  $sqlBuffer | Where-Object {$_.ExtensionAttribute1 -notlike ""}

	$stream = [System.IO.StreamWriter]::new($newMailboxesFile)

    Switch($sqlResults.Count){
        {$_ -gt 0}{
            $thisOutput = $sqlResults | ConvertTo-Csv -Delimiter "," -NoTypeInformation | Out-String
        }
        Default{
            $thisOutput = "`"GIVENNAME`",`"MIDDLENAME`",`"SURNAME`",`"SUFFIX`",`"PREFERREDNAME`",`"EMPLOYEEID`",`"EXTENSIONATTRIBUTE1`",`"SITE`",`"DEPARTMENT`",`"TITLE`",`"EMPLOYEETYPE`",`"SAMACCOUNTNAME`""
        }
    }

	try{
		#$sqlResults | ConvertTo-Csv -Delimiter "," -NoTypeInformation | Out-String | ForEach-Object{
        $thisOutput | ForEach-Object{
			$stream.WriteLine($_)
		}
	}
	finally{
		$stream.Close()
	}

	<#
	np++ $createMeFile
	np++ $newMailboxesFile
	#>

	#$content = Get-content $file.FullName
	#$content | Format-Table -AutoSize

	$stopWatch.Stop()
}
