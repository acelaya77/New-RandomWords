
#region :: Header
<#

NAME        : Test-MissingAttributes.ps1
AUTHOR      : Anthony J. Celaya
DESCRIPTION : Test for missing attributes for new account splat prior to running New-ADUser.
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

Function Test-MissingAttributes{
    [flags()]
    Enum AttrBitFlags{
        Enabled           = 1
        Name              = 2
        EmployeeID        = 4
        Givenname         = 8
        Country           = 16
        State             = 32
        OtherAttributes   = 64
        HomePage          = 128
        PostalCode        = 256
        StreetAddress     = 512
        AccountPassword   = 1024
        Company           = 2048
        Whatif            = 4096
        Description       = 8192
        Surname           = 16384
        DisplayName       = 32768
        Path              = 65536
        Title             = 131072
        sAMAccountName    = 262144
        Department        = 524288
        City              = 1048576
        UserPrincipalName = 2097152
    }
    #[AttrBitFlags]$flags = $null
    $flags = [AttrBitFlags]::new()
    foreach($arg in $args){
        foreach($item in $arg.GetEnumerator()){
            #$item.Key
            #[AttributeBitFlags]::$($item.key)
            Switch($item){
                {$null -eq $($_.Value)}{
                    #Write-Output $("`$null {0}" -f $($_.Key))
                }
                {$($_.Value) -notlike "*"}{
                    #Write-Output $("`"*`" {0}" -f $($_.Key))
                }
                Default{
                    #Write-Output $("Adding flag for: {0}" -f $_.Key)
                    if($flags -eq 0){
                        #Write-Output $("Overwriting `$flags: {0}" -f $_.Key)
                        $flags = [AttrBitFlags]::$($_.Key)
                    }
                    else{
                        $flags += [AttrBitFlags]::$($_.Key)
                    }
                }
            }
        }
    }
    #Return $flags.value__
    $missingFlags = @()
    Switch($flags){
        {($flags -bor       1) -ne $flags}{$missingFlags += "Enabled"          }
        {($flags -bor       2) -ne $flags}{$missingFlags += "Name"             }
        {($flags -bor       4) -ne $flags}{$missingFlags += "EmployeeID"       }
        {($flags -bor       8) -ne $flags}{$missingFlags += "Givenname"        }
        {($flags -bor      16) -ne $flags}{$missingFlags += "Country"          }
        {($flags -bor      32) -ne $flags}{$missingFlags += "State"            }
        {($flags -bor      64) -ne $flags}{$missingFlags += "OtherAttributes"  }
        {($flags -bor     128) -ne $flags}{$missingFlags += "HomePage"         }
        {($flags -bor     256) -ne $flags}{$missingFlags += "PostalCode"       }
        {($flags -bor     512) -ne $flags}{$missingFlags += "StreetAddress"    }
        {($flags -bor    1024) -ne $flags}{$missingFlags += "AccountPassword"  }
        {($flags -bor    2048) -ne $flags}{$missingFlags += "Company"          }
        {($flags -bor    4096) -ne $flags}{$missingFlags += "Whatif"           }
        {($flags -bor    8192) -ne $flags}{$missingFlags += "Description"      }
        {($flags -bor   16384) -ne $flags}{$missingFlags += "Surname"          }
        {($flags -bor   32768) -ne $flags}{$missingFlags += "DisplayName"      }
        {($flags -bor   65536) -ne $flags}{$missingFlags += "Path"             }
        #{($flags -bor  131072) -ne $flags}{$missingFlags += "Title"            }
        {($flags -bor  262144) -ne $flags}{$missingFlags += "sAMAccountName"   }
        {($flags -bor  524288) -ne $flags}{$missingFlags += "Department"       }
        {($flags -bor 1048576) -ne $flags}{$missingFlags += "City"             }
        {($flags -bor 2097152) -ne $flags}{$missingFlags += "UserPrincipalName"}
    }
    if($missingFlags.count -gt 0){
        Return $missingFlags
    }elseif($missingFlags.count -eq 0){
        $missingFlags = "None"
        Return $missingFlags
    }
}

