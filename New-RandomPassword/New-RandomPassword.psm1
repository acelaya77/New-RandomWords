#region :: Header
<#

NAME        : New-RandomPassword.psm1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Generate a random password which matches security requirements including uppercase, lowercase, numbers and symbols.
MODULES     :
GLOBAL VARS :
UPDATED     : 08-06-2018
VERSION     : 1.3



Ver EntryDate  Editor Description
--- ---------  ------ -----------
1.0 11-08-2017 ac007  INITIAL RELEASE
1.1 02-13-2018 ac007  Cleaned up a bit.
1.2 04-12-2018 ac007  Updated with code excluding empty results.
1.3 08-06-2018 ac007  Added code to output phonetic alphabet encoding.

#>
#endregion



Function Out-Phonetic {
	[CmdletBinding()]
	Param(
		$string
	)

	$phoneticHash = @{
		'a' = "Alpha"
		'b' = "Bravo"
		'c' = "Charlie"
		'd' = "Delta"
		'e' = "Echo"
		'f' = "Foxtrot"
		'g' = "Golf"
		'h' = "Hotel"
		'i' = "India"
		'j' = "Juliet"
		'k' = "Kilo"
		'l' = "Lima"
		'm' = "Mike"
		'n' = "November"
		'o' = "Oscar"
		'p' = "Papa"
		'q' = "Quebec"
		'r' = "Romeo"
		's' = "Sierra"
		't' = "Tango"
		'u' = "Uniform"
		'v' = "Victor"
		'w' = "Whiskey"
		'x' = "X-ray"
		'y' = "Yankee"
		'z' = "Zulu"
		'0' = "Zero"
		'1' = "One"
		'2' = "Two"
		'3' = "Three"
		'4' = "Four"
		'5' = "Five"
		'6' = "Six"
		'7' = "Seven"
		'8' = "Eight"
		'9' = "Nine"
		' ' = "Space"
		'!' = "Exclamation"
		'"' = "DoubleQuote"
		'#' = "Hash"
		'$' = "Dollars"
		'%' = "Percent"
		'&' = "Ampersand"
		'(' = "LeftParens"
		')' = "RightParens"
		'*' = "Asterisk"
		'+' = "Plus"
		',' = "Comma"
		'-' = "Dash"
		'.' = "Period"
		'/' = "ForeSlash"
		':' = "Colon"
		';' = "SemiColon"
		'<' = "LessThan"
		'=' = "Equals"
		'>' = "GreaterThan"
		'?' = "Question"
		'@' = "At"
		'[' = "LeftBracket"
		"'" = "SingleQuote"
		'\' = "BackSlash"
		']' = "RightBracket"
		'^' = "Caret"
		'_' = "Underscore"
		'`' = "Backtick"
		'{' = "LeftBrace"
		'|' = "Pipe"
		'}' = "RightBrace"
		'~' = "Tilde"
	}

	[array]$thisPassword = $string.ToString().ToCharArray() | ForEach-Object { [char]$_ }

	[string]$tmp = $(foreach ($c in $thisPassword) {
			[string]$strTemp = $c
			if($strTemp -cmatch "[a-z]"){
				$phoneticHash.GetEnumerator().where( {$_.key -eq "$strTemp"}).value.tolower()
			}elseif($strTemp -cmatch "[A-Z]"){
				$phoneticHash.GetEnumerator().where( {$_.key -eq "$strTemp"}).value.toUpper()
			}
			else{
				$phoneticHash.GetEnumerator().where( {$_.key -eq "$strTemp"}).value.tolower()
			}
		}) -join " - "
	Return $tmp

}

Function New-RandomPassword{
[CmdletBinding()]
Param(
	 [parameter(ParameterSetName='Gen1',Mandatory=$true) ][int]$length
    ,[parameter(ParameterSetName='Pass1',Mandatory=$true)][string]$password
)
Begin{
	#$ofs = ""
}
Process{

	if($password -eq ''){
        
        #$length = 8
	    #$categories = (3..4) | get-random

	    $caps = [char[]] "ABCDEFGHJKLMNPQRSTUVWXYZ"
	    $lows = [char[]] ($([string[]]$caps).tolower())
	    $nums = [char[]] [string[]] (2..9)
	    #$symb = [char[]] "@#$%&!<>" #"!@#$%&*()"
        $symb = [char[]] '@#$&<>.?!' #"!@#$%&*()"

	    #$symbCount = 2 #Get-Random -Minimum 1 -Maximum 2
        $symbCount = 1 #Get-Random -Minimum 1 -Maximum 2
	    $numsCount = Get-Random -Minimum 1 -Maximum ($length-$symbCount-2)
	    $capsCount = Get-Random -Minimum 1 -Maximum ($length-$symbCount-$numsCount-1)
	    $lowsCount = $length-$symbCount-$capsCount-$numsCount

	    #$bytes = new-object "System.Byte[]" $length

	    #$random = new-object System.Security.Cryptography.RNGCryptoServiceProvider
	    #$random.GetBytes($bytes)

	    if(Get-Variable -name result -ErrorAction SilentlyContinue){remove-variable -name result} #$result = $null
	    $result = @()
	    $result += [string[]]($caps | Get-Random -Count $capsCount)
	    $result += [string[]]($nums | Get-Random -Count $numsCount)
	    $result += [string[]]($lows | Get-Random -Count $lowsCount)
	    $result += [string[]]($symb | Get-Random -Count $symbCount)
	    $result = [string[]]$($result.Replace(" ",'')) | ForEach-Object{$_} | Sort-Object {Get-Random}
	    [string]$result = $result -join ""

        #$result = ([System.Web.Security.Membership]::GeneratePassword($length,1))

    }else{
        $result = $password
    }
    #$result | Get-Member
    $output = [PSCustomObject]@{
		Secure = (ConvertTo-SecureString -AsPlainText $result -Force)
		Text = $result
		Phonetic = Out-Phonetic -string $result
	}
	#$output

	#return $result,(convertTo-SecureString -AsPlainText $result -Force)
	Return $output
	#return [string]$([char[]]$result | sort {Get-random})
}
End{
	if($result){remove-variable -name result}
	if($ofs){remove-variable -name ofs}
}
#Note: Test
# 1..$length | ForEach { $NewPassword = $NewPassword + [char]$randomObj.next(33,126) }
}

<#

Remove-Module New-RandomPassword
Import-Module New-RandomPassword

New-RandomPassword -length 10

#>


