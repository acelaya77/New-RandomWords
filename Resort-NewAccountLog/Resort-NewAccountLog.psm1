
Function Resort-NewAccountLog{
$inputCSV = Import-Csv -Path "I:\Continuity\Celaya\AD\NewAccountsLog.csv" 

#$inputCSV | sort whenCreated -Descending | ft -AutoSize

$colImported = @()

foreach($item in $inputCSV){
    $colImported += [PSCustomObject] @{
        whenCreated = [DateTime]"$($item.whenCreated)"        SamAccountName = $item.SamAccountName        AccountPassword = $item.AccountPassword        UserPrincipalName = $item.UserPrincipalName        EmployeeID = $([int]$($item.EmployeeID)).ToString('0000000')        ExtensionAttribute1 = $item.ExtensionAttribute1        Name = $item.Name        GivenName = $item.GivenName        Surname = $item.Surname        DisplayName = $item.DisplayName        Mail = $item.Mail        Description = $item.Description        Title = $item.Title        Company = $item.Company        StreetAddress = $item.StreetAddress        City = $item.City        State = $item.State        PostalCode = $item.PostalCode        Department = $item.Department        wWWHomePage = $item.wWWHomePage        Path = $item.Path
    }
}

#Rename-Item -Path "I:\Continuity\Celaya\AD\NewAccountsLog.csv" -NewName "NewAccountsLog.csv.$(Get-Date -f 'yyyyMMdd-HHmmss')"
"Last Run:`r`n$(Get-Date -f 'yyyyMMdd-HHmmss')`r`n" | Out-File "I:\Continuity\Celaya\AD\NewAccountsLog-Backup.csv"
gc -Path "I:\Continuity\Celaya\AD\NewAccountsLog.csv" | Out-File "I:\Continuity\Celaya\AD\NewAccountsLog-Backup.csv" -Append

$colImported | sort -Descending whenCreated | export-csv -NoTypeInformation -Delimiter "," -Path "I:\Continuity\Celaya\AD\NewAccountsLog.csv" 
}#end Function Resort-NewAccountLog{}