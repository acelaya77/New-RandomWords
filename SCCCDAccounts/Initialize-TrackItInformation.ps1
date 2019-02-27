

#region :: Header
<#

NAME        : Initialize-TrackItInformation.ps1 
AUTHOR      : Anthony J. Celaya
DESCRIPTION : 
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 
UPDATED     : 01-07-2019
VERSION     : 1.1



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE
1.1 01-07-2019 ac007  Update to include switch to filter results to 'Open' requests only.

#>

#endregion

#Function Initialize-TrackItExportFile{
Function Initialize-TrackItInformation{
    [CmdletBinding()]
    Param(
        [Switch]$Filter
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

    if (Test-Path $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_new.txt")){
        $file = Get-ChildItem $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_new.txt")
        $newFile = Join-Path $(Split-Path $file) "TrackIT-Export.csv"
        $thisContent = [System.IO.File]::ReadAllLines((Resolve-Path $file.FullName))
        $thisContent = $thisContent[0..$($thisContent.count - 2)]
        [string]$header = $thisContent[0]

        try{
            $stream = [System.IO.StreamWriter]::new($newFile)

            [string[]]$tempContent = @()
            Switch($Filter){
                $true{
                    $tempContent = $header
                    $tempContent += $($thisContent | Where-Object{$_ -match "Open"}) | Out-String
                    $thisContent = $tempContent
                }
            }            

            $thisContent |
                 ForEach-Object{
                    $stream.WriteLine($_)
                }
        }finally{
            $stream.Close()
        }
    }

    #$content = Get-content $file.FullName
    $content = Get-content $newFile
    #$content = $content[0..($content.Length - 2)]

    $content = $content | ForEach-Object{
        $($($_ -split "`t").Trim() | ForEach-Object{
            "`"$_`""
        }) -join ","
    }

    $content = $content | ConvertFrom-Csv | ConvertTo-Csv -NoTypeInformation -Delimiter ","
    
    #$content = $content | Where-Object {$_.EmployeeID -notlike '0000000' -and $_.EmployeeID -ne "" -and $_.EmployeeID -ne $null} | ConvertFrom-Csv -Delimiter "," | ForEach-Object{
    #$content | ConvertFrom-Csv -Delimiter "," | ft -a

    $content = $content | ConvertFrom-Csv -Delimiter "," | ForEach-Object{
        $Id				= $_.Id.Trim()
        $Status			= $_.Status.Trim()
        $Summary1		= $_.Summary.Trim()
        $Summary		= $($Summary1.split("|")[0]).Trim()
        #$Name			= Switch($Summary1.Split("|")[1]){{$_ -ne $null}{$_.Trim()};Default{$null}}
        #$Name			= $textInfo.ToTitleCase($($Name).ToLower())
        #$EmployeeID		= Switch($Summary1.Split("|")[2]){{$_ -ne $null}{$_.Trim()};Default{$null}}
        $EmployeeID		= Switch($Summary1.Split("|")[1]){{$_ -ne $null}{$_.Trim()};Default{$null}}
        $Site			= Switch($Summary1.Split("|")[2]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $Department 	= Switch($Summary1.Split("|")[3]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $Title      	= Switch($Summary1.Split("|")[4]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $EmployeeType	= Switch($Summary1.Split("|")[5]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $Requestor		= $_.Requestor
        $AssignedTech	= $_.'Assigned Technician'
        #$DateEntered	= $_.'Date Entered'
        Switch($EmployeeType){
            {$_ -like 'Certificated'}{$EmployeeType = 'Faculty'}
            Default{}
        }
        [PSCustomObject]@{
            ID				= $Id
            Status			= $Status
            Summary			= $Summary
            #EmployeeName	= $Name
            EmployeeID		= $EmployeeID
            Site			= $Site
            Department      = $Department
            Title           = $Title
            EmployeeType	= $EmployeeType
            Requestor		= $Requestor
            AssignedTech	= $AssignedTech
            #DateEntered		= $DateEntered
        }
    }
    #$content | ft -AutoSize

    if($content.count -gt 0){
        Write-Verbose $content.count

        #$content = $content.Where({($null -ne $_.EmployeeID) -and ($_.EmployeeID -ne '0000000')})
        $content = $content.Where({!([string]::IsNullOrEmpty($_.EmployeeID)) -and ($_.EmployeeID -ne '0000000')})
        $content = $content | Sort-Object EmployeeID -Unique
    }

    #$existingAccounts = $($content | ConvertTo-Csv | ConvertFrom-Csv) |
    $existingAccounts = @()
    $ADHash = Import-Clixml (Join-Path "C:\Users\ac007" "ADHash.xml")
    $existingAccounts += $content |
        #Where-Object{$Global:ADHash.ContainsKey($_.EmployeeID)} |
        Where-Object{$ADHash.ContainsKey($_.EmployeeID)} |
            ForEach-Object{
                $id				= $_.Id
                $status			= $_.Status
                $summary		= $_.Summary
                #$EmployeeName	= $_.EmployeeName
                $EmployeeID		= $_.EmployeeID
                $Site			= $_.Site
                $Department     = $_.Department
                $Title          = $_.Title
                $EmployeeType	= $_.EmployeeType
                $Requestor		= $_.Requestor
                $AssignedTech	= $_.AssignedTech
                #$DateEntered	= $_.DateEntered
                $ExistsInAD		= $true
                [PSCustomObject]@{
                    ID           = $ID
                    Status       = $Status
                    Summary      = $Summary
                    #EmployeeName = $EmployeeName
                    EmployeeID   = $EmployeeID
                    Site         = $Site
                    Department   = $Department
                    #Title        = $Title
                    EmployeeType = $EmployeeType
                    Requestor    = $Requestor
                    AssignedTech = $AssignedTech
                    #DateEntered  = $DateEntered
                    ExistsInAD   = $ExistsInAD
                }
            }

    #$newAccounts = $($content | ConvertTo-Csv | ConvertFrom-Csv) |
    $newAccounts = @()
    $newAccounts += $content |
        #Where-Object{!($Global:ADHash.ContainsKey($_.EmployeeID))} |
        Where-Object{!($ADHash.ContainsKey($_.EmployeeID))} |
            ForEach-Object{
                $id				= $_.Id
                $status			= $_.Status
                $summary		= $_.Summary
                #$EmployeeName	= $_.EmployeeName
                $EmployeeID		= $_.EmployeeID
                $Site			= $_.Site
                $Department     = $_.Department
                $Title          = $_.Title
                $EmployeeType	= $_.EmployeeType
                $Requestor		= $_.Requestor
                $AssignedTech	= $_.AssignedTech
                #$DateEntered	= $_.DateEntered
                $ExistsInAD		= $false
                [PSCustomObject]@{
                    ID           = $ID
                    Status       = $Status
                    Summary      = $Summary
                    #EmployeeName = $EmployeeName
                    EmployeeID   = $EmployeeID
                    Site         = $Site
                    Department   = $Department
                    Title        = $Title
                    EmployeeType = $EmployeeType
                    Requestor    = $Requestor
                    AssignedTech = $AssignedTech
                    #DateEntered  = $DateEntered
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
                #np++ $thisFile.FullName
                Write-Output $thisFile.FullName
            }
        }
        Default{
            Try{
                $stream = [System.IO.StreamWriter]::new($thisFile.FullName)
                #$thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeName`",`"EmployeeID`",`"Site`",`"Department`",`"Title`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"DateEntered`",`"ExistsInAD`""
                $thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeID`",`"Site`",`"Department`",`"Title`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"ExistsInAD`""
                $stream.WriteLine($thisString)
            }finally{
                $stream.Close()
                #np++ $thisFile.FullName
                Write-Output $thisFile.FullName
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
                #np++ $thisFile.FullName
                Write-Output $thisFile.FullName
            }
        }
        Default{
            Try{
                $stream = [System.IO.StreamWriter]::new($thisFile.FullName)
                #$thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeName`",`"EmployeeID`",`"Site`",`"Department`",`"Title`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"DateEntered`",`"ExistsInAD`""
                $thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeID`",`"Site`",`"Department`",`"Title`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"ExistsInAD`""
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
        #np++ $newFile.FullName
        Write-Output $newFile.FullName
    }

    $stopWatch.Stop()

}


