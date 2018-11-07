function Get-RandomPassword{
[CmdletBinding()]
    param(
    [parameter(HelpMessage="How long is the password?")]
    [Alias('Len')]
    [ValidateRange(4,64)]
    [int] $Length = 12,
    [parameter(HelpMessage="How many passwords to generate.")]
    [ValidateRange(1,64)]
    [int]$Count = 1,
    [parameter(HelpMessage="String of characters to use during password generation.")]
    [Alias('Characters')]
    [string] $chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789_!@#$%^&*()_"
    )
    1..$count | %{
    $bytes = new-object "System.Byte[]" $Length
    $result = ""
    $jj = 0
        do{
            $rnd = new-object System.Security.Cryptography.RNGCryptoServiceProvider
            $rnd.GetBytes($bytes)

            for( $i=0; $i -lt $Length; $i++ ){
            $result += $chars[$bytes[$i]%$chars.Length]
            $rr++
            Write-Verbose $result
            }
            
            $passCount = 0
            Switch($result){
                {$_ -match '\d'}{$passCount++}
                {$_ -cmatch '[a-z]'}{$passCount++}
                {$_ -cmatch '[A-Z]'}{$passCount++}
                {$_ -match '[_|\!|@|#|$|%|\^|&|\*|\(|\)]'}{$passCount++}
            }
            if($passCount -ge 3){
                [bool]$pass = $true
            }
            else{
                [bool]$pass = $false
                $result = ''
                Write-Verbose 'Trying again...'
            }

            <#
            #Must have at least one digit.
            if(!($result -match '\d')){
                Write-verbose $jj;write-verbose $result;$result = ''
            }
            #>
            
            $jj++
        }#end do{}
        #Until ($result -match '\d')
        #Until (($Pass) -and ($result -match '\d'))
        Until ($Pass)
        $result
        New-RandomPassword -password $result
    }#end %{}
}#end test-me{}
#$count = 16

<#
Try{Remove-Module Get-RandomPassword -ErrorAction SilentlyContinue}
Finally{Import-Module Get-RandomPassword}
#>
