#08-24-2018

#region :: Header
<#
********************************************************************************
	NAME...........: Get-SqlQueryResults.psm1
	AUTHOR.........: Anthony J. Celaya
	DESCRIPTION....: Return SQL query results from input query file.
	USAGE..........: 
	NOTES..........: 
	UPDATED........: 01-16-2018
	VERSION........: 1.1
	HISTORY........: 
		Ver		EntryDate	Editor	Description
		1.0		11-09-2017	ac007	INITIAL RELEASE
		1.1		01-16-2018	ac007	Changed delimiter to "," from "`t"; Changed output location to "DIST_LISTS\OUTPUT" folder versus "AD\Distribution_Lists".
********************************************************************************
#>
#endregion

Function Get-SqlQueryResults{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$true)]$queryFile
        ,[Parameter()]$groupName
        #,[Parameter()]$outputFile
        ,[Parameter()]$Server = "sdodw1"
        ,[Parameter()]$Database = "ODS_HR"
    )

    #$outputFile = "\\sdofs1-08e\is`$\Continuity\Celaya\AD\Distribution_Lists\dl_scccd_active_all_$(get-date -f 'yyyyMMdd-HHmmss').csv"
    #$groupName = "DL_SCCCD_Active_All"

    Begin{
        #used to read variables from content
        $content = gc $queryFile
        
        #AD group name from content
        #$groupName = $($content | ?{$_ -match "GROUP\s+:"} | %{$_.Split(':')[1]})[0].Trim()
        $groupName = $($content | ?{$_ -match "GROUP\s+:"}).Split(':')[-1].Trim()  # | %{$_.Split(':')[1]})[0].Trim()
        #$groupName | fl
        Write-Verbose "Here"

        #query from file
        $query = gc -Raw $queryFile

        #file to dump results
        $outputFile = "\\sdofs1-08e\is`$\Continuity\Celaya\DIST_LISTS\OUTPUT\$($groupName).csv"
        
        #region :: SQL connection settings
        $connectionTemplate = "Trusted_Connection=true;"
        $connectionString =  "server='$server';database='$Database';trusted_connection=true;"
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionString

        $command = New-Object System.Data.SqlClient.SqlCommand
        $command.CommandText = $query
        $command.Connection = $connection
        #endregion
    }

    Process{
        #region :: SQL
        $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
        $SqlAdapter.SelectCommand = $command
        $DataSet = New-Object System.Data.DataSet
        $SqlAdapter.Fill($DataSet)
        $connection.Close()
        #endregion ::


        if($DataSet.Tables[0].Rows.Count -gt 0){
            $DataSet.Tables[0] | sort EmployeeID | Export-Csv -NoTypeInformation -Delimiter "," $outputFile

            if(gv -ErrorAction SilentlyContinue -Name tmpGroup){rv -Force tmpgroup -ErrorAction SilentlyContinue}
            $tmpGroup = [PSCustomObject]@{
                GroupName = $groupName
                ResultCount = $DataSet.Tables[0].Rows.Count
                File = $outputFile
                OutputDate = $(get-date -f 'MM-dd-yyyy HH:mm:ss')
            }
            $Global:GroupList += $tmpGroup

            #Unremark the next line to open with Notepad++ alias
            #np++ $outputFile
            Write-Verbose $outputFile

        }

        Write-Verbose $DataSet.Tables[0].Rows.Count
        Write-Verbose $outputFile

        <#
        $Global:GroupList | Export-Csv -NoTypeInformation -Delimiter "," $groupFile
        np++ $groupFile
        #>

        #$DataSet

        Return $tmpGroup
    }

    End{}
}

<#
Remove-Module Get-SqlQueryResults
Import-Module Get-SqlQueryResults
#>