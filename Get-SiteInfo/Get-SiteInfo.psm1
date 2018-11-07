Function get-SiteInfo{
    [CmdletBinding()]
    Param(
        [Parameter(
            ParameterSetName="main",
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position=0
        )]
        [string]$Site,
        [Parameter(ParameterSetName="help",Mandatory=$false)]
        [switch]$help
    ) #end Param()
    Begin{
        Switch($help){
            $true{
                @{
                    "District Office" = "DO"
                    "DO North" = @("DN","HC")
                    "Clovis College" = @("CCC","CC")
                    "Fresno City College" = @("FCC","FC")
                    "Career Technical College" = "CTC"
                    "Reedley College" = "RC"
                    "Madera Center" = "MC"
                    "Oakhurst Center" = "OC"
                } | ft -AutoSize
                $Site = $(Read-Host -Prompt "Site?" )
                #get-SiteInfo -Site $Site
            }
            Default{}
        }

        <#
        @(
             "DO"
            ,"HC"
            ,"(DN)"
            ,"CCC"
            ,"(CC)"
            ,"FCC"
            ,"(FC)"
            ,"CTC"
            ,"MC"
            ,"OC"
            ,"RC"
         )
         #>

    }#end Begin{}

	Process{
		Switch -Wildcard ($site){
				"RC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Reedley College"
					$MyReturn.StreetAddress = "995 North Reed Ave."
					$MyReturn.City = "Reedley"
					$MyReturn.PostalCode = "93654"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.reedleycollege.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=RC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "reedleycollege.edu"
                    $MyReturn.Site = $_
					} # RC
				"DO"{
                    $MyReturn = @{}
					$MyReturn.Company = "State Center Community College District"
					$MyReturn.StreetAddress = "1525 E. Weldon Ave."
					$MyReturn.City = "Fresno"
					$MyReturn.PostalCode = "93704-6398"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.scccd.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=DO,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "scccd.edu"
                    $MyReturn.Site = $_
					} # DO
				"FCC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Fresno City College"
					$MyReturn.StreetAddress = "1101 E. University Ave."
					$MyReturn.City = "Fresno"
					$MyReturn.PostalCode = "93741"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.fresnocitycollege.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=FC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "fresnocitycollege.edu"
                    $MyReturn.Site = $_
					} # FCC
				"FC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Fresno City College"
					$MyReturn.StreetAddress = "1101 E. University Ave."
					$MyReturn.City = "Fresno"
					$MyReturn.PostalCode = "93741"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.fresnocitycollege.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=FC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "fresnocitycollege.edu"
                    $MyReturn.Site = $_
					} # FC
				"CCC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Clovis College"
					$MyReturn.StreetAddress = "10309 N. Willow Ave."
					$MyReturn.City = "Clovis"
					$MyReturn.PostalCode = "93730"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.cloviscollege.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=CCC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "cloviscollege.edu"
                    $MyReturn.Site = $_
					} # CCC
				"CC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Clovis College"
					$MyReturn.StreetAddress = "10309 N. Willow Ave."
					$MyReturn.City = "Clovis"
					$MyReturn.PostalCode = "93730"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.cloviscollege.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=CCC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "cloviscollege.edu"
                    $MyReturn.Site = $_
					} # CC
				"CTC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Fresno City College"
					$MyReturn.StreetAddress = "2930 E. Annadale Ave."
					$MyReturn.City = "Fresno"
					$MyReturn.PostalCode = "93725"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.fresnocitycollege.edu/"
					$MyReturn.OU = "OU=New Accounts,OU=FC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "fresnocitycollege.edu"
                    $MyReturn.Site = $_
					} # CTC
				"MC"{
                    $MyReturn = @{}
					$MyReturn.Company = "Madera Community College Ctr"
					$MyReturn.StreetAddress = "30277 Avenue 12"
					$MyReturn.City = "Madera"
					$MyReturn.PostalCode = "93637"
					$MyReturn.State = "CA"
					$MyReturn.Country = "US"
					$MyReturn.Co = "UNITED STATES"
					$MyReturn.CountryCode = "840"
					$MyReturn.HomePage = "http://www.maderacenter.com/"
					$MyReturn.OU = "OU=New Accounts,OU=MC,OU=NC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "scccd.edu"
                    $MyReturn.Site = $_
					} # MC
                "OC"{
                    $MyReturn = @{}
                    $MyReturn.Company = "Oakhurst Community College Ctr"
                    $MyReturn.StreetAddress = "40241 Hwy 41"
                    $MyReturn.City = "Oakhurst"
                    $MyReturn.PostalCode = "93644"
                    $MyReturn.State = "CA"
                    $MyReturn.Country = "US"
                    $MyReturn.Co = "UNITED STATES"
                    $MyReturn.CountryCode = "840"
                    $MyReturn.HomePage = "http://http://www.oakhurstcenter.com/"
                    $MyReturn.OU = "OU=New Accounts,OU=OC,OU=NC,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "scccd.edu"
                    $MyReturn.Site = $_
                } # OC
                "HC"{
                    $MyReturn = @{}
                    $MyReturn.Company = "State Center Community College District"
                    $MyReturn.StreetAddress = "390 West Fir Ave"
                    $MyReturn.City = "Clovis"
                    $MyReturn.PostalCode = "93611"
                    $MyReturn.State = "CA"
                    $MyReturn.Country = "US"
                    $MyReturn.Co = "UNITED STATES"
                    $MyReturn.CountryCode = "840"
                    $MyReturn.HomePage = "http://http://www.scccd.edu/"
                    $MyReturn.OU = "OU=New Accounts,OU=Clovis Center DO North,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "scccd.edu"
                    $MyReturn.Site = $_
                } # HC
                "DN"{
                    $MyReturn = @{}
                    $MyReturn.Company = "State Center Community College District"
                    $MyReturn.StreetAddress = "390 West Fir Ave"
                    $MyReturn.City = "Clovis"
                    $MyReturn.PostalCode = "93611"
                    $MyReturn.State = "CA"
                    $MyReturn.Country = "US"
                    $MyReturn.Co = "UNITED STATES"
                    $MyReturn.CountryCode = "840"
                    $MyReturn.HomePage = "http://http://www.scccd.edu/"
                    $MyReturn.OU = "OU=New Accounts,OU=Clovis Center DO North,DC=SCCCD,DC=NET"
                    $MyReturn.Domain = "scccd.edu"
                    $MyReturn.Site = $_
                } # DN
        } # Switch
	    $MyReturn.Site = $MyReturn.Site.ToUpper()
		Return $MyReturn
	}#end Process{}
} #end Function get-SiteInfo{}

<#

Remove-Module Get-SiteInfo
Import-Module Get-SiteInfo

#>
