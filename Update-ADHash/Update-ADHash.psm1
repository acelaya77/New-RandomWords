#region :: Header
<#

NAME        : Update-ADHash.psm1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Creates a local hash table of all AD accounts with employeeID to more quickly enumerate/search for AD accounts by non-indexed attribute, EmployeeID.
MODULES     :
GLOBAL VARS : $Global:ADHash
UPDATED     : 08-08-2018
VERSION     : 1.2



Ver EntryDate  Editor Description
--- ---------  ------ -----------
1.0 11-08-2017 ac007  INITIAL RELEASE
1.1 02-13-2018 ac007  Cleaned up a bit.
1.2 08-08-2018 ac007  Added stopwatches to help account for efficiency.
1.3 08-08-2018 ac007  Changed query to LDAP query to test speed increase.

#>
#endregion




Function Update-ADHash{

[CmdletBinding()]

Param(
	 [Parameter(Position=0)][Switch]$NewHash
	,[Parameter(Position=1)]$hashFile = (Join-Path $([environment]::GetFolderPath("UserProfile")) "ADHash.xml") #"c:\Users\ac007\ADHash.xml"
)

    $sw = [system.diagnostics.stopwatch]::StartNew()

    $colDuplicateIDs = @()
    [int]$priorCount = $Global:ADHash.count

	if((gv -Name ADHash -Scope Global -ErrorAction SilentlyContinue) -or ($NewHash)){
		rv -Name ADHash -Scope Global -ErrorAction SilentlyContinue
		$Global:ADHash = [hashtable]::Synchronized(@{})
	}
    else{
        
    }

	<#
	#$ADUsers = Get-ADUser -Filter {(SamAccountName -like "*") -and (EmployeeID -like "*")} -Properties EmployeeID,sAMAccountName,Enabled,Mail | ?{($_.EmployeeID -notmatch "6754722") -and ($_.Enabled -eq $true) -and ($_.Mail -ne $null)} | Select-Object EmployeeID,sAMAccountName,Enabled,Mail
	$thisADUsers = Get-ADUser -Filter {(SamAccountName -like "*") -and (EmployeeID -like "*")} -Properties EmployeeID,sAMAccountName,Enabled,Mail | ?{($_.EmployeeID -notmatch '^[244|265|324|325|442|443|489|637|638|675][\d]{4}$') -and ($_.Enabled -eq $true) } | Select-Object EmployeeID,sAMAccountName,Enabled,Mail
	#$ADUsers = Get-ADUser -Filter {(SamAccountName -like "*") -and (EmployeeID -like "*")} -Properties EmployeeID,sAMAccountName,Enabled,Mail | ?{($_.EmployeeID -notmatch '^[244|265|324|325|442|443|489|637|638|675][\d]{4}$') -and ($_.Enabled -eq $true) -and ($_.Mail -ne $null)} | Select-Object EmployeeID,sAMAccountName,Enabled,Mail
	#>
	
	$strRegEx = '^[244|265|324|325|442|443|489|637|638|675][\d]{4,}$'
	$strLDAPFilter = "(&(objectCategory=person)(objectClass=user)(EmployeeID=*)(!(objectClass=contact)))"

    $swADQuery = [system.diagnostics.stopwatch]::StartNew()
    #$ADUsers = Get-ADUser -Filter {(SamAccountName -like "*") -and (EmployeeID -like "*")} -Properties EmployeeID,sAMAccountName,Enabled,Mail | ?{($_.EmployeeID -notmatch $strRegEx) } | Select-Object EmployeeID,sAMAccountName,Enabled,Mail
    $ADUsers = Get-ADUser -LDAPFilter $strLDAPFilter -Properties EmployeeID,sAMAccountName,Enabled,Mail -Server $DomainController | ?{($_.EmployeeID -notmatch $strRegEx) } | Select-Object EmployeeID,sAMAccountName,Enabled,Mail
    $swADQuery.stop()

	$counter = 1 #Used to count results, if more than one, accounting for duplicate accounts
#region :: New Code :: 2018-04-23

	foreach($item in $($ADUsers | Group-Object -Property EmployeeID | Sort-Object Count -Descending)){
		
		$counter = $item.Count

		for($i = 1;$i -le $item.count; $i++){
			
			Switch($counter){
				{$_ -gt 1}{
					
					$colDuplicateIDs += [PSCustomObject]@{
						Number = $i
						EMployeeID = $item.Group.EmployeeID[$i-1]
						SamAccountName = $item.Group.SamAccountName[$i-1]
						Enabled = $item.Group.Enabled[$i-1]
						Mail = $item.Group.Mail[$i-1]
					} #end [PSCustomObject]@{}

					$Global:ADHash["$($item.Group.EmployeeID[$i-1])_$($i.ToString('0'))"] = "$($item.Group.sAMAccountName[$i-1])"

				} #end switch Item1
				
				Default{
					
					$colDuplicateIDs += [PSCustomObject]@{
						Number = $i
						EMployeeID = $item.Group.EmployeeID
						SamAccountName = $item.Group.SamAccountName
						Enabled = $item.Group.Enabled
						Mail = $item.Group.Mail
					} #end [PSCustomObject]@{}                    

					$Global:ADHash["$($item.Group.EmployeeID)"] = "$($item.Group.sAMAccountName)"

				} #end Switch item 2
			} #end switch()

		} #end for()

	} #end foreach()

#endregion :: New Code :: 2018-04-23

    [int]$postCount = $Global:ADHash.Count
	$Global:ADHash | Export-CliXml -Path $hashFile
	$Global:ADHash.GetEnumerator() | Select-Object Key,Value | Sort-Object Key | Export-Csv -Delimiter "," -NoTypeInformation $hashFile.replace('.xml','.csv')
	if($colDuplicateIDs.count -ge 1){
		#$colDuplicateIDs.where({$_.Number -gt 1}) | Sort-Object EmployeeID,Number| Export-Csv -NoTypeInformation -Delimiter "," -Path $hashFile.replace('.xml','_duplicates.csv')
        $colDupClone = $colDuplicateIDs.Clone()
        $colDupClone = $colDupClone.where({$_.Number -gt 1})
        #$colDupClone | ft -AutoSize
        #$importedCSV[[Array]::FindIndex( $importedCSV, [System.Predicate[PSCustomObject]]{ $args[0].EmployeeID -eq $_.EMPLOYEEID })].GIVENNAME
        $colThese = @()
        foreach($e in $colDupClone){
            $colThese += $colDuplicateIDs[[Array]::FindIndex($colDuplicateIDs,[System.Predicate[PSCustomObject]]{$args[0].EmployeeID -eq $e.EmployeeID})]
        }
        $colDupClone += $colThese
        #$colDupClone | sort-Object EMployeeID | ft -AutoSize
        $colDupClone | Sort-Object EmployeeID,Number| Export-Csv -NoTypeInformation -Delimiter "," -Path $hashFile.replace('.xml','_duplicates.csv')
	}
	
	
    $sw.Stop()
    $colors = @{
        ForegroundColor = "DarkCyan"
    }
    Write-Host @colors $("`$Global:ADHash.Count  : {0:n0}" -f  $priorCount)
    Write-Host @colors $("Script run duration   : {0}:{1}.{2}" -f $sw.Elapsed.Minutes,$sw.Elapsed.Seconds,$sw.Elapsed.Milliseconds)
    Write-Host @colors $("Query run duration    : {0}:{1}.{2}" -f $swADQuery.Elapsed.Minutes,$swADQuery.Elapsed.Seconds,$swADQuery.Elapsed.Milliseconds)
    Write-Host @colors $("`$Global:ADHash.Count  : {0:n0}" -f  $postCount)
    Write-Host @colors $("Difference            : {0:n0}" -f $($postCount - $priorCount))
}

<#

Remove-Module Update-ADHash
Import-Module Update-ADHash

#>
