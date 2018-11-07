function Get-AttributeLength{
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true)]$Attribute
	)
	
	$temp = dsquery * "cn=Schema,cn=Configuration,dc=scccd,dc=net" -filter "(LDAPDisplayName=$Attribute)" -attr rangeUpper -l
	
	Return $temp

}

<#
Try{Remove-Module Get-AttributeLength}
Finally{Import-Module Get-AttributeLength}
#>

