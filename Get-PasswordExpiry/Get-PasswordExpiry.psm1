function Get-PasswordExpiry ($user){
<#
.SYNOPSIS
Use to get information about a target user.
.DESCRIPTION
Lists the users user ID to check you have the right user. Also lists whether the password is expired right now (Boolean value), when the password was last set, and if the password is set to never expire (Boolean Value). Password expiry date is not a retrievable
value from Active Directory. Requires the NAME of the user, in speech marks.
.EXAMPLE
get-passexpiry "ann onymous"
#>
	write-host "Connecting to Active Directory."
	$maxPasswordAge = (get-addefaultdomainpasswordpolicy).MaxPasswordAge.Days
	try{
		#$usercheck = get-aduser -Filter {name -eq $user}
        $usercheck = get-aduser -LDAPFilter "(anr=$user)"
		if($usercheck -eq $null){
			write-warning -message "Specified user does not exist."
		}#end if($usercheck -eq $null){}
		else{
			#$objReturn = get-aduser -filter {name -eq $user} -properties Passwordexpired,passwordlastset,passwordneverexpires | select samaccountname,Passwordexpired,passwordlastset,passwordneverexpires,@{l="ExpiryDate";e={$_.PasswordLastSet.AddDays($maxPasswordAge)}} | format-list
            #get-aduser -filter {name -eq $user} -properties Passwordexpired,passwordlastset,passwordneverexpires | select samaccountname,Passwordexpired,passwordlastset,passwordneverexpires,@{l="ExpiryDate";e={$_.PasswordLastSet.AddDays($maxPasswordAge)}} | format-list
            get-aduser -LDAPFilter "(anr=$user)" -properties Passwordexpired,passwordlastset,passwordneverexpires | select samaccountname,Passwordexpired,passwordlastset,passwordneverexpires,@{l="ExpiryDate";e={$_.PasswordLastSet.AddDays($maxPasswordAge)}} | format-list
		}#end else{}
	}#end Try{}
	catch{
		$errormessage = $_.exception.message
		if ($errormessage -like '*is not defined*') {write-warning "D'oh. You forgot to specify a user."}
	}#end Catch{}
	
	#Return $objReturn
}#end Function get-PasswordExpiry($user)