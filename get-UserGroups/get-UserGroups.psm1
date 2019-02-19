
<#
Remove-Module Get-UserGroups
Import-Module Get-UserGroups
#>

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
			
            $colGroups = @()
            foreach($group in ($UPN.MemberOf)){
				if($group -like '*DC=STUDENTS*'){
                    $g = get-adgroup $group -Properties * -Server STUDENTS
                    $IsStudents = $true
                }
                elseif($group -notlike '*DC=STUDENTS*'){
                    $g = get-adgroup $group -Properties *
                    $IsStudents = $false
                }

				$objGroup = [PSCustomObject]@{
					#SamAccountName = $UPN.SamAccountName
					#GivenName = $UPN.Givenname
					#Surname = $UPN.Surname
					Group = $g.Name
					CN = $g.CN
					sAMAccountName = $(Switch ($IsStudents){{$_ -eq $true}{$("{0}.STUDENTS" -f $g.sAMAccountName)};{$_ -eq $false}{$($g.sAMAccountName)}})
					DisplayName = $g.DisplayName
					Description = $g.Description
					GroupCategory = $g.GroupCategory
					GroupScope = $g.GroupScope
					Info = $g.Info
					CanonicalName = $g.CanonicalName
					DistinguishedName = $g.DistinguishedName
					Mail = $g.Mail
					ProxyAddresses = [string]::join($($g.ProxyAddresses | ?{($_ -like "smtp:*") -and ($_ -notlike $g.Mail)}),"`r")
				} #end [PSCustomObject]
				$colGroups += $objGroup
                $IsStudents = $Null
			}
			#$groups = $groups | sort
			
            foreach($group in $groups){
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