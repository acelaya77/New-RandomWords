
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$WordCount = 3,
        [int]$MaxCharacterLength = 6,
        [Switch]$useWords,
        [Switch]$Download
    )#end Param()

    #Let's remove any variables
    @("words","rndWords","strPassword","password","myReturnObject") | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

    #use this to generate the list from a free API
    if($PSBoundParameters.ContainsKey("Download")){
        $path = "$env:USERPROFILE\Repositories\my_modules\SCCCDModules\New-RandomWords\words.txt"
        $path = (Join-Path "$PSScriptRoot" "words.txt")
        Invoke-WebRequest "https://random-word-api.herokuapp.com/all?swear=0" -OutFile $path

        $counter = 0
        $words = @()
        $(Get-Content $path).replace("[", "").replace("]", "").split(",").where( { $_.Length -lt 8 -and $_.length -gt 2 }) | ForEach-Object { $words += [PSCustomObject]@{
                Index = $("{0:00000}" -f $counter++)
                Word  = $($_).replace('"',"")
            } }
        <#
        $words[0..10]
        $words[-1]
        #>
        $words | Export-Csv -Delimiter "," -Nti (Join-Path (split-Path $path -Parent) (Split-Path $path -Leaf).replace("txt","csv"))
    }

    #$words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    if($PSBoundParameters.ContainsKey('useWords')){
        #write-warning "using words from parameters"
        #$words = Import-Csv -Delimiter "`t" (Join-Path "E:\My_Docs\repos\Modules\SCCCDModules\New-RandomWords\" "nautical_terms_stripped.csv")
        $words = Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "nautical_terms_stripped.csv")
        #$words | Get-Member

    }else{
        #$words = $(Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "eff_large_wordlist.csv").where({$_ -notmatch "ass|douche|(wo)?man"}))
        $words = $(Import-Csv -Delimiter "," (Join-Path $PSScriptRoot "words.csv"))
    }

    Write-Verbose "Word count: $($words.count)"
    $script:rndWords = $Null
    while([string]::IsNullOrEmpty($script:rndWords)){
        #$script:rndWords = $(Get-Random -InputObject $($words.word.ToLower().Where({$PSItem.Length -le $MaxCharacterLength})) -Count $WordCount)
        $script:rndWords = $(Get-Random -InputObject $($words.word.ToLower()) -Count $WordCount)
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
