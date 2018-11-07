Function Get-StudentInfo{
    [CmdletBinding()]
    Param(
        $Id,
        $Givenname,
        $surname
    )#end Param()

    Get-ADUser $id -Server "STUDENTS.SCCCD.NET" -Properties * | Select DistinguishedName,Enabled,Givenname,Name,ObjectClass,ObjectGUID,SamAccountName,SID,Surname,ExtensionAttribute1,Mail,ProxyAddresses | fl

}#end Function Get-StudentInfo{}