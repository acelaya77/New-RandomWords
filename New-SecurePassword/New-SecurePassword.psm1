
# Add required types for below functions
Add-Type -AssemblyName System.Web | Out-Null

Try{
# Define [RequiredChars] enum type
    Add-Type -Language CSharp -TypeDefinition @"
    [System.Flags]
    public enum RequiredChars
    {
        Absent = 0,
        Lowercase = 1,
        Uppercase = 2,
        Numeric = 4,
        Special = 8
    }
"@
}
Catch [InvalidOperationException]{
    Write-Error "Error Loading RequiredChars Type"
    Return
}
Catch [System.Exception]{
    Write-Warning "Error adding RequiredChars type. May already be added"
}

# The initial function, as it appears GeneratePassword() operates
Function GeneratePassword ([int]$Length){
Add-Type -AssemblyName System.Web


$CharSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{]+-[*=@:)}$^%;(_!&#?>/|.'.ToCharArray()
#Index1s    012345678901234567890123456789012345678901234567890123456789012345678901234567890123456
#Index10s   0         1         2         3         4         5         6         7         8

$rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$bytes = New-Object byte[]($Length)

$rng.GetBytes($bytes)

$Return = New-Object char[]($Length)

For ($i = 0 ; $i -lt $Length ; $i++){
    $Return[$i] = $CharSet[$bytes[$i]%$CharSet.Length]
}

Return (-join $Return)

}

# The first improved function. Works but inefficient
Function GeneratePassword2 ([int]$Length){
Add-Type -AssemblyName System.Web

$CharSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{]+-[*=@:)}$^%;(_!&#?>/|.'.ToCharArray()

$rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$byte = New-Object byte[](1)

$Return = New-Object char[]($Length)

For ($i = 0 ; $i -lt $Length ; $i++){
    Do{
        $rng.GetBytes($byte)
    } While ($byte -gt ([byte]::MaxValue - ([byte]::MaxValue % $CharSet.Length) -1) )
    
    $Return[$i] = $CharSet[[int]$byte[0]%$CharSet.Length]
}

Return (-join $Return)

}

# The final version of the function. This function is referenced in the New-SecurePassword function below.
Function GeneratePassword3 ([int]$Length){
Add-Type -AssemblyName System.Web

$CharSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{]+-[*=@:)}$^%;(_!&#?>/|.'.ToCharArray()

$rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider

#Establish jagged array
$bytes = New-Object 'System.Array[]'($length)
For ($i = 0; $i -lt $bytes.Count ; $i++){
    $bytes[$i] = New-Object byte[](2)
}

$Return = New-Object char[]($Length)

For ($i = 0 ; $i -lt $Length ; $i++){
    Do{
        $rng.GetBytes($bytes[$i])
        $num = [System.BitConverter]::ToUInt16($bytes[$i],0)
    } While ($num -gt ([uint16]::MaxValue - ([uint16]::MaxValue % $CharSet.Length) -1) )
    
    $Return[$i] = $CharSet[$num % $CharSet.Length]
}

Return (-join $Return)

}


Function New-SecurePassword{
<#
.Synopsis
    Generates secure random passwords
.DESCRIPTION
    Using the System.Web .net namespace, this function is able to generate cryptographically secure random passwords
    of a given length (up to 256 chars) and complexity.
    By default, the password(s) generated will include UPPERCASE, lowercase, numeric and non-alphanumeric characters.
    You can customise the password by using the -Include* parameters and passing a boolean false to exclude that
    character set, e.g. -IncludeSpecial $false
.EXAMPLE
    New-SecurePassword -Length 20 -Count 20

    Generate 20 passwords each of 20 characters in length including all character sets
.EXAMPLE
    New-SecurePassword -Length 14 -IncludeSpecial $false

    Generate a single password of length 14 that does not include any non-alphanumeric characters
.EXAMPLE
    1..20|%{New-SecurePassword -Length (Get-Random -Min 14 -Max 21) -IncludeNumeric $false -IncludeSpecial $false}

    Generate 20 passwords of random length between 14 and 20 characters consisting only of alphabetic characters
.NOTES
    Author: David Johnson http://poshhelp.wordpress.com
    
#>

    [CmdletBinding(DefaultParameterSetName='SpecifyCharacterClassesIndividually')]
    [OutputType([string[]])]
                                                                                                                                                                                                Param(
    #Length of Password(s) to generate
    [ValidateRange(1,256)]
    [Parameter(Mandatory=$false,
               ValueFromPipelineByPropertyName=$true,
               Position=0)]
    [int]
    $Length = 14,

    # Count of Password(s) to generate
    [ValidateRange(1,2147483646)]
    [Parameter(Mandatory=$false,
               ValueFromPipelineByPropertyName=$true,
               Position=1)]
    [int]
    $Count = 1,

    # Include lower case characters in the resulting password(s) (True/False). If this parameter is specified, the Bitflag parameter cannot be specified
    [Parameter(ParameterSetName='SpecifyCharacterClassesIndividually')]
    [Alias('Lower')]
    [bool]
    $IncludeLowerCase = $true,

    # Include lower case characters in the resulting password(s) (True/False). If this parameter is specified, the Bitflag parameter cannot be specified
    [Parameter(ParameterSetName='SpecifyCharacterClassesIndividually')]
    [Alias('Upper')]
    [bool]
    $IncludeUpperCase = $true,

    # Include lower case characters in the resulting password(s) (True/False). If this parameter is specified, the Bitflag parameter cannot be specified
    [Parameter(ParameterSetName='SpecifyCharacterClassesIndividually')]
    [Alias('Numeric')]
    [bool]
    $IncludeNumeric = $true,

    # Include lower case characters in the resulting password(s) (True/False). If this parameter is specified, the Bitflag parameter cannot be specified
    [Parameter(ParameterSetName='SpecifyCharacterClassesIndividually')]
    [Alias('Special')]
    [bool]
    $IncludeSpecial = $true,

    # Specify combination of character classes as a bitflag instead of individually. If this parameter is specified, the Include* parameters cannot be specified
    [Parameter(ParameterSetName='SpecifyCharacterClassesAsBitFlag')]
    [ValidateRange(0,15)]
    [RequiredChars]
    $Bitflag = 15,

    # Avoid ambiguous characters (e.g. 0/O/o l/1) in output password(s)
    [Parameter()]
    [switch]
    $AvoidAmbiguousCharacters,

    # If this parameter is specified, the password will be returned as an encrypted secure string rather than plain text
    [Parameter()]
    [switch]
    $AsSecureString
    )

Begin{
    #Build regex and checking bitflag
    
    Switch ($PSCmdlet.ParameterSetName){

        'SpecifyCharacterClassesIndividually'{
            $Bitflag = [RequiredChars]::Absent

            If ($IncludeLowerCase){$BitFlag += [RequiredChars]::Lowercase}
            If ($IncludeUpperCase){$BitFlag += [RequiredChars]::Uppercase}
            If ($IncludeNumeric){$BitFlag += [RequiredChars]::Numeric}
            If ($IncludeSpecial){$BitFlag += [RequiredChars]::Special}
        }
    }

    If ($BitFlag -eq 0){
        Throw New-Object System.ArgumentException("At least one character type must be included")
    }
    
    $PWRegex = @()

    $Lower                   = '[a-z]'
    $LowerNonAmbig           = '[a-hjkmnp-z]'
    $Upper                   = '[A-Z]'
    $UpperNonAmbig           = '[A-HJ-NP-Z]'
    $Numeric                 = '[0-9]'
    $NumericNonAmbig         = '[2-9]'
    $NonAlphaNumeric         = '[^a-zA-Z0-9]'
    $MinNonAlphaNumericChars = 0

    Switch ($BitFlag){
        {($_ -bAND 1) -eq 1}{$PWRegex += If ($AvoidAmbiguousCharacters) {$LowerNonAmbig} Else {$Lower}}

        {($_ -bAND 2) -eq 2}{$PWRegex += If ($AvoidAmbiguousCharacters) {$UpperNonAmbig} Else {$Upper}}

        {($_ -bAND 4) -eq 4}{$PWRegex += If ($AvoidAmbiguousCharacters) {$NumericNonAmbig} Else {$Numeric}}

        {($_ -bAND 8) -eq 8}{$PWRegex += $NonAlphaNumeric}# If ($_ -eq 8) { $MinNonAlphaNumericChars = [math]::Min($Length,128) }
        
        Default{}#Do Nothing
    } #End Switch

    $PWRegex = $PWRegex -join '|'

    Function ReturnString{
        If ($AsSecureString){
            ConvertTo-SecureString -String $Return -AsPlainText -Force
        }
        Else{
            $Return
        }
    }
    } #End Begin block

Process{
    For ($ctr = 0 ; $ctr -lt $Count ; $ctr++){
        #$Return = [System.Web.Security.Membership]::GeneratePassword(128,$MinNonAlphaNumericChars).ToCharArray() | Where {$_ -cmatch $PWRegex}

        $Return = (GeneratePassword3 128).ToCharArray() | Where {$_ -cmatch $PWRegex}

        While ($Return.Length -lt $Length){
            $AdditionalChars = (
                #[System.Web.Security.Membership]::GeneratePassword(128,$MinNonAlphaNumericChars)
                GeneratePassword3 128
                ).ToCharArray() | Where {$_ -cmatch $PWRegex}
            $Return += $AdditionalChars
        }

        $Return = (-join $Return).Substring(0, $Length)

        # Check that the generated password matches the complexity requirements. Discard if not.

        Switch ($BitFlag){
             #IncludeLower
             {($_ -bAND 1) -eq 1}{
                If ($Return -cnotmatch $Lower){
                    $ctr--
                    Break
                }
            }
            
            #IncludeUpper
            {($_ -bAND 2) -eq 2} {
                If ($Return -cnotmatch $Upper){
                    $ctr--
                    Break
                }
            }

            #IncludeNumeric
            {($_ -bAND 4) -eq 4}{
                If ($Return -cnotmatch $Numeric){
                    $ctr--
                    Break
                }
            }

            #IncludeSpecial
            {($_ -bAND 8) -eq 8} {
                If ($Return -cnotmatch $NonAlphaNumeric){
                    $ctr--
                    Break
                }
            }

            # Should always be true
            {$_ -gt 0} {
                ReturnString
            }
        }
    }
    } # End Process block

End{
    $Return = $AdditionalChars = $null
    }

} #End Function

