Function Initialize-TrackItSeparations{
	[CmdletBinding()]
	Param(

	)

	$stopWatch = [System.Diagnostics.Stopwatch]::StartNew()

	$strTestPath = $(Join-Path $env:USERPROFILE "TrackIt-Export")
	Switch ($strTestPath){
		{Test-Path $_}{}
		Default{
			$(Split-Path $_)
			New-Item -Path $(Split-Path $_) -Name "TrackIT-Export" -ItemType Directory
		}
	}

	$textInfo = (get-culture).TextInfo

	if (Test-Path $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_separations.txt")){
		$file = Get-ChildItem $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_separations.txt")
		$newFile = Join-Path $(Split-Path $file) "TrackIT-Separations.csv"
		try{
			$stream = [System.IO.StreamWriter]::new($newFile)
			$thisContent = [System.IO.File]::ReadAllLines((Resolve-Path $file.FullName))
            $thisContent | ConvertTo-Csv -NoTypeInformation |
                 ForEach-Object{
				    $stream.WriteLine($_.Trim())
			    }
		}finally{
			$stream.Close()
		}
	}

	$content = Get-content $file.FullName
	$content = $content[0..($content.Length - 2)]

	$content = $content | ForEach-Object{
		$($($_ -split "`t").Trim() | ForEach-Object{
			"`"$_`""
		}) -join ","
	}
    
    $content = $content | ConvertFrom-Csv | ConvertTo-Csv -NoTypeInformation -Delimiter ","

	#$content = $content | Where-Object {$_.EmployeeID -notlike '0000000' -and $_.EmployeeID -ne "" -and $_.EmployeeID -ne $null} | ConvertFrom-Csv -Delimiter "," | ForEach-Object{
    $content = $content | ConvertFrom-Csv -Delimiter "," | ForEach-Object{
		$Id				= $_.Id.Trim()
		$Status			= $_.Status.Trim()
		$Summary1		= $_.Summary.Trim()
		$Summary		= $($Summary1.split("|")[0]).Trim()
		$Name			= Switch($Summary1.Split("|")[1]){{$_ -ne $null}{$_.Trim()};Default{$null}}
		$Name			= $textInfo.ToTitleCase($($Name).ToLower())
		$EmployeeID		= Switch($Summary1.Split("|")[2]){{$_ -ne $null}{$_.Trim()};Default{$null}}
		$SeparationDate	= Switch($Summary1.Split("|")[3]){{$_ -ne $null}{$_.Trim()};Default{$null}}
		$Requestor		= $_.Requestor
		$DateEntered	= $_.'Due Date'
		[PSCustomObject]@{
			ID				= $Id
			Status			= $Status
			Summary			= $Summary
			EmployeeName	= $Name
			EmployeeID		= $EmployeeID
			SeparationDate  = $SeparationDate
			Requestor		= $Requestor
			DueDate 		= $DateEntered
		}
	}
    

	Try{
		$stream = [System.IO.StreamWriter]::new($newFile)
		$content | ConvertTo-Csv -NoTypeInformation | ForEach-Object{$stream.WriteLine($_)}
	}finally{
		$stream.Close()
		np++ $newFile.FullName
	}

	$stopWatch.Stop()

#ii $newFile

}#</Initialize-TrackItExportFile>


#Initialize-TrackItExportFile
