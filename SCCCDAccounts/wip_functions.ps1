#2018-10-24


Function Test-ExtensionAttribute1{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][string]$EmployeeID
    )
    $sqlResults = Get-SQLWebAdvisorID -EmployeeIDs $EmployeeID
    if($null -eq $sqlResults.ExtensionAttribute1){
        $false
    }
    else{
        $true
    }
}

Function Test-ADAccountExist{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][String]$EmployeeID
    )
    $sqlResults = Get-SQLWebAdvisorID -EmployeeIDs $EmployeeID

    <#
    if($Global:ADHash.ContainsKey($EmployeeID)){
        $true
    }
    #>
    $ADHash = Import-Clixml (Join-Path "c:\Users\ac007" "ADHash.xml")
    if($ADHash.ContainsKey($EmployeeID)){
        $true
    }
    elseif($null -ne $sqlResults.EmployeeID){
        Try{
            $a = Get-ADUser -Filter {Anr -eq $strName} -ErrorAction Stop
            if(($a.EmployeeID -eq $EmployeeID)){
                $true
            }
            elseif(($null -eq $a.EmployeeID) -and ($a.Givenname -eq $sqlResults.GIVENNAME) -and ($a.Surname -eq $sqlResults.SURNAME)){
                $true
            }
            else{
                $false
            }
        }
        Catch{
            $false
        }
    }
    else{
        $false
    }
}

Function Test-EmailAddressAvailable{
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    Param(
        [Parameter(Mandatory=$true)][string]$EmailAddress
    )
    Connect-Exchange
    #$sqlResults = Get-SQLWebAdvisorID -EmployeeIDs $EmployeeID
    <#
    $name = $("{0} {1}" -f $sqlResults.Givenname,$sqlResults.Surname)
    $smtp = $("{0}.{1}" -f $sqlResults.Givenname.Tolower().Replace(' ','-'),$sqlResults.Surname.ToLower().Replace(' ','-'))
    $givenname = $("{0}" -f $sqlResults.Givenname,$sqlResults.Surname)
    $surname = $("{1}" -f $sqlResults.Givenname,$sqlResults.Surname)
    #>
    <#
    Try{
        #$mailBox = Get-Mailbox -Filter {(EmailAddresses -like "smtp:$($smtp)*")} -ErrorAction Stop -DomainController SDODC1-08e
    }
    Catch{
        $true
    }
    #>
    $mailBox = Get-Mailbox "$($EmailAddress)" -DomainController $DomainController -ErrorAction SilentlyContinue
    if($null -ne $mailBox.PrimarySMTPAddress){
        [bool]$Available = $false
    }
    elseif($mailBox.PrimarySMTPAddress -like ""){
        [bool]$Available = $true
    }
    elseif($mailBox.EmailAddresses -like "$($EmailAddress)*"){
        [bool]$Available = $false
    }
    else{
        [bool]$Available = $true
    }
    Return $Available
}

Function Get-TrackItInfo{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][String]$EmployeeID
    )

    $inputFile = get-item (Join-Path "$(([environment]::GetFolderPath("UserProfile")))\TrackIt-Export" "TrackIT-Export.csv")
    $thisImported = Import-Csv $inputFile
    <#
    $a.GIVENNAME = $importedCSV[[Array]::FindIndex( $importedCSV, [System.Predicate[PSCustomObject]]{ $args[0].EmployeeID -eq $_.EMPLOYEEID })].GIVENNAME
    #>
    $indexNumber = [Array]::FindIndex($thisImported,[System.Predicate[PSCustomObject]]{$args[0].EmployeeID -eq $EmployeeID})
    if($indexNumber -ne -1){
        $thisItem = $thisImported[$indexNumber]
    }
    else{
        $thisItem = $Null
    }
    Return $thisItem
}

<#
Function Get-PreferredAccountAttributes{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$true)][Hash]$sqlInfo
        ,[Parameter(Mandatory=$true)][Hash]$TrackItInfo
    )
}
#>

Function Test-NewAdAccount{
    [flags()]
    Enum AttrBitFlags{
        Enabled           = 1
        Name              = 2
        EmployeeID        = 4
        Givenname         = 8
        Country           = 16
        State             = 32
        OtherAttributes   = 64
        HomePage          = 128
        PostalCode        = 256
        StreetAddress     = 512
        AccountPassword   = 1024
        Company           = 2048
        Whatif            = 4096
        Description       = 8192
        Surname           = 16384
        DisplayName       = 32768
        Path              = 65536
        Title             = 131072
        sAMAccountName    = 262144
        Department        = 524288
        City              = 1048576
        UserPrincipalName = 2097152
    }
    #[AttrBitFlags]$flags = $null
    $flags = [AttrBitFlags]::new()
    foreach($arg in $args){
        foreach($item in $arg.GetEnumerator()){
            #$item.Key
            #[AttributeBitFlags]::$($item.key)
            Switch($item){
                {$null -eq $($_.Value)}{
                    #Write-Output $("`$null {0}" -f $($_.Key))
                }
                {$($_.Value) -notlike "*"}{
                    #Write-Output $("`"*`" {0}" -f $($_.Key))
                }
                Default{
                    #Write-Output $("Adding flag for: {0}" -f $_.Key)
                    if($flags -eq 0){
                        #Write-Output $("Overwriting `$flags: {0}" -f $_.Key)
                        $flags = [AttrBitFlags]::$($_.Key)
                    }
                    else{
                        $flags += [AttrBitFlags]::$($_.Key)
                    }
                }
            }
        }
    }
    #Return $flags.value__
    $missingFlags = @()
    Switch($flags){
        {($flags -bor       1) -ne $flags}{$missingFlags += "Enabled"          }
        {($flags -bor       2) -ne $flags}{$missingFlags += "Name"             }
        {($flags -bor       4) -ne $flags}{$missingFlags += "EmployeeID"       }
        {($flags -bor       8) -ne $flags}{$missingFlags += "Givenname"        }
        {($flags -bor      16) -ne $flags}{$missingFlags += "Country"          }
        {($flags -bor      32) -ne $flags}{$missingFlags += "State"            }
        {($flags -bor      64) -ne $flags}{$missingFlags += "OtherAttributes"  }
        {($flags -bor     128) -ne $flags}{$missingFlags += "HomePage"         }
        {($flags -bor     256) -ne $flags}{$missingFlags += "PostalCode"       }
        {($flags -bor     512) -ne $flags}{$missingFlags += "StreetAddress"    }
        {($flags -bor    1024) -ne $flags}{$missingFlags += "AccountPassword"  }
        {($flags -bor    2048) -ne $flags}{$missingFlags += "Company"          }
        {($flags -bor    4096) -ne $flags}{$missingFlags += "Whatif"           }
        {($flags -bor    8192) -ne $flags}{$missingFlags += "Description"      }
        {($flags -bor   16384) -ne $flags}{$missingFlags += "Surname"          }
        {($flags -bor   32768) -ne $flags}{$missingFlags += "DisplayName"      }
        {($flags -bor   65536) -ne $flags}{$missingFlags += "Path"             }
        {($flags -bor  131072) -ne $flags}{$missingFlags += "Title"            }
        {($flags -bor  262144) -ne $flags}{$missingFlags += "sAMAccountName"   }
        {($flags -bor  524288) -ne $flags}{$missingFlags += "Department"       }
        {($flags -bor 1048576) -ne $flags}{$missingFlags += "City"             }
        {($flags -bor 2097152) -ne $flags}{$missingFlags += "UserPrincipalName"}
    }
    if($missingFlags.count -gt 0){
        Return $missingFlags
    }elseif($missingFlags.count -eq 0){
        $missingFlags = "None"
        Return $missingFlags
    }
}

Function Get-ExchangeDatabase {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("FCC", "FC", "CCC", "CC", "RC", "MC", "DO", "CTC", "OC", "HC")]
        [string]$Site,

        [Parameter(Mandatory = $true)]
        [ValidateSet(
            "Adjunct"
            , "Faculty"
            , "Classified"
            , "Management"
            , "Student"
            , "Provisional")]
        [string]$EmployeeType
    )

    Switch -Wildcard ($Site) {
        "DO" {$ExchangeDB = "DB_DO"}
        "DN" {$ExchangeDB = "DB_DO"}
        "HC" {$ExchangeDB = "DB_DO"}
        "RC" {$ExchangeDB = "DB_RC"}
        "CC*" {$ExchangeDB = "DB_CC"}
        "MC" {$ExchangeDB = "DB_MC"}
        "OC" {$ExchangeDB = "DB_RC"}
        "CTC" {
            Switch -Wildcard ($EmployeeType) {
                "Adjunct" {$ExchangeDB = "DB_FC_ADJ"}
                "Faculty" {$ExchangeDB = "DB_FC_FAC"}
                "Classified" {$ExchangeDB = "DB_FC_STAFF"}
                "Management" {$ExchangeDB = "DB_FC_STAFF"}
                "Student" {$ExchangeDB = "DB_FC_STAFF"}
                "Provisional" {$ExchangeDB = "DB_FC_STAFF"}
                Default {$ExchangeDB = "DB_FC_STAFF"}
            }#end Switch{}
        }#end CTC
        "FC*" {
            Switch -Wildcard ($EmployeeType) {
                "Adjunct" {$ExchangeDB = "DB_FC_ADJ"}
                "Faculty" {$ExchangeDB = "DB_FC_FAC"}
                "Classified" {$ExchangeDB = "DB_FC_STAFF"}
                "Management" {$ExchangeDB = "DB_FC_STAFF"}
                "Student" {$ExchangeDB = "DB_FC_STAFF"}
                "Provisional" {$ExchangeDB = "DB_FC_STAFF"}
                Default {$ExchangeDB = "DB_FC_STAFF"}
            }#end Switch{}
        }#end FC
        Default {$ExchangeDB = "DB_DO"}
    }#end Switch{}

    Return $ExchangeDB

}#</Get-ExchangeDatabase{}>

Function Initialize-TrackItExportFile{
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

    if (Test-Path $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_new.txt")){
        $file = Get-ChildItem $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "export_new.txt")
        $newFile = Join-Path $(Split-Path $file) "TrackIT-Export.csv"
        try{
            $stream = [System.IO.StreamWriter]::new($newFile)
            $thisContent = [System.IO.File]::ReadAllLines((Resolve-Path $file.FullName))
            $thisContent | ConvertTo-Csv -NoTypeInformation |
                 ForEach-Object{
                    $stream.WriteLine($_)
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
        $Site			= Switch($Summary1.Split("|")[3]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $Department 	= Switch($Summary1.Split("|")[4]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $Title      	= Switch($Summary1.Split("|")[5]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $EmployeeType	= Switch($Summary1.Split("|")[6]) {{$_ -ne $null} {$_.Trim()}; Default {$null}}
        $Requestor		= $_.Requestor
        $AssignedTech	= $_.'Assigned Technician'
        $DateEntered	= $_.'Date Entered'
        Switch($EmployeeType){
            {$_ -like 'Certificated'}{$EmployeeType = 'Faculty'}
            Default{}
        }
        [PSCustomObject]@{
            ID				= $Id
            Status			= $Status
            Summary			= $Summary
            EmployeeName	= $Name
            EmployeeID		= $EmployeeID
            Site			= $Site
            Department      = $Department
            Title           = $Title
            EmployeeType	= $EmployeeType
            Requestor		= $Requestor
            AssignedTech	= $AssignedTech
            DateEntered		= $DateEntered
        }
    }

    Write-Verbose $content.count
    $content = $content.Where({($null -ne $_.EmployeeID) -and ($_.EmployeeID -ne '0000000')})

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
                $EmployeeName	= $_.EmployeeName
                $EmployeeID		= $_.EmployeeID
                $Site			= $_.Site
                $Department     = $_.Department
                $Title          = $_.Title
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
                    Department   = $Department
                    Title        = $Title
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
        #Where-Object{!($Global:ADHash.ContainsKey($_.EmployeeID))} |
        Where-Object{!($ADHash.ContainsKey($_.EmployeeID))} |
            ForEach-Object{
                $id				= $_.Id
                $status			= $_.Status
                $summary		= $_.Summary
                $EmployeeName	= $_.EmployeeName
                $EmployeeID		= $_.EmployeeID
                $Site			= $_.Site
                $Department     = $_.Department
                $Title          = $_.Title
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
                    Department   = $Department
                    Title        = $Title
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
                #np++ $thisFile.FullName
                Write-Output $thisFile.FullName
            }
        }
        Default{
            Try{
                $stream = [System.IO.StreamWriter]::new($thisFile.FullName)
                $thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeName`",`"EmployeeID`",`"Site`",`"Department`",`"Title`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"DateEntered`",`"ExistsInAD`""
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
                $thisString = "`"ID`",`"Status`",`"Summary`",`"EmployeeName`",`"EmployeeID`",`"Site`",`"Department`",`"Title`",`"EmployeeType`",`"Requestor`",`"AssignedTech`",`"DateEntered`",`"ExistsInAD`""
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

}#</Initialize-TrackItExportFile>

Function New-SCCCDAccount{
    [CmdletBinding(SupportsShouldProcess)]
    Param(
         [Parameter(Mandatory=$true,ParameterSetName='Default')][string]$EmployeeID
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')][switch]$HasEmail = $false
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')][switch]$IsStudent = $false
        ,[Parameter(Mandatory=$false,ParameterSetName='Initialize')][switch]$Initialize = $false
        ,[Parameter(Mandatory=$false,ParameterSetName='Default')][switch]$DebugMe = $false
    )

    Try{
        Remove-Variable -Name secondarySMTP `
                ,primarySMTP `
                ,sqlResults `
                ,accountSplat `
                ,missingAttributes `
                ,newAccount `
                ,AccountSuccess `
                ,thisOutput `
                ,password `
                ,primarySMTPAddress `
                ,newMailbox `
                ,DomainController `
                ,date `
                ,accountexists `
                ,trackItInfo `
                ,strSamAccountName `
                ,strSite -ErrorAction SilentlyContinue
    }
    Catch{
        Write-Verbose "Error removing variables"
    }
    Switch($Initialize){
        $true{
            Initialize-TrackItExportFile
            Break
        }
        Default{
            $Initialize = $false
            #Return
        }
    }
    if($PSCmdlet.ParameterSetName -eq 'Initialize'){
        Break
    }
    Switch($DebugMe){
        $true{
            $previousDebugPreference = $DebugPreference
            $DebugPreference = 'Inquire'
        }
        Default{}
    }
    #region :: Variables
    #$DomainController = $(Get-16DomainController)[0].Name
    #$DomainController = 'SDODC1-08e'
    $DomainController = $(Get-ADDomainController -Discover -DomainName "scccd.net" -Service "PrimaryDC").Name
    $date = get-date
    $password = New-RandomPassword -length 10
    $sqlResults = Get-SQLWebAdvisorID -EmployeeIDs $EmployeeID
    [bool]$accountExists = Test-ADAccountExist -EmployeeID $EmployeeID
    $trackItInfo = Get-TrackItInfo -EmployeeID $EmployeeID
    $strSamAccountName = Get-NextSamAccountName -Initials $("{0}{1}" -f $sqlResults.GIVENNAME.Substring(0,1).ToLower(),$sqlResults.SURNAME.Substring(0,1).ToLower())
    #enregion

    if(($null -ne $trackItInfo.Site) -or ($trackItInfo.Site -notlike "")){
        $strSite = $trackItInfo.Site
    }
    elseif(($null -ne $sqlResults.SITE) -or ($sqlResults.SITE -ne "")){
        $strSite = $sqlResults.SITE
    }
    else{
        #$strSite = 'DO'
        $strSite = Read-Host -Prompt "Site?"
    }

    if($strSite -notlike ""){
        $site = get-SiteInfo -Site $strSite
    }
    else{
        $strSite = get-SiteInfo -help
        $site = get-SiteInfo $strSite.Site
    }

    if($null -like $sqlResults.EXTENSIONATTRIBUTE1){
        Write-Output $("WARNING: No ExtensionAttribute1 for {2}, {0} {1}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID)
        $sqlResults.EXTENSIONATTRIBUTE1 = Read-Host $("What is the WebAdvisorID (ExtensionAttribute1) for ({0}, {1} {2})?" -f $sqlResults.EMPLOYEEID,$sqlResults.GIVENNAME,$sqlResults.SURNAME)
    }

    if($accountExists){
        Get-UserInfo "$($sqlResults.Givenname) $($sqlResults.Surname)"
        break
    }
    else{
    }

    Switch($IsStudent){
        $true{
            $strSamAccountName = $("{0}{1}{2}" -f $sqlResults.GIVENNAME.Substring(0,1).ToLower(),$sqlResults.SURNAME.Substring(0,1).ToLower(),$sqlResults.EMPLOYEEID)
        }
    }

    if(-not $PSBoundParameters.ContainsKey('IsStudent')){
        if(($sqlResults.EMPLOYEETYPE -eq $trackItInfo.EmployeeType)){
            $EmployeeType = $sqlResults.EMPLOYEETYPE
        }
        elseif($null -ne $trackItInfo.EMployeeType){
            $EmployeeType = $trackItInfo.EmployeeType
        }
        elseif(($sqlResults.CHANGEDATE -gt $($(get-date).AddDays(-5))) -and ("" -ne $sqlResults.EMPLOYEETYPE)){
            $EmployeeType = $sqlResults.EMPLOYEETYPE
        }
        else{
            $EmployeeType = $(Read-Host -Prompt "Employee type? (Classified,Management,Faculty,Adjunct,Student)")
        }
    }else{
        $EmployeeType = "Student"
    }
    Write-Verbose $EmployeeType

    if($sqlResults.DEPARTMENT -eq $trackItInfo.Department){
        $department = $sqlResults.DEPARTMENT
    }elseif(($(get-date $($sqlResults.CHANGEDATE)) -gt $($(get-date).AddDays(-5))) -and (($sqlResults.DEPARTMENT -ne "") -and ($null -ne $sqlResults.TITLE))){
        $department = $sqlResults.DEPARTMENT
    }elseif(($sqlResults.DEPARTMENT -ne "") -or (($null -ne $sqlResults.DEPARTMENT) -or ($sqlResults.DEPARTMENT -like ""))){
        $department = $trackItInfo.Department
    }else{
        $department = Read-Host -Prompt $("What is the DEPARTMENT for ({2}, {0} {1})" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID)
    }

    if((($sqlResults.TITLE -ne "") -and ($null -ne $sqlResults.TITLE)) -and ($(get-date $sqlResults.CHANGEDATE) -gt $($(get-date).AddDays(-5)))){
        $title = $sqlResults.TITLE
    }elseif(($trackItInfo.TITLE -ne "") -and ($null -ne $trackItInfo.TITLE)){
        $title = $trackItInfo.TITLE
    }else{
        $title = Read-Host -Prompt $("What is the TITLE for ({2}, {0} {1})" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME,$sqlResults.EMPLOYEEID)
    }

    $accountSplat = @{
        AccountPassword   = $password.secure
        EmployeeID        = $EmployeeID
        Enabled           = $true
        Whatif            = $false
        sAMAccountName    = $strSamAccountName
        #UserPrincipalName = $("{0}@SCCCD.NET" -f $strSamAccountName)
    }

    if($department -notlike ""){
        $accountSplat.Add('Department',$department)
    }

    if($title -notlike ""){
        $accountSplat.Add('Title',$title)
    }

    if($sqlResults.EXTENSIONATTRIBUTE1 -ne ""){
        $accountSplat.Add('OtherAttributes',@{ExtensionAttribute1=$sqlResults.EXTENSIONATTRIBUTE1})
    }

    if($PSBoundParameters.ContainsKey('IsStudent')){
        $accountSplat.UserPrincipalName = $("{0}@SCCCD.NET" -f $strSamAccountName)
    }

    if($PSBoundParameters.ContainsKey('HasEmail')){
        $mailboxSplat = @{
            Alias = $strSamAccountName
            Database = $(Get-ExchangeDatabase -Site $site.Site -EmployeeType $EmployeeType)
        }
    }

    if(!(($site -like "") -or ($null -eq $site))){
        $accountSplat.Add('City',$site.City)
        $accountSplat.Add('Company',$site.Company)
        $accountSplat.Add('State',$site.State)
        $accountSplat.Add('PostalCode',$site.PostalCode)
        $accountSplat.Add('StreetAddress',$site.StreetAddress)
        $accountSplat.Add('Country',$site.Country)
        $accountSplat.Add('HomePage',$site.HomePage)
        $accountSplat.Add('Description',$("{0} - {1} - {2}" -f $site.Site,$department,$EmployeeType.Substring(0,1)))
        $accountSplat.Add('Path',$site.OU)
    }

    if($sqlResults.PREFERREDNAME -ne ""){
        $accountSplat.Add('DisplayName',$("{0}" -f $sqlResults.PREFERREDNAME,$sqlResults.SURNAME))
        $FirstName = $sqlResults.PREFERREDNAME.Split(" ")[0]
        $LastName = $sqlResults.PREFERREDNAME.Split(" ")[-1]
        if($PSBoundParameters.ContainsKey('HasEmail')){
            $secondarySMTP = $("{0}.{1}@{2}" -f $FirstName.ToLower().Replace(' ','-'),$LastName.ToLower().Replace(' ','-'),$site.Domain)
        }
    }
    else{
        $accountSplat.Add('DisplayName',$("{0} {1}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME))
    }
    $accountSplat.Add('Givenname',$("{0}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME))
    $accountSplat.Add('Surname',$("{1}" -f $sqlResults.GIVENNAME,$sqlResults.SURNAME))
    $accountSplat.Add('Name',$accountSplat.DisplayName)

    $primarySMTPAddress = $("{0}.{1}@{2}" -f $sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower(),$site.Domain)
    #Write-Debug $primarySMTPAddress

    if($EmployeeType -ne "Student"){
        $accountSplat.UserPrincipalName = $primarySMTPAddress
    }

    $accountSplat.GetEnumerator() #| fl

    #$continue = Read-Host "Continue? [Y|N]"
    $continue = 'y'
    if($continue -notmatch "y|Y|yes|Yes|true|1"){break}
    if($continue -match "y|Y|yes|Yes|true|1"){
        $strTeeFilename = (Join-Path (Join-Path ([Environment]::GetFolderPath("UserProfile")) "TrackIt-Export") $("{0}_{1}_{2}_{3}_{4}_pw.log" -f $(get-date $date -f 'yyyyMMdd-HHmmss'),$strSamAccountName,$EmployeeID,$sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower()))
        if(!($accountExists)){

            $missingAttributes = Test-NewAdAccount $accountSplat
            if($missingAttributes){
                $("Missing Attributes: {0}" -f $missingAttributes)
            }
            if($missingAttributes -eq 'None'){
                #region :: Create Account; log password

                Write-Debug $("{0},{1},{2},{3},{4},IsStudent: {5}" -f $accountSplat.sAMAccountName,$accountSplat.Givenname,$accountSplat.Surname,$accountSplat.EmployeeID,$accountSplat.UserPrincipalName,$($PSBoundParameters.ContainsKey('IsStudent')))
                if($PSCmdlet.ShouldProcess("SCCCD", "Adding $($accountSplat.sAMAccountName) to ")){

                    New-ADUser @accountSplat -Server $DomainController -PassThru | Tee-Object $strTeeFilename

                $(@"
Password          : $($password.text)
PasswordPhonetic  : $($password.Phonetic)
"@) | Out-String | Out-File -Append $strTeeFilename
                #np++ $strTeeFilename
                #endregion
                }
            }
            else{
                Write-Debug "Missing values"
                $missingAttributes
            }
        }

        $Counter = 0
        do{
            Try{
                $newAccount = Get-ADUser $accountSplat.sAMAccountName -Properties * -ErrorAction Stop -Server $DomainController
                [bool]$AccountSuccess = $true
            }Catch{
                [bool]$AccountSuccess = $false
            }
            if(($counter -gt 0) -and ($null -eq $newAccount.UserPrincipalName)){
                Write-Output $("{0} Seconds. Waiting to try again." -f $($counter * 30))
                Start-Sleep -Seconds 30
            }
            $counter++

        }Until(("" -notlike $newAccount.UserPrincipalName) -or ($counter -gt 5))

        if(Get-Variable -Name thisOutput -ErrorAction SilentlyContinue){Remove-Variable -Force thisOutput -ErrorAction SilentlyContinue}
        $thisOutput = @"
$(get-date $date -f 'MM/dd/yyyy HH:mm:ss')

SamAccountName...... : $($newAccount.SamAccountName)
Password............ : $($password.Text)

UserPrincipalName... : $($newAccount.UserPrincipalName)
Name................ : $($newAccount.Name)
DisplayName......... : $($newAccount.DisplayName)
GivenName........... : $($newAccount.Givenname)
Surname............. : $($newAccount.Surname)
EmployeeID.......... : $($newAccount.EmployeeID)
ExtensionAttribute1. : $($newAccount.ExtensionAttribute1)
Company............. : $($newAccount.Company)
Department.......... : $($newAccount.Department)
Title............... : $($newAccount.Title)
Description......... : $($newAccount.Description)
StreetAddress....... : $($newAccount.StreetAddress)
City................ : $($newAccount.City)
State............... : $($newAccount.State)
PostalCode.......... : $($newAccount.PostalCode)
Country............. : $($newAccount.Country)
HomePage............ : $($newAccount.HomePage)
Enabled............. : $($newAccount.Enabled)
ObjectClass......... : $($newAccount.ObjectClass)
ObjectGUID ......... : $($newAccount.ObjectGUID)
SID................. : $($newAccount.SID)
DistinguishedName... : $($newAccount.DistinguishedName)
Path................ : $($newAccount.DistinguishedName.Split(",")[1..4] -join ",")

"@
    }

    Switch(($HasEmail) -and (!$accountExists)){
        $true{
            $primarySMTPAddress = $("{0}.{1}@{2}" -f $sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower(),$site.Domain)

            $emailAddressAvailable = Test-EmailAddressAvailable -EmailAddress $primarySMTPAddress

            if($emailAddressAvailable){
                $mailboxSplat.Add('PrimarySMTPAddress',$primarySMTPAddress)
                $mailboxSplat.Add('Identity',$strSamAccountName)
            }
            Else{
                Write-Output "Email address not available: $($primarySMTPAddress)"
                pause
                [bool]$issues = $true
            }

            <#
            if(($null -ne $secondarySMTP) -and (Test-EmailAddressAvailable -EmailAddress $secondarySMTP)){

            }
            #>

            if($PSCmdlet.ShouldProcess("SCCCD Exchange","Adding $mailboxSplat to")){
                Try{
                    if($issues){pause}
                    #Write-Output $mailboxSplat.PrimarySMTPAddress

                    Write-Debug $mailboxSplat.PrimarySMTPAddress
                    Enable-Mailbox @mailboxSplat -DomainController $DomainController
                    [bool]$MailboxSuccess = $true
                }
                Catch{
                    [bool]$MailboxSuccess = $false
                }

                if($secondarySMTP -notlike ""){
                    if((Test-EmailAddressAvailable -EmailAddress $secondarySMTP)){
                        $c = 0
                        $m = $null
                        do{
                            $m = Get-Mailbox $mailboxSplat.Alias -DomainController $DomainController
                            if($c -gt 0){
                                Start-Sleep -Seconds 30
                            }
                            $c++
                        }Until($m.PrimarySMTPAddress -ne "" -or $c -gt 5)
                        Try{
                            #$strAddresses = $("`"SMTP:{0}`",`"smtp:{1}`"" -f $secondarySMTP,$primarySMTPAddress)
                            #Get-Mailbox $mailboxSplat.Alias | Set-Mailbox -EmailAddresses $strAddresses  -DomainController $DomainController
                            Get-Mailbox $mailboxSplat.Alias | Set-Mailbox -EmailAddresses "SMTP:$($secondarySMTP)","smtp:$($primarySMTPAddress)" -DomainController $DomainController
                        }
                        Catch{
                            Write-Verbose "Error $_"
                        }
                    }
                }
            }
            if(Get-Variable -Name newMailbox -ErrorAction SilentlyContinue){Remove-Variable -Name newMailbox -Force -ErrorAction SilentlyContinue}
            $counter = 0
            do{
                Try{
                    $newMailbox = Get-Mailbox $mailboxSplat.Alias -ErrorAction Stop -DomainController $DomainController
                }
                Catch{
                    Write-Verbose "Error $_"
                }
                if(($counter -gt 0) -and ($newMailbox.PrimarySMTPAddress -like "")){
                    Write-Output @("{0} Seconds. Waiting to try again." -f $($counter * 30))
                    Start-Sleep -Seconds 30
                }
                $counter++
            }Until(($newMailbox.PrimarySMTPAddress -notlike "") -or ($counter -gt 5))
            #Mail................ : $($newAccount.Mail)
            $thisOutput += @"
PrimaryMail......... : $($newMailbox.PrimarySmtpAddress)
SecondaryMail....... : $(if($newMailbox.EmailAddresses.Where({$_ -clike "smtp*"}).count -gt 0 ){$newMailbox.EmailAddresses.Where({$_ -clike "smtp*"}).replace('smtp:','')}else{$null})
"@
        }
        Default{
        }
    }
    if(!$accountExists){
        $strOutputFilename = (Join-Path (Join-Path ([Environment]::GetFolderPath("UserProfile")) "TrackIt-Export") $("{0}_{1}_{2}_{3}_{4}.log" -f $(get-date $date -f 'yyyyMMdd-HHmmss'),$strSamAccountName,$EmployeeID,$sqlResults.GIVENNAME.Replace(' ','-').ToLower(),$sqlResults.SURNAME.Replace(' ','-').ToLower()))
        $stream = [system.io.streamwriter]::new($strOutputFilename)
        Try{
            $thisOutput | Out-String | ForEach-Object{
                $stream.WriteLine($_)
            }
        }
        Finally{
            $stream.Close()
            Copy-Item -Path $strOutputFilename -Destination (Join-Path '\\sdofs1-08e\is$\Continuity\Celaya\AD\New_Accounts' (Split-Path $strOutputFilename -Leaf))
            if($AccountSuccess){
                Remove-Item $strTeeFilename
            }
            #np++ $strOutputFilename
        }
    }
    $DebugPreference = $previousDebugPreference
}
