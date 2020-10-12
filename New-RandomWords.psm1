
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$WordCount = 3,
        [int]$MaxCharacterLength,
        [Switch]$useWords,
        [Switch]$Download
    )#end Param()

    #Let's remove any variables
    @(
        "rndWords"
        "strPassword"
        "password"
        "myReturnObject"
        "fauxPas"
    ) | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

    #if([string]::IsNullOrEmpty($MaxCharacterLength.ToString())){
    if($MaxCharacterLength -le 3){
        [int]$MaxCharacterLength = 6
    }

    #use this to generate the list from a free API
    if($PSBoundParameters.ContainsKey("Download")){
        Write-Host "Downloading"
        #$path = "$env:USERPROFILE\Repositories\my_modules\SCCCDModules\New-RandomWords\words.txt"
        $path = "e:\repos\windowspowershell-modules\SCCCDModules\New-RandomWords\"
        $strFile = (Join-Path $path "words.txt")
        #$path = (Join-Path "$PSScriptRoot" "words.txt")
        Invoke-WebRequest "https://random-words-api.herokuapp.com/all?swear=0" -OutFile $strFile -Verbose

        $counter = 0
        $script:words = @()
        $(Get-Content $strFile).replace("[", "").replace("]", "").split(",").where( { $_.Length -lt 10 -and $_.length -gt 2 -and $_ -notmatch "shit|tampon"}) | ForEach-Object { $script:words += [PSCustomObject]@{
                Index = $("{0:00000}" -f $counter++)
                Word  = $($_).replace('"',"")
            } }
        <#
        $words[0..10]
        $words[-1]
        #>
        $script:words | Export-Csv -Delimiter "," -Nti (Join-Path (split-Path $strFile -Parent) (Split-Path $strFile -Leaf).replace("txt","csv"))
    }

    #exclusions list
    if([string]::IsNullOrEmpty($path)){
        $path = $PSScriptRoot
        Write-Host -ForegroundColor DarkCyan $path
    }
    $fauxPas = Import-Csv (Join-Path $path "swearWords.csv")


    #$words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    if(($Global:words | Measure-Object).count -gt 0){
        Write-Verbose "`$Global:words exists, using that."
    }else{

        if($PSBoundParameters.ContainsKey('useWords')){
            #write-warning "using words from parameters"
            #$words = Import-Csv -Delimiter "`t" (Join-Path "E:\My_Docs\repos\Modules\SCCCDModules\New-RandomWords\" "nautical_terms_stripped.csv")
            $Global:words = Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "nautical_terms_stripped.csv")
            #$words | Get-Member
            
        }else{
            #$words = $(Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "eff_large_wordlist.csv").where({$_ -notmatch "ass|douche|(wo)?man"}))
            #$words = $(Import-Csv -Delimiter "," (Join-Path (split-path $path -parent) "words.csv"))
            $Global:words = $(Import-Csv -Delimiter "," (Join-Path $PSScriptRoot "words.csv"))
            #$words.Count
            #$words.count
        }
        
        $Global:words = $Global:words.Where({ $_.word -notin $fauxPas.swearWords })
    }

    Write-Verbose "Word count: $($Global:words.count)"
    $script:rndWords = $Null
    while([string]::IsNullOrEmpty($script:rndWords)){
        #$script:rndWords = $(Get-Random -InputObject $($words.word.ToLower().Where({$PSItem.Length -le $MaxCharacterLength})) -Count $WordCount)
        
        $script:rndWords = $(Get-Random -InputObject $($Global:words.word).where({$PSItem.length -le $MaxCharacterLength}) -Count $WordCount)
    }
    #$strPassword = $("{0} {1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($script:rndWords[0])),$($script:rndWords[1..$($script:rndWords.Count)] -join ' '),$(@('@','#','$','&','.','?','!') | Get-Random))
    $punctuation = $(@('.','?','!') | Get-Random)
    $space = (@(' ','_') | Get-Random)
    $strPassword = $("{0}{3}{1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($script:rndWords[0])),$($script:rndWords[1..$($script:rndWords.Count)] -join $space),$punctuation,$space)
    $password = $(ConvertTo-SecureString -Force -AsPlainText $strPassword)
    #$password
    #$strPassword

    $returnObject = [PSCustomObject]@{
        AccountPassword = $password
        PlainPassword = $strPassword
    }#end PSCustomObject

    Return $returnObject

    #Let's remove any variables
    @("rndWords","strPassword","password","myReturnObject") | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

}#end function New-RandomWords
