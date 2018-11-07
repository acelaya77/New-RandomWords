<#
	Replace-Tempoutput
	Logs and clears TempOutput.log
#>
Function Replace-TempOutput{
	#$file = gci "I:\Continuity\Celaya\AD\LOGS\TempOutput.log"
	$file = gci "\\sdofs1-08e\is$\Continuity\Celaya\AD\LOGS\TempOutput.log"
	#Rename-Item -Path "I:\Continuity\Celaya\AD\LOGS\TempOutput.log" -NewName "I:\Continuity\Celaya\AD\LOGS\TempOutput.$(get-date -f 'yyyyMMdd').log"
	#gc $file | Out-File "I:\Continuity\Celaya\AD\LOGS\TempOutput.$(get-date -f 'yyyyMMdd-hhmmss').log"
	gc $file | Out-File "\\sdofs1-08e\is$\Continuity\Celaya\AD\LOGS\TempOutput.$(get-date -f 'yyyyMMdd-hhmmss').log"

@"
$(get-date -f 'yyyy-MM-dd HH:mm:ss')
$($file.Name)
`"$($file.FullName)`"

"@ | Out-File -FilePath $file #"I:\Continuity\Celaya\AD\LOGS\TempOutput.log"

}#end Function Replace-TempOutput
