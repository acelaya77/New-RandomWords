
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$count = 4,
        [int]$length = 4
    )#end Param()


    $words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    Write-Verbose "Word count: $($words.count)"
    $randoWords = Get-Random -InputObject $words -Count $count
    $strPassword = "{0} {1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($randoWords[0])),$($randoWords[1..$($randoWords.Count)] -join ' '),$(@('.','?','!','!','?','?','!') | Get-Random)    
    $password = ConvertTo-SecureString -Force -AsPlainText $strPassword
    #$password
    #$strPassword

    [PSCustomObject]@{
        AccountPassword = $password
        PlainPassword = $strPassword
    }#end PSCustomObject
}#end function New-RandomWords
