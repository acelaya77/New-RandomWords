
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
        'rndWords'
        'strPassword'
        'password'
        'myReturnObject'
        'fauxPas'
    ) | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

    if ($MaxCharacterLength -le 3) {
        [int]$MaxCharacterLength = 6
    }
    $path = (Split-Path $PSCommandPath -Parent)

    #use this to generate the list from a free API
    if ($PSBoundParameters.ContainsKey('Download')) {
        Write-Host 'Downloading'
       
        $strFile = (Join-Path $path 'words.txt')

        Invoke-WebRequest 'https://random-word-api.herokuapp.com/all?swear=0' -OutFile $strFile -Verbose

        $counter = 0
        $script:words = @()
        $script:Words = $(Get-Content $strFile).replace('[', '').replace(']', '').split(',').where( { $_.Length -lt 10 -and $_.length -gt 2 }) | ForEach-Object {
            New-Object Object | 
                Add-Member -NotePropertyName:'Index' -NotePropertyValue:$('{0:00000}' -f $counter++) -PassThru |
                Add-Member -NotePropertyName:'Word' -NotePropertyValue:$($_.replace('"', '')) -PassThru
            }
            $script:words | Export-Csv -Delimiter ',' -Nti (Join-Path (Split-Path $strFile -Parent) (Split-Path $strFile -Leaf).replace('txt', 'csv'))
        }

        #exclusions list
        if ([string]::IsNullOrEmpty($path)) {
            $path = (Split-Path $PSCommandPath -Parent)
        
        }
        $fauxPas = Import-Csv (Join-Path $path 'swearWords.csv')


        #$words = Get-Content (Join-Path $PSScriptRoot "words.txt")
        if (($Global:words | Measure-Object).count -gt 0) {
            Write-Verbose "`$Global:words exists, using that."
        }
        else {

            if ($PSBoundParameters.ContainsKey('useWords')) {
                $Global:words = Import-Csv -Delimiter "`t" (Join-Path $path 'nautical_terms_stripped.csv')
            }
            else {
                $Global:words = $(Import-Csv -Delimiter ',' (Join-Path $path 'words.csv'))
            }
        
            $Global:words = $Global:words.Where( { $_.word -notin $fauxPas.swearWords })
        }

        Write-Verbose "Word count: $($Global:words.count)" #$Global:words[0]
        $script:rndWords = $Null
        while ( [string]::IsNullOrEmpty($script:rndWords) ) {
            $script:rndWords = $(Get-Random -InputObject $($Global:words.word).where( { $PSItem.length -le $MaxCharacterLength }) -Count $WordCount)
        }

        $punctuation = $(@('.', '?', '!') | Get-Random)
        $space = (@(' ', '_', '-') | Get-Random)
        $strPassword = $('{0}{3}{1}{2}' -f $((Get-Culture).TextInfo.ToTitleCase($script:rndWords[0])), $($script:rndWords[1..$($script:rndWords.Count)] -join $space), $punctuation, $space)
        $returnObject = $(ConvertTo-SecureString -Force -AsPlainText $strPassword) | ForEach-Object {
            New-Object Object |
                Add-Member -NotePropertyName:'AccountPassword' -NotePropertyValue:$_ -PassThru |
                Add-Member -NotePropertyName:'PlainPassword' -NotePropertyValue:$strPassword -PassThru
            }

            Return $returnObject

            #Let's remove any variables
            @('rndWords', 'strPassword', 'password', 'myReturnObject') | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

        }#end function New-RandomWords
