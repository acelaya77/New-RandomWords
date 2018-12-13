


#region :: Header
<#

NAME        : Remove-FromTrackItExport.ps1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Remove processed row from the export file. 
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 
UPDATED     : 12-13-2018
VERSION     : 1.0



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE

#>
#endregion

Function Remove-FromTrackItExport{
    Param(
        [Parameter(Mandatory=$true)]
        [Alias('User')]$EmployeeID
    )

    $file = get-item (Join-Path "C:\Users\ac007\TrackIt-Export" "Create-Me.csv")
    $contents = Import-Csv $file
    $thisHeader = Get-Content $file | Select-Object -First 1

    if($contents.count){
        $contents.where({$_.EmployeeID -ne $EmployeeID}) | Export-Csv -Delimiter "," -NTI $file
    }
    else{
        $thisHeader | Out-File $file
    }

}

