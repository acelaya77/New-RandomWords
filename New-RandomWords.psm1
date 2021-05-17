
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [int]$WordCount = 3,
        [int]$MaxCharacterLength = 6,
        [Switch]$NewList
    )#end Param()

    #Let's remove any variables
    @(
        'rndWords'
        'strPassword'
        'password'
        'myReturnObject'
        'fauxPas'
    ) | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

    If ($PSBoundParameters.ContainsKey('Verbose') ) {
        $oldVerbose = $VerbosePreference
        $VerbosePreference = 'Continue'
    }

    if ($MaxCharacterLength -le 3) {
        [int]$MaxCharacterLength = 8
    }
    $path = (Split-Path $PSCommandPath -Parent)

    #exclusions list
    if ([string]::IsNullOrEmpty($path)) {
        $path = (Split-Path $PSCommandPath -Parent)
    
    }
    
    if (($Global:fauxPas | Measure-Object).Count -lt 1) {
        $Global:fauxPas = Import-Csv (Join-Path $path 'swearWords.csv')
    }


    #$words = Get-Content (Join-Path $PSScriptRoot "words.txt")
    if ( ($PSBoundParameters.ContainsKey('NewList')) -or (($Global:words | Measure-Object).count -lt 1) ) {
        Write-Verbose "`$Global:words exists, using that."
        $Global:words = $(Get-Content (Join-Path $path 'words.txt')).split("`r`n")
        $Global:words = $Global:words.Where( { $_.word -notin $Global:fauxPas.swearWords })
    }

    $script:rndWords = $Null
    while ( [string]::IsNullOrEmpty($script:rndWords) ) {
        $stopWatch = [system.diagnostics.stopwatch]::startNew()
        $script:rndWords = $(Get-Random -InputObject $($Global:words).where( { $PSItem.length -le $MaxCharacterLength }) -Count $WordCount)
        $stopWatch.Stop()
        Write-Verbose $("Word count: {0}, time: {1}" -f $($Global:words.count),$stopWatch.Elapsed.ToString('mm\m\:ss\.ffff\s'))
    }
    
    $punctuation = $(@('.', '?', '!') | Get-Random)
    $space = (@(' ', '_') | Get-Random)
    $numerals = ((0..999) | Get-Random )
    $word1 = $((Get-Culture).TextInfo.ToTitleCase($script:rndWords[0]))
    $wordMiddle = $script:rndWords[1..($WordCount - 2)]
    $wordLast = $($script:rndWords[$WordCount - 1])
    $strPassword = $('{0}{1}{2}{1}{3}{1}{4}{5}' -f $word1, $space, $($wordMiddle -join $space), $numerals, $wordLast, $punctuation)
    $returnObject = $(ConvertTo-SecureString -Force -AsPlainText $strPassword) | ForEach-Object {
        New-Object Object |
        Add-Member -NotePropertyName:'AccountPassword' -NotePropertyValue:$_ -PassThru |
        Add-Member -NotePropertyName:'PlainPassword' -NotePropertyValue:$strPassword -PassThru
    }
    
    Return $returnObject
    
    #Let's remove any variables
    @('rndWords', 'strPassword', 'password', 'myReturnObject') | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors
    $VerbosePreference = $oldVerbose

}#end function New-RandomWords
