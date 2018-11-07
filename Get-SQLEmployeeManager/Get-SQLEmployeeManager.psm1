Function Get-SQLEmployeeManager{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$false)][string]$strServer = 'SDODW1'
        ,[Parameter(Mandatory=$false)][string]$strDatabase = 'ODS_HR'
        ,[Parameter(Mandatory=$true) ][String]$EmployeeID
    )

Begin{
    $strQuery = @"
--USE ODS_HR

DECLARE @EmpID VARCHAR(7)
SET @EmpID = $("`'{0}`'" -f $EmployeeID)

DECLARE @Super_ID VARCHAR(7)
SET @Super_ID = (
		SELECT TOP 1 PERPOS_SUPERVISOR_HRP_ID
		FROM [ODS_HR].[dbo].[S85_PERPOS]
		WHERE PERPOS_HRP_ID = @EmpID --'0671661'
			AND PERPOS_SUPERVISOR_HRP_ID IS NOT NULL
		)
SELECT   P.FIRST_NAME AS GIVENNAME
		,P.LAST_NAME AS SURNAME
		--,ISNULL(P.PREFERRED_NAME, '') AS PREFERRED_NAME
		,P.ID AS EMPLOYEEID
		--,PP.PERSON_PIN_USER_ID AS EXTENSIONATTRIBUTE1
		,HP.HRP_CHK_NAME
		--,HP.HRP_SSN
		--,FORMAT(GETDATE(), 'yyyy-MM-dd') AS [DATE]
		--,FORMAT(GETDATE(), 'hh:mm:ss') AS [TIME]
FROM ODS_ST.dbo.S85_PERSON_PIN AS PP WITH (NOLOCK)
	LEFT JOIN ODS_ST.dbo.S85_PERSON AS P WITH (NOLOCK) ON PP.PERSON_PIN_ID = P.ID
	LEFT JOIN [ODS_HR].[dbo].[S85_HRPER] AS HP WITH (NOLOCK) ON P.ID = HP.HRPER_ID
WHERE P.ID = @Super_ID

"@    
}

Process{
    #region :: SQL connection settings
    $connectionTemplate = "Trusted_Connection=true;"
    $connectionString =  "server='$strServer';database='$strDatabase';trusted_connection=true;"
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString
    $command = New-Object System.Data.SqlClient.SqlCommand
    $command.CommandText = $strQuery
    $command.Connection = $connection
    #endregion

    #region :: SQL
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $SqlAdapter.SelectCommand = $command
    $DataSet = New-Object System.Data.DataSet
    $SqlAdapter.Fill($DataSet)
    $connection.Close()
    #endregion ::

    if($DataSet.Tables[0].Rows.Count -gt 0){
        if(gv -ErrorAction SilentlyContinue -Name tmpGroup){rv -Force tmpgroup -ErrorAction SilentlyContinue}
        #Write-Verbose $DataSet.Tables[0].Rows.Count
        $thisTable = $DataSet.Tables[0] | Select-Object GIVENNAME,SURNAME,EMPLOYEEID | ConvertTo-Csv -Delimiter "," -nti
        $thisTable = $thisTable | ConvertFrom-Csv

        #$thisTable | ft -AutoSize
        $strManagerID = $thisTable.EMPLOYEEID #.ToString()
        $hash = @{
            Properties = @(
	             'CanonicalName'
	            ,'Company'
	            ,'Department'
	            ,'Description'
	            ,'DisplayName'
	            ,'DistinguishedName'
	            ,'Division'
	            ,'EmailAddress'
	            ,'EmployeeID'
	            ,'EmployeeNumber'
	            ,'GivenName'
	            ,'ipPhone'
	            ,'l'
	            ,'mail'
	            ,'mailNickname'
	            ,'msDS-User-Account-Control-Computed'
	            ,'Name'
	            ,'OfficePhone'
	            ,'PostalCode'
	            ,'proxyAddresses'
	            ,'SamAccountName'
	            ,'SID'
	            ,'sn'
	            ,'State'
	            ,'StreetAddress'
	            ,'Surname'
	            ,'telephoneNumber'
	            ,'Title'
	            ,'userAccountControl'
	            ,'UserPrincipalName'
            )
        }
        $manager = Get-ADUser $($Global:ADHash[$strManagerID]) @hash

        Return $manager
    }
}

End{}

}

<#
Remove-Module Get-SQLEmployeeManager
Import-Module Get-SQLEmployeeManager
#>
