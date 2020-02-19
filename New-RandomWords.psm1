
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$WordCount = 3,
        [int]$MaxCharacterLength = 6,
        [Switch]$useWords
    )#end Param()

    #Let's remove any variables
    @("words","rndWords","strPassword","password","myReturnObject") | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

    #$words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    if($PSBoundParameters.ContainsKey('useWords')){
        #write-warning "using words from parameters"
        #$words = Import-Csv -Delimiter "`t" (Join-Path "E:\My_Docs\repos\Modules\SCCCDModules\New-RandomWords\" "nautical_terms_stripped.csv")
        $words = Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "nautical_terms_stripped.csv")
        #$words | Get-Member

    }else{
        $words = $(Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "eff_large_wordlist.csv").where({$_ -notmatch "badass"}))
        <#
        $words = Import-Csv -Delimiter "`t" (Join-Path "E:\My_Docs\repos\Modules\SCCCDModules\New-RandomWords" "eff_large_wordlist.csv")
        #>
        #$words = $words.where({$PSItem -notmatch "badass"})
    }
    Write-Verbose "Word count: $($words.count)"
    $script:rndWords = $Null
    while([string]::IsNullOrEmpty($script:rndWords)){
        $script:rndWords = $(Get-Random -InputObject $($words.word.ToLower().Where({$PSItem.Length -le $MaxCharacterLength})) -Count $WordCount)
    }
    $strPassword = $("{0} {1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($script:rndWords[0])),$($script:rndWords[1..$($script:rndWords.Count)] -join ' '),$(@('.','?','!') | Get-Random))
    $password = $(ConvertTo-SecureString -Force -AsPlainText $strPassword)
    #$password
    #$strPassword

    $returnObject = [PSCustomObject]@{
        AccountPassword = $password
        PlainPassword = $strPassword
    }#end PSCustomObject

    Return $returnObject

    #Let's remove any variables
    @("words","rndWords","strPassword","password","myReturnObject") | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

}#end function New-RandomWords
