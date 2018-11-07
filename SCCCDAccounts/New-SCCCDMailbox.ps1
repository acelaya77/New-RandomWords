Function New-SCCCDMailbox{
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$false)]
		[Switch]$whatif
	)


	$textInfo = (get-culture).TextInfo
	$inputFileSQL = $(Resolve-Path "$(Join-Path $env:USERPROFILE "TrackIt-Export")\NewMailboxes.csv")
    $inputFileTrackIt = $(Resolve-Path "$(Join-Path $env:USERPROFILE "TrackIt-Export")\Create-Me.csv")
	$mailboxes = Import-Csv $inputFileSQL

	#$mailboxes | Format-Table -A
	foreach($m in $mailboxes){
        
        $tmpBox = Import-Csv $inputFileTrackIt | Where-Object {$_.EmployeeID -eq $m.EmployeeID}

		$type = $m.EmployeeType
		if($type -like "" -or $type -eq $null){
			$type = 'Classified'
		}
        If($type -like "Student"){
            $type = 'Student'

        }
		
        Switch($type){
            {$_ -eq 'Student'}{
                $alias = "$($m.Givenname.substring(0,1).ToLower())$($m.Surname.substring(0,1).toLower())$($m.EmployeeID)"
            }
            Default{
                $alias = Get-AvailableSamAccountName "$($m.Givenname.substring(0,1).ToLower())$($m.Surname.substring(0,1).toLower())"
            }
        }
        
		$pass = New-RandomPassword -length 8
		$site = $(if($m.site -ne ""){
                    get-SiteInfo -Site:$($m.Site)
                }elseif($tmpBox.Site -ne ""){
                    get-SiteInfo -Site $tmpBox.Site
                }else{
                    get-SiteInfo -Site 'DO'
                })
		$database = Get-ExchangeDatabase -Site $site.site -EmployeeType $type
		$name = "$($m.Givenname) $($m.surname)"
		$primarySMTPAddress = "$($m.givenname.replace(' ','-').tolower()).$($m.surname.replace(' ','-').toLower())@$($site.Domain.replace("@",''))"
		try{
			$tmpMail = get-mailbox "$primarySMTPAddress" -ErrorAction SilentlyContinue -Verbose:$false
		}catch{}

		if($tmpMail.PrimarySMTPAddress.IsValidAddress){
			$primarySMTPAddress = "$($m.givenname.replace(' ','-').tolower()).$($m.surname.replace(' ','-').toLower()).2@$($site.Domain.replace("@",''))"
		}

		$splat = @{
			OrganizationalUnit = $site.OU
			Name = $name
			DisplayName = $name
			Alias = $alias
			UserPrincipalName = "$($alias)@SCCCD.NET"
			SamAccountName = $alias
			FirstName = $textInfo.ToTitleCase($m.Givenname.ToLower())
			LastName = $textInfo.ToTitleCase($m.Surname.ToLower())
			Password = $pass.Secure
			ResetPasswordOnNextLogon = $false
			Database = $database
			ActiveSyncMailboxPolicy = 'Default'
			PrimarySMTPAddress = $primarySMTPAddress
		}
        $buffer = $splat.psobject.copy()
        if($PSBoundParameters.ContainsKey('Verbose')){
            #$buffer = $null
            #$buffer = $splat
            $buffer.Password = $pass.text
            Write-Verbose $($buffer | ft | Out-String)
        }

		New-Mailbox @splat -WhatIf:$whatif -Verbose:$false

		$logFile = $(Join-Path $(Join-Path $env:USERPROFILE "TrackIt-Export") "NewMailbox-$($m.EmployeeID)-$($splat.alias)-$($primarySMTPAddress.Split("@")[0]).log")
		if (!$(Test-Path $logFile)) {
			new-Item -ItemType File -path $(Split-Path $logFile -Parent) -name $(SPlit-Path $logFile -Leaf)
		}

		$stream = [System.IO.StreamWriter]::new($logFile,1)
		Try{
			$date = Get-Date
			#$date.ToString('MM-dd-yyyy hh:mm:ss') | Out-String | ForEach-Object{
            $date.ToString('MM-dd-yyyy hh:mm:ss') | ForEach-Object{
				$stream.WriteLine($_)
			}
            $buffer = $splat.psobject.Copy()
            $buffer.Password = $pass.text
			#$splat | Out-String -Stream | ForEach-Object{
            $buffer | Out-String | ForEach-Object{
				$stream.WriteLine($_.Trim())
			}
			<#
            $pass.Text.toString() | Out-String | ForEach-Object{
				$stream.WriteLine($_)
			}
            
			"==============" | Out-String | ForEach-Object{
				$stream.WriteLine($_)
			}
            #>
		}
		finally{
			$stream.Close()
			np++ $logFile
		}

		if($PSBoundParameters.ContainsKey('whatif')){
            <#
            Do{
                $user = Get-ADUser -Filter {sAMAccountname -eq "$($splat.Alias)"} -Properties EmployeeID,ExtensionAttribute1 -ErrorAction SilentlyContinue
                if($user.UserPrincipalName -ne $Null){
                    $user.EmployeeID = $m.EmployeeID
                    $user.ExtensionAttribute1 = $m.ExtensionAttribute1
                    Set-ADUser -Instance $user
                }
            }
            Until($user.EmployeeID -ne '')
            #>
		}
        Else{
#=======
			do {
                if(gv -Name user -ErrorAction SilentlyContinue){rv -Name user -Force -ErrorAction SilentlyContinue}
                $strSamAccountName = "$($splat.Alias)"
				do{
                    $user = Get-ADUser -Filter {sAMAccountName -eq $strSamAccountName} -Properties EmployeeID, ExtensionAttribute1 -ErrorAction SilentlyContinue
				    if ($user.UserPrincipalName -ne $null) {
					    $user.EmployeeID = $m.EmployeeID
					    $user.ExtensionAttribute1 = $m.ExtensionAttribute1
					    Set-ADUser -Instance $user
                        
                        $strDescription = "$($site.Site) - $($m.Department) - $($m.EmployeeType.Substring(0,1).ToUpper())"
                        Update-ADUser -sAMAccountName $strSamAccountName -Site $m.Site -Title $m.Title -Department $m.Department -Description $strDescription
				    }
                }
                Until($user.EmployeeID -ne $null)
                Write-Verbose "trying again"
			}Until($user.sAMAccountName -ne '')
            
            #$createMeFile = Resolve-Path $(Join-Path $(Split-Path -Parent $inputFileTrackIt) "Create-Me.csv")
            $createMeFile = Resolve-Path $(Join-Path $(Split-Path -Parent $inputFileTrackIt) "newMailboxes.csv")
            $tmpData = Import-Csv $createMeFile
		    $tmpOutput = $tmpData | Where-Object {$_.EmployeeID -ne $m.EmployeeID}
            #if($tmpOutput.count -gt 0){
            if(($tmpOutput | ConvertTo-Csv).Count -gt 0){
                $tmpData | Export-Csv $createMeFile -NoTypeInformation
            }
            else{
                '"ID","Status","Summary","EmployeeName","EmployeeID","Site","EmployeeType","Requestor","AssignedTech","DateEntered","ExistsInAD"' | Out-File $createMeFile
            }

#=======
        }
	}

}

Function Get-ExchangeDatabase {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		[ValidateSet("FCC", "FC", "CCC", "CC", "RC", "MC", "DO", "CTC", "OC", "HC")]
		[string]$Site,

		[Parameter(Mandatory = $true)]
		[ValidateSet(
			"Adjunct"
			, "Faculty"
			, "Classified"
			, "Management"
			, "Student"
			, "Provisional")]
		[string]$EmployeeType
	)

	Switch -Wildcard ($Site) {
		"DO" {$ExchangeDB = "DB_DO"}
		"DN" {$ExchangeDB = "DB_DO"}
		"HC" {$ExchangeDB = "DB_DO"}
		"RC" {$ExchangeDB = "DB_RC"}
		"CC*" {$ExchangeDB = "DB_CC"}
		"MC" {$ExchangeDB = "DB_MC"}
		"OC" {$ExchangeDB = "DB_RC"}
		"CTC" {
			Switch -Wildcard ($EmployeeType) {
				"Adjunct" {$ExchangeDB = "DB_FC_ADJ"}
				"Faculty" {$ExchangeDB = "DB_FC_FAC"}
				"Classified" {$ExchangeDB = "DB_FC_STAFF"}
				"Management" {$ExchangeDB = "DB_FC_STAFF"}
				"Student" {$ExchangeDB = "DB_FC_STAFF"}
				"Provisional" {$ExchangeDB = "DB_FC_STAFF"}
				Default {$ExchangeDB = "DB_FC_STAFF"}
			}#end Switch{}
		}#end CTC
		"FC*" {
			Switch -Wildcard ($EmployeeType) {
				"Adjunct" {$ExchangeDB = "DB_FC_ADJ"}
				"Faculty" {$ExchangeDB = "DB_FC_FAC"}
				"Classified" {$ExchangeDB = "DB_FC_STAFF"}
				"Management" {$ExchangeDB = "DB_FC_STAFF"}
				"Student" {$ExchangeDB = "DB_FC_STAFF"}
				"Provisional" {$ExchangeDB = "DB_FC_STAFF"}
				Default {$ExchangeDB = "DB_FC_STAFF"}
			}#end Switch{}
		}#end FC
		Default {$ExchangeDB = "DB_DO"}
	}#end Switch{}

	Return $ExchangeDB

}#</Get-ExchangeDatabase{}>
