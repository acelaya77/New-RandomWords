function Out-Voice{
	param(
		[Parameter()]
		[ValidateSet('Microsoft David Desktop','Microsoft Zira Desktop')]
		[string[]]$voice = 'Microsoft Zira Desktop',
		
		[Parameter(ValueFromPipeline=$true,
			Position=0,
			Mandatory=$true)]
		[string[]]$Text,

		[Parameter(Mandatory=$false)]
		[ValidateSet($true,$false)]
		[switch]$SaveFile,

		[Parameter(Mandatory=$false)]
		[string]$FilePath = "$env:USERPROFILE\Documents\$(get-date -f 'yyyyMMdd-hhmmss').wav"
	) #end Param()
	
	$null = .{
		  <# Example 1
		  $sapi = New-Object -ComObject Sapi.SpVoice
		  $sapi.Speak($Text)
		  #>
		  Add-Type -AssemblyName System.speech
		  $SpeachSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
		  $SpeachSynth.SelectVoice("$voice")
	  
		  switch ($SaveFile){
			$true{
				$speachSynth.SetOutputToWaveFile($FilePath)
				$speachSynth.Speak("$text")
				$speachSynth.Dispose()
			} #end Case $TRUE
			$false{ $SpeachSynth.Speak("$text")} #end Case $FALSE
		} #end switch($SaveFile)
	} #end $null
} #end Function Out-Voice()
