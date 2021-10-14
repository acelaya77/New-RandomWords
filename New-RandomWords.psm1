
Function New-RandomWords {
    [cmdletbinding()]
    Param(
        [ValidateRange(3, 32)][int]$WordCount = 3,
        [ValidateRange(3, 32)][int]$MaxCharacterLength = 6,
        [Switch]$NewList
    )#end Param()

    #Let's remove any variables
    @('rndWords', 'strPassword', 'password', 'myReturnObject', 'swearWords', 'path').foreach({
            Get-Variable -Name:$_ -Scope:'Script' -ErrorAction:'ignore' -ErrorVariable:'getVarErrors' | 
                Remove-Variable -ErrorAction:'SilentlyContinue' -ErrorVariable:'removeVarErrors'
        })

    If ($PSBoundParameters.ContainsKey('Verbose') ) {
        $oldVerbose = $VerbosePreference
        $VerbosePreference = 'Continue'
    }

    #Our path
    if ([string]::IsNullOrEmpty($path)) {
        if ( [string]::IsNullOrEmpty($PSCommandPath) ) {
            $path = (Get-Location)
        }
        else {
            $path = (Split-Path $PSCommandPath -Parent)
        }
    }
    Write-Verbose $("Using path: '{0}'" -f $path)

    #The exclusions list
    if ( !(Test-Path(Join-Path $path 'swearWords.csv')) ) {
        $url = 'https://raw.githubusercontent.com/acelaya77/New-RandomWords/master/swearWords.csv'
        Write-Verbose $("Downloading swear-word list: '{0}'" -f $url)
        Invoke-WebRequest $url -UseBasicParsing -OutFile:(Join-Path $path 'swearWords.csv')
    }
    $Global:swearWords = Import-Csv (Join-Path $path 'swearWords.csv')


    #Build words list
    if ( ($PSBoundParameters.ContainsKey('NewList')) -or (($Global:words | Measure-Object).count -lt 1) ) {
        $wordsPath = (Join-Path $path 'words.txt')
        if ( (Test-Path($wordsPath)) -and !($PSBoundParameters.ContainsKey('NewList')) ) {
            Write-Verbose "`$Global:words exists, using that."
        }
        else {
            $url = 'https://raw.githubusercontent.com/acelaya77/New-RandomWords/master/words.txt'
            Write-Verbose $("Downloading word list: '{0}'" -f $url)
            Invoke-WebRequest $url -UseBasicParsing -OutFile:$wordsPath
        }
        $Global:words = $(Get-Content $wordsPath).split("`r`n")
        $Global:words = $Global:words.Where( { $_.word -notin $Global:swearWords.swearWords })
    }

    $script:rndWords = $Null
    while ( [string]::IsNullOrEmpty($script:rndWords) ) {
        $stopWatch = [system.diagnostics.stopwatch]::startNew()
        $script:rndWords = $(Get-Random -InputObject $($Global:words).where( { $PSItem.length -le $MaxCharacterLength }) -Count $WordCount)
        $stopWatch.Stop()
        Write-Verbose $('Word count: {0}, time: {1}' -f $($Global:words.count), $stopWatch.Elapsed.ToString('mm\m\:ss\.ffff\s'))
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
        @('rndWords', 'strPassword', 'password', 'myReturnObject', 'swearWords') | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors
        $VerbosePreference = $oldVerbose

    }#end function New-RandomWords
