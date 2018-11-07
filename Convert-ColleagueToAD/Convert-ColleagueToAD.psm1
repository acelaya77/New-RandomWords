Function Convert-ColleagueToAD{

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]$inFile # = "\\sdofs1-08e\is$\Continuity\Celaya\DIST_LISTS\qryDL_SCCCD_Faculty.sql"
    )
    
    Begin{
        $inContent = gc $inFile

        #$group = $inContent[1].Split(' ')[1]
        $group = $($inContent.Where({$_ -match "^GROUP*"}).Split(':')[1]).Trim()
        #$group = $group.Replace('qry','').Replace('.sql','')
        $group

        $outputFile = "\\sdofs1-08e\is`$\Continuity\Celaya\DIST_LISTS\temp_$($group)_$(get-date -f 'yyyyMMdd-HHmmss').csv"
        $outputFile

        $Server = "sdodw1"
        $Database = "ODS_HR"
        $query = gc $inFile -Raw
    }#end Begin{}

    Process{
        $connectionTemplate = "Trusted_Connection=true;"
        $connectionString =  "server='$Server';database='$Database';trusted_connection=true;"
        #$connectionString = [string]::Format($connectionTemplate, $Server, $Database)
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionString

        $command = New-Object System.Data.SqlClient.SqlCommand
        $command.CommandText = $query
        $command.Connection = $connection

        $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
        $SqlAdapter.SelectCommand = $command
        $DataSet = New-Object System.Data.DataSet
        $SqlAdapter.Fill($DataSet)
        $connection.Close()

        $DataSet.Tables[0] | sort EmployeeID | Export-Csv -Delimiter "," -NoTypeInformation $outputFile

        np++ $outputFile

        write-verbose $($DataSet.Tables[0].Rows.Count)

        $table = @($DataSet.Tables[0])
        
        <#Debugging output
        $table[0..15] | ft -AutoSize
        #>
        
        <#
        $hashAD = @{}
        Get-ADUser -Filter {(EmployeeID -like "*") -and (Mail -like "*")} -Properties EmployeeID | %{$hashAD[$($_.EmployeeID)] = $($_.SamAccountName)}
        #>

        $props = @{
	        'Properties' = @(
		        'EmployeeID'
		        ,'sAMAccountName'
		        ,'Mail'
		        ,'GivenName'
		        ,'Surname'
		        ,'Company'
		        ,'Title'
		        ,'Department'
		        ,'Enabled'
	        )
        } #end $props

        $select = @{
	        'Property' = @(
			         'EmployeeID'
			        ,'sAMAccountName'
			        ,'Mail'
			        ,'GivenName'
			        ,'Surname'
			        ,'Company'
			        ,'Title'
			        ,@{n='Department';e={$($($_.Department) -split ' - ')[1]}}
			        ,'Enabled'
		        )
        } #end $select

        $colMatched = @()

        #$hashAD.Keys | ?{$table.employeeID -contains $_} | %{
        $Global:ADHash.Keys | ?{$table.employeeID -contains $_} | %{
            #$tmp = $null
            #$tmp = Get-ADUser @props $($hashAD[$_]) 
            $tmp = Get-ADUser @props $($Global:ADHash[$_])
            $colMatched += $tmp
            Try{Clear-Variable -Name tmp -ErrorAction SilentlyContinue}Catch{}
        } #end foreach-object{}

        $colMatched | Sort-Object EmployeeID | select @select | ft -AutoSize
        $colMatched.count

        $colMatched | select @select | Sort-Object EmployeeID | Export-Csv -Delimiter "," -NoTypeInformation $outputFile.Replace(".csv","_AD_matched.csv")
        np++ $outputFile.Replace(".csv","_AD_matched.csv")

        $oldMembers = Get-ADGroup $group | Get-ADGroupMember | Get-ADUser -Properties EmployeeID,Enabled,whenCreated,LastLogonDate,PasswordExpired,Mail | select EmployeeID,sAMAccountName,GivenName,Surname,Name,Mail,Enabled,PasswordExpired,lastLogonDate
        $oldMembers | Export-Csv -NoTypeInformation -Delimiter "," $outputFile.Replace('.csv','old_members.csv')

        #Get-ADGroup $group | Set-ADGroup -Clear Member -WhatIf
        #Get-ADGroup $group | Add-ADGroupMember -Members $colMatched.sAMAccountName

        $members = Get-ADGroup $group | Get-ADGroupMember | Get-ADUser -Properties sAMAccountName,Mail,Enabled,LastLogonDate,PasswordExpired | Select-Object -Property sAMAccountName,Name,Mail,Enabled,LastLogonDate,PasswordExpired 
        
        <# Debugging output
        $members | ft -AutoSize
        #>
        
        <#
        Compare-Object here...
        #>

        $matchedColleague = $table.count
        $matchedAD = $members.count
        $difference = $matchedColleague - $matchedAD
        $accuracy = (($matchedColleague - $difference)/$matchedColleague * 100)
        Write-Output "Number matched in Colleague...: $matchedColleague"
        Write-Output "Number matched in AD..........: $matchedAD"
        Write-Output "Difference....................: $difference"
        Write-Output "Accuracy......................: $($accuracy.ToString(00.00))%"

    }#end Process{}
}#end Function

<#
Remove-Module Convert-ColleagueToAD
Import-Module Convert-ColleagueToAD
#>