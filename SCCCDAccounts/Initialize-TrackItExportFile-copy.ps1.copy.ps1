Function Initialize-TrackItExportFile{
	[CmdletBinding()]
	Param(

	)

	#Track how long the process takes
    $stopWatch = [System.Diagnostics.Stopwatch]::StartNew()

	#Here's the path; if it doesn't exist, create it
    $strTestPath = $(Join-Path $env:USERPROFILE "TrackIt-Export")
	Switch ($strTestPath){
		{Test-Path $_}{
            #path exists; do nothing
        }
		Default{
            #path doesn't exist; create it
			$(Split-Path $_)
			New-Item -Path $(Split-Path $_) -Name "TrackIT-Export" -ItemType Directory
		}
	}

	#Used to title-case, or proper-case, text
    $textInfo = (get-culture).TextInfo

	#copy contents of file; write contents to new file.
    if (Test-Path $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_new.txt")){
		#input file
        $file = Get-ChildItem $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_new.txt")
		#new file
        $newFile = Join-Path $(Split-Path $file -Parent) "TrackIT-Export.csv"
		#write using streamwriter
        try{
			$stream = [System.IO.StreamWriter]::new($newFile)
			$thisContent = [System.IO.File]::ReadAllLines((Resolve-Path $file.FullName))
            $thisContent = $thisContent[0..($thisContent.Length - 2)]
            $thisContent = $thisContent | %{$($_ -split "`t").Trim() -join "`t"}
            $thisContent | ConvertFrom-Csv -Delimiter "`t" | ConvertTo-Csv -NoTypeInformation |
                 ForEach-Object{
				    $stream.WriteLine($_)
			    }
		}finally{
			$stream.Close()
		}
	}

	#get contents of original file.
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
		$Site			= Switch($Summary1.Split("|")[3]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
		$EmployeeType	= Switch($Summary1.Split("|")[4]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
		$Requestor		= $_.Requestor
		$AssignedTech	= $_.'Assigned Technician'
		$DateEntered	= $_.'Date Entered'
		[PSCustomObject]@{
			ID				= $Id
			Status			= $Status
			Summary			= $Summary
			EmployeeName	= $Name
			EmployeeID		= $EmployeeID
			Site			= $Site
			EmployeeType	= $EmployeeType
			Requestor		= $Requestor
			AssignedTech	= $AssignedTech
			DateEntered		= $DateEntered
		}
	}
    
	Write-Verbose $content.count
    $content = $content.Where({$_.EmployeeID -ne $null -and $_.EmployeeID -ne '0000000'})
    
	#$existingAccounts = $($content | ConvertTo-Csv | ConvertFrom-Csv) |
    $existingAccounts = @()
    $existingAccounts += $content | 
        Where-Object{$Global:ADHash.ContainsKey($_.EmployeeID)} |
			ForEach-Object{
				$id				= $_.Id
				$status			= $_.Status
				$summary		= $_.Summary
				$EmployeeName	= $_.EmployeeName
				$EmployeeID		= $_.EmployeeID
				$Site			= $_.Site
				$EmployeeType	= $_.EmployeeType
				$Requestor		= $_.Requestor
				$AssignedTech	= $_.AssignedTech
				$DateEntered	= $_.DateEntered
				$ExistsInAD		= $true
				[PSCustomObject]@{
					ID           = $ID
					Status       = $Status
					Summary      = $Summary
					EmployeeName = $EmployeeName
					EmployeeID   = $EmployeeID
					Site         = $Site
					EmployeeType = $EmployeeType
					Requestor    = $Requestor
					AssignedTech = $AssignedTech
					DateEntered  = $DateEntered
					ExistsInAD   = $ExistsInAD
				}
			}

	#$newAccounts = $($content | ConvertTo-Csv | ConvertFrom-Csv) |
    $newAccounts = @()
    $newAccounts += $content |
		Where-Object{!($Global:ADHash.ContainsKey($_.EmployeeID))} |
			ForEach-Object{
				$id				= $_.Id
				$status			= $_.Status
				$summary		= $_.Summary
				$EmployeeName	= $_.EmployeeName
				$EmployeeID		= $_.EmployeeID
				$Site			= $_.Site
				$EmployeeType	= $_.EmployeeType
				$Requestor		= $_.Requestor
				$AssignedTech	= $_.AssignedTech
				$DateEntered	= $_.DateEntered
				$ExistsInAD		= $false
				[PSCustomObject]@{
					ID           = $ID
					Status       = $Status
					Summary      = $Summary
					EmployeeName = $EmployeeName
					EmployeeID   = $EmployeeID
					Site         = $Site
					EmployeeType = $EmployeeType
					Requestor    = $Requestor
					AssignedTech = $AssignedTech
					DateEntered  = $DateEntered
					ExistsInAD   = $ExistsInAD
				}
			}

    #Update Accounts

    #Create backup file
	$thisFile = $(Join-Path $(Split-Path $newFile) "Update-Me.csv")
	if(!(test-Path $thisFile)){
        New-Item $(Split-Path $newFile) -Name "Update-Me.csv" -ItemType File

    }
    if(Test-Path $thisFile){
		$thisFile = Get-ChildItem $thisFile
		Copy-Item $thisFile.FullName -Destination $(Join-Path $(Split-Path $thisFile) "$(get-date -f 'yyyyMMdd-hhmmss')-Update-Me.csv")
    }

    #Output results, if any
	Switch($($existingAccounts.count)){
		{$_ -gt 0}{
			Try{
				$stream = [System.IO.StreamWriter]::new($thisFile.FullName)
				$existingAccounts | ConvertTo-Csv -NoTypeInformation | ForEach-Object{$stream.WriteLine($_)}
			}finally{
				$stream.Close()
				np++ $thisFile.FullName
			}
		}
        Default{
			Try{
				$stream = [System.IO.StreamWriter]::new($thisFile.FullName)
                $thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeName`",`"EmployeeID`",`"Site`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"DateEntered`",`"ExistsInAD`""
				$stream.WriteLine($thisString)
			}finally{
				$stream.Close()
				np++ $thisFile.FullName
			}
        }
	}

	#New Accounts
    
    #Create backup file
	$thisFile = $(Join-Path $(Split-Path $newFile) "Create-Me.csv")
    if(!(Test-Path $thisFile)){
        New-Item $(Split-Path $newFile) -ItemType File -Name "Create-Me.csv"
    }
	if (Test-Path $thisFile) {
		$thisFile = Get-ChildItem $thisFile
		Copy-Item $thisFile.FullName -Destination $(Join-Path $(Split-Path $thisFile) "$(get-date -f 'yyyyMMdd-hhmmss')-Create-Me.csv")
    }

    #Output Results, if any
    Switch ($($newAccounts.count)) {
		{$_ -gt 0} {
			Try {
				$stream = [System.IO.StreamWriter]::new($thisFile.FullName)
				$newAccounts | ConvertTo-Csv -NoTypeInformation | ForEach-Object {$stream.WriteLine($_)}
			} finally {
				$stream.Close()
				np++ $thisFile.FullName
			}
		}
        Default{
            Try{
                $stream = [System.IO.StreamWriter]::new($thisFile.FullName)
                $thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeName`",`"EmployeeID`",`"Site`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"DateEntered`",`"ExistsInAD`""
                $stream.WriteLine($thisString)
            }
            Finally{
                $stream.Close()
            }
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

}#</Initialize-TrackItExportFile>


#Initialize-TrackItExportFile
