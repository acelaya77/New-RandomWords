Function Initialize-NewMailboxes{
    [CmdletBinding()]

    Param(
    )

	$textInfo = (get-culture).TextInfo
	$inputFileSQL = $(Resolve-Path "$(Join-Path $env:USERPROFILE "TrackIt-Export")\NewMailboxes.csv")
    $inputFileTrackIt = $(Resolve-Path "$(Join-Path $env:USERPROFILE "TrackIt-Export")\Create-Me.csv")

    $inputSQL = Import-Csv $inputFileSQL
    $inputTrackIt = Import-Csv $inputFileTrackIt
    $inputTrackIt | ft -AutoSize

    $colNewMailboxes = @()

    foreach($i in $inputSQL){
        if($i.Site -eq ''){
            "Fixing: $($inputTrackIt[$inputTrackIt.IndexOf($i.EmployeeID)].Site)"
            $site = $($inputTrackIt[$inputTrackIt.IndexOf($i.EmployeeID)].Site)
        }
        else{
            #"Site correct"
            $site = $i.Site
        }
        #"$($i.EmployeeID) $site"
        $colNewMailboxes += @{
            EmployeeID = $i.EMPLOYEEID
            Site = $site
        }
    }
    $colNewMailboxes | ft -AutoSize

}

#Import-Module Initialize-NewMailboxes -Prefix "wip-" -Alias "wip-init-newbox"
