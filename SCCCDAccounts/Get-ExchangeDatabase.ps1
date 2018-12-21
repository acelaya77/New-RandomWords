
#region :: Header
<#

NAME        : Get-ExchangeDatabase.ps1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : 
MODULES     : 
GLOBAL VARS : 
LAST RAN    : 
UPDATED     : 12-13-2018
VERSION     : 1.0



Ver EntryDate  Editor Description    
--- ---------  ------ -----------    
1.0 11-08-2017 ac007  INITIAL RELEASE

#>
#endregion

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
            , "Confidential"
            , "Administrator"
            , "Management"
            , "Limited Term"
            , "Non-Bargaining"
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
                "Confidential" {$EexchangeDB = "DB_FC_STAFF"}
                "Classified" {$ExchangeDB = "DB_FC_STAFF"}
                "Non-Bargaining" {$ExchangeDB = "DB_FC_STAFF"}
                "Limited Term" {$ExchangeDB = "DB_FC_STAFF"}
                "Administrator"{$ExchangeDB = "DB_FC_STAFF"}
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
                "Confidential" {$ExchangeDB = "DB_FC_STAFF"}
                "Non-Bargaining" {$ExchangeDB = "DB_FC_STAFF"}
                "Limited Term" {$ExchangeDB = "DB_FC_STAFF"}
                "Administrator" {$ExchangeDB = "DB_FC_STAFF"}
                "Management" {$ExchangeDB = "DB_FC_STAFF"}
                "Student" {$ExchangeDB = "DB_FC_STAFF"}
                "Provisional" {$ExchangeDB = "DB_FC_STAFF"}
                Default {$ExchangeDB = "DB_FC_STAFF"}
            }#end Switch{}
        }#end FC
        Default {$ExchangeDB = "DB_DO"}
    }#end Switch{}

    Return $ExchangeDB

}

