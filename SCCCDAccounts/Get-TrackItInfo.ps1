
#region :: Header
<#

NAME        : Get-TrackItInfo.ps1 
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Return array of information from row of TrackIt-Export file based on EmployeeID match. 
MODULES     :
GLOBAL VARS : 
LAST RAN    : 02/13/2018
UPDATED     : 02-13-2018
VERSION     : 1.0



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE

#>
#endregion


Function Get-TrackItInfo{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][String]$EmployeeID
    )

    $inputFile = get-item (Join-Path "$(([environment]::GetFolderPath("UserProfile")))\TrackIt-Export" "TrackIT-Export.csv")
    [array]$thisImported = Import-Csv $inputFile
    
    $indexNumber = [Array]::FindIndex($thisImported,[System.Predicate[PSCustomObject]]{$args[0].EmployeeID -eq $EmployeeID})
    
    if($indexNumber -ne -1){
        $thisItem = $thisImported[$indexNumber]
    }
    else{
        $thisItem = $Null
    }
    
    Return $thisItem
}

