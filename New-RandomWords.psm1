
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
    $path = Switch ($Host.name){
            'Visual Studio Code Host' { split-path $psEditor.GetEditorContext().CurrentFile.Path }
            'Windows PowerShell ISE Host' {  Split-Path -Path $psISE.CurrentFile.FullPath }
            'ConsoleHost' { $PSScriptRoot }
        }
    #Write-host -ForegroundColor:Cyan $path
    
    #use this to generate the list from a free API
    if($PSBoundParameters.ContainsKey("Download")){
        Write-Host "Downloading"
       
        $strFile = (Join-Path $path "words.txt")

        Invoke-WebRequest "https://random-word-api.herokuapp.com/all?swear=0" -OutFile $strFile -Verbose

        $counter = 0
        $script:words = @()
        $script:Words = $(Get-Content $strFile).replace("[", "").replace("]", "").split(",").where( { $_.Length -lt 10 -and $_.length -gt 2 }) | ForEach-Object {
                New-Object Object | 
                    Add-Member -NotePropertyName:"Index" -NotePropertyValue:$("{0:00000}" -f $counter++) -PassThru |
                    Add-Member -NotePropertyName:"Word" -NotePropertyValue:$($_.replace('"',"")) -PassThru
<#
              $script:words += [PSCustomObject]@{
                Index = $("{0:00000}" -f $counter++)
                Word  = $($_).replace('"',"")
            }
#>
         }
        <#
        $script:words[0..10]
        $script:words[-1]
        #>
        $script:words | Export-Csv -Delimiter "," -Nti (Join-Path (split-Path $strFile -Parent) (Split-Path $strFile -Leaf).replace("txt","csv"))
    }

    #exclusions list
    if([string]::IsNullOrEmpty($path)){
        $path = Switch ($Host.name){
            'Visual Studio Code Host' { split-path $psEditor.GetEditorContext().CurrentFile.Path }
            'Windows PowerShell ISE Host' {  Split-Path -Path $psISE.CurrentFile.FullPath }
            'ConsoleHost' { $PSScriptRoot }
        }
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
            $Global:words = Import-Csv -Delimiter "`t" (Join-Path $path "nautical_terms_stripped.csv")
            #$words | Get-Member
            
        }else{
            #$words = $(Import-Csv -Delimiter "`t" (Join-Path $PSScriptRoot "eff_large_wordlist.csv").where({$_ -notmatch "ass|douche|(wo)?man"}))
            #$words = $(Import-Csv -Delimiter "," (Join-Path (split-path $path -parent) "words.csv"))
            $Global:words = $(Import-Csv -Delimiter "," (Join-Path $path "words.csv"))
            #$words.Count
            #$words.count
        }
        
        $Global:words = $Global:words.Where({ $_.word -notin $fauxPas.swearWords })
    }

    Write-Verbose "Word count: $($Global:words.count)"
    $script:rndWords = $Null
    while ( [string]::IsNullOrEmpty($script:rndWords) ) {
        $script:rndWords = $(Get-Random -InputObject $($Global:words.word).where({$PSItem.length -le $MaxCharacterLength}) -Count $WordCount)
    }

    $punctuation = $(@('.','?','!') | Get-Random)
    $space = (@(' ','_','-') | Get-Random)
    $strPassword = $("{0}{3}{1}{2}" -f $((get-Culture).TextInfo.ToTitleCase($script:rndWords[0])),$($script:rndWords[1..$($script:rndWords.Count)] -join $space),$punctuation,$space)
    $returnObject = $(ConvertTo-SecureString -Force -AsPlainText $strPassword) | ForEach-Object {
        New-Object Object |
            Add-Member -NotePropertyName:"AccountPassword" -NotePropertyValue:$_ -PassThru |
            Add-Member -NotePropertyName:"PlainPassword" -NotePropertyValue:$strPassword -PassThru
    }

    Return $returnObject

    #Let's remove any variables
    @("rndWords","strPassword","password","myReturnObject") | Get-Variable -Scope Script -ErrorAction SilentlyContinue -ErrorVariable getVarErrors | Remove-Variable -ErrorAction SilentlyContinue -ErrorVariable removeVarErrors

}#end function New-RandomWords
