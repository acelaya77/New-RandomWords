#2019-05-30

Function Update-SCCCDTitle{
 [CmdletBinding()]

Param(
 [Parameter(Mandatory=$true)]$sAMAccountName
,[Parameter(Mandatory=$true)]$EmployeeID
)

Begin{
    $properties = @(
         'sAMAccountName'
        ,'Givenname'
        ,'Surname'
        ,'Title'
        ,'Department'
        ,'Company'
        ,'EmployeeType'
        ,'EMployeeID'
        ,'ExtensionAttribute1'
    )
}

Process{
    $(try{get-aduser $sAMAccountName -ErrorAction Stop | Out-Null;[bool]$isAvailable = $true}catch{"AD Account doesn't exists";[bool]$isAvailable = $false})
    
    if(!$isAvailable){
        $user = Get-ADUser $sAMAccountName -Properties $properties
        Get-SQLWebAdvisorID -EmployeeIDs "`'$($user.EmployeeID)`'" -both

        $csvInput = Import-Csv -Delimiter "," "I:\Continuity\Celaya\AD\New-AD-Account-Template-v2.csv"

        if($csvInput.EMPLOYEEID -eq $EmployeeID){
            #$site = get-SiteInfo $csvInput.SITE
            $user | Set-ADUser -Title $csvInput.TITLE -Department $csvInput.DEPARTMENT 
        }
    }
    else{
        Write-Verbose "Username doesn't exist in SCCCD"
    }


}

End{}
}

<#

Remove-Module Update-SCCCDTitle
Import-Module Update-SCCCDTitle

#>
