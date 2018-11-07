Function Get-UserGroups{
	#[CmdletBinding()]
	Param(
	[Parameter(Mandatory=$true,ValueFromPipeline=$true)]
	[string[]]$users,
	[switch]$FileOutput,
    [switch]$Collection
	)
	Begin{} # end Begin{}

	Process{
		foreach($usr in $users){
			$UPN = get-aduser $usr -Properties MemberOf
			$groups = foreach($group in ($UPN.MemberOf)){
				get-adgroup $group -Properties *
			}
			$groups = $groups | sort
			$colGroups = @()
            foreach($group in $groups){
				$objGroup = [PSCustomObject]@{
					#SamAccountName = $UPN.SamAccountName
					#GivenName = $UPN.Givenname
					#Surname = $UPN.Surname
					Group = $group.Name
					CN = $group.CN
					sAMAccountName = $group.sAMAccountName
					DisplayName = $group.DisplayName
					Description = $group.Description
					GroupCategory = $group.GroupCategory
					GroupScope = $group.GroupScope
					Info = $group.Info
					CanonicalName = $group.CanonicalName
					DistinguishedName = $group.DistinguishedName
					Mail = $group.Mail
					ProxyAddresses = [string]::join($($group.ProxyAddresses | ?{($_ -like "smtp:*") -and ($_ -notlike $group.Mail)}),"`r")
				} #end [PSCustomObject]
				$colGroups += $objGroup
			} #end foreach($group in $groups){}
			switch ($FileOutput){
				$true{
					$file = "I:\Continuity\Celaya\AD\Security Group Logs\$($UPN.SamAccountName)-$(get-date -f yyyyMMdd-hhmmss).txt"
					"AD Security Group Log for $($UPN.Name) ($($UPN.SamAccountName)) as of $(get-date -f 'yyyy/MM/dd hh:mm:ss')" | Out-File -FilePath $file
					$colGroups | select Group | Out-File -FilePath $file -Append
				} #end Case{$true}
				$false{<#
					foreach($u in $users){
						 $outputGroup | ?{$_.SamAccountName -eq "$u"} | ft -AutoSize
					} #end Foreach($u in $users){}
					#>
				} #end Case{$false}
			} #end switch($fileOutput){}
		} #end foreach($usr in $users){}
	<#
	if($Collection){
		Return $colGroups
	}
	Else{
		Return $($colGroups.sAMAccountName) | sort | ft -AutoSize
	}
	#>



	Return $colGroups.samAccountName
	} #end Process{}

	End{} #end End{}
	
} #end Function Get-UserGroups{}