function Get-AvailableSamAccountName{
<#
.SYNOPSIS
Gets the next available Active Directory sAMAccountName in SCCCD.NET domain.

.DESCRIPTION
The Get-AvailableSamAccountName function iterates through Active Directory logins using the 5-digit alpha-numeric syntax for staff logins that we've implemented while giving the ability to exclude specific values.

.PARAMETER Initials
two single alpha characters designating the first and last initials of the desired login

.PARAMETER Exclude
any array of strings which should be excluded from the result.

This parameter is optional; if it is not included, it will give the first available login.

syntax
-----------
"ac001","ac004","ac010"

.EXAMPLE
Get-AvailableSamAccountName -Initials "ac" -Exclude "ac012","ac017"

Ouput
-----------
ac019

Description
-----------
Get next available sAMAccountName for new user Anthony Chavez, excluding both "ac012" and "ac017"

.EXAMPLE
Get-AvailableSamAccountName -Initials "hz" -Exclude @("hz002","hz003") -verbose

Ouput
-----------
VERBOSE: Excluded: hz002
VERBOSE: Excluded: hz003
hz004

Description
-----------
Get next available sAMAccountName for Harriet Zimmer, excluding "hz002" and "hz003".

.NOTES
You will need to run this command on a domain-joined session and must also set the execution policy to 'RemoteSigned'

#>
    [CmdletBinding()]
    Param(
        #[Parameter()][string]$Login,
        [Parameter(Mandatory=$true)]
        [ValidatePattern("^[a-zA-Z]{2}$")]
        [Alias("I")]
        [string]$Initials,
        
        [Parameter(Mandatory=$false)]
        [Alias("Exc")]
        [String[]]
        $Exclude
    ) # Param()

    Begin{
        $counter = 001
        if($Initials -ne $null){
            $testLogin = $Initials + $($counter.ToString('000'))
        } # if()
        #$testLogin = $Login
        $testMe = "$testLogin"
    } # Begin{}

    Process{
        do{
            $j = $null
            $testMe = "$($initials + $counter.ToString('000'))"

            #if($counter -gt 25){break}
            if($testMe -in $exclude){
                write-verbose "Excluded: $testMe"
                $counter++
                #$testMe = "$($initials + $counter.ToString('000'))"
                $j = $testMe
                continue
            } # if()

            if($($(Get-ADUser -Filter {sAMAccountName -eq $testMe} -ErrorAction SilentlyContinue).sAMAccountName)){
                $j = $($(Get-ADUser -Filter {sAMAccountName -eq $testMe} -ErrorAction SilentlyContinue).sAMAccountName)
            } # if()
            if($j -eq $null){
                break
            } # if()
            Else{
                #$j = $null
            } # else()
            $counter++
        }
        while($j -ne $null)

        $results = "$($initials + $counter.ToString('000'))"

        Return $results

    } # Process{}

    End{} # End{}
} # function get-nextSamAccountName{}