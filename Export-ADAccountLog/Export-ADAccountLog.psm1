Function Export-ADAccountLog{
[CmdletBinding()]
Param(
    [Parameter(ValueFromPipelineByPropertyName = $true)]
    [string[]]$samAccountName,
    
    [Parameter(Mandatory = $false)]
    [string]$Notes,

    [Parameter( Mandatory = $false )]
    [Switch]$InvokeItem,

    [Parameter( Mandatory = $false )]
    [Switch]$SetClipboard
)
    $users = $samAccountName | %{
        Get-ADUser -LDAPFilter:"(samAccountName=$($_))" -Properties:'*'
    }
    #$thisUser = Get-ADUser -LDAPFilter "(SamAccountName=$($samAccountName))" -Properties *

    foreach ($thisUser in $users){
        $date = get-date
        #$fileName = "AD_$(get-date -f 'yyyyMMdd-HHmmss')_$($samAccountName)_$($thisUser.GivenName.ToLower().Replace(" ","-"))_$($thisUser.Surname.ToLower().Replace(" ","-")).log"
        $fileName = "AD_{0}_{1}_{2}_{3}.log" -f $(get-date $date -f 'yyyyMMdd-HHmmss'),$thisUser.SamAccountName,$($thisUser.GivenName.ToLower().Replace(" ","-")),$($thisUser.Surname.ToLower().Replace(" ","-"))
        $filePath = (Join-Path "\\sdofs1-08e\is`$\Continuity\Celaya\AD\" "Separated_Logs")
        $file = (Join-Path $filePath $fileName)
        Write-Verbose $("Output file: `"{0}`"" -f  $file)
        
        $groups = @()
        $groups += $thisUser.MemberOf | Get-ADGroup | Select-Object -ExpandProperty Name
        
        $header = @"
================================================================================
TITLE......: $fileName
AUTHOR.....: Anthony J. Celaya
DATE.......: $(get-date $date -Format 'MM-dd-yyyy')
TIME.......: $(get-date $date -Format 'hh:mm:ss tt')
NOTES......: $($Notes)
================================================================================


"@
$output = $header
$output += @"
    Name..................: $($thisUser.Name)
    SamAccountName........: $($thisUser.SamAccountName)
    UserPrincipalName.....: $($thisUser.UserPrincipalName)
    EmployeeID............: $($thisUser.EmployeeID)
    ExtensionAttribute1...: $($thisUser.ExtensionAttribute1)
    GivenName.............: $($thisUser.GivenName)
    Surname...............: $($thisUser.Surname)
    DisplayName...........: $($thisUser.DisplayName)
    CanonicalName.........: $($thisUser.CanonicalName)
    Company...............: $($thisUser.Company)
    Department............: $($thisUser.Department)
    Title.................: $($thisUser.Title)
    Description...........: $($thisUser.Description)
    HomeDrive.............: $($thisUser.HomeDrive)
    HomeDirectory.........: $($thisUser.HomeDirectory)
    ScriptPath............: $($thisUser.ScriptPath)
    msNPAllowDialin.......: $($thisUser.msNPAllowDialin)
    Mail..................: $($thisUser.Mail)
    SMTP_Addresses........: $(try{[string]::join("`r`n`t......................: ",($(try{$($($($thisUser.ProxyAddresses) | Where-Object{!($_ -match $($thisUser.Mail)) -and !($_ -match $($thisUser.UserPrincipalName)) -and ($_ -cmatch "smtp:*")} | Sort-Object).Replace('smtp:',''))}catch{''})))}catch{''})
    Description...........: $($thisUser.Description)
    HomePage..............: $($thisUser.HomePage)
    StreetAddress.........: $($thisUser.StreetAddress)
    City..................: $($thisUser.City)
    PostalCode............: $($thisUser.PostalCode)
    State.................: $($thisUser.State)
    Country...............: $($thisUser.Country)
    whenCreated...........: $($thisUser.whenCreated)
    whenChanged...........: $($thisUser.whenChanged)
    LastLogonDate.........: $($thisUser.LastLogonDate)
    PasswordLastSet.......: $($($thisUser.PasswordLastSet) )
    PasswordExpired.......: $($thisUser.PasswordExpired)
    Enabled...............: $($thisUser.Enabled)
    UserAccountControl....: $($thisUser.UserAccountControl)
    UAC Calculated........: $(Convert-UserAccountControl $thisUser.UserAccountControl)
    X400..................: $(try{[string]::join("`r`n`t......................: ",($thisUser.ProxyAddresses | Where-Object{($_ -match "X400:*")}).Replace('X400:',''))}catch{''})
    EUM...................: $(try{[string]::join("`r`n`t......................: ",($thisUser.ProxyAddresses | Where-Object{($_ -match "EUM:*")}).Replace('EUM:',''))}catch{''})
    GUID..................: $($thisUser.objectGUID)
    SID...................: $($thisUser.objectSID)

    Groups:

    $(if($groups.count -gt 0){
            $([string]::join("`r`n$(' '*4)",$($groups  | Sort-Object Name)))
    })
"@
        
    $stream = [System.IO.StreamWriter]::new($file)
    Try{
        $output | Out-String -Stream | ForEach-Object{
            $stream.WriteLine($_.Trim())
        }
    }Finally{
        $stream.Close()
    }

    $file
    
    if ( $PSBoundParameters.ContainsKey('SetClipboard') ) {$output | clip}

    if($InvokeItem){
        Invoke-Item $file
    }
    Write-Verbose $("np++ {0}" -f $file)
    }

}#end Function Export-ADAccountLog{}
    