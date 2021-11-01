# new-randomwords

Used to generate temporary AD password.

The returned object contains two parts, one that can be passed directly as a secure string, and one that can be used for the plain text to secure and send.



[Example]
```
new-randomwords

             AccountPassword PlainPassword
             --------------- -------------
System.Security.SecureString Mommas cargo 409 rostra!
```

[Example]
```
$passwords = @(1..5).foreach({ new-randomwords })

             AccountPassword PlainPassword
             --------------- -------------
System.Security.SecureString Husker_augurs_144_girts.
System.Security.SecureString Knots_crud_847_sodas?
System.Security.SecureString Momma_schwa_65_claim?
System.Security.SecureString Stalks_tones_331_screw.
System.Security.SecureString Cotes califs 524 permit.

$passwords[0]

             AccountPassword PlainPassword
             --------------- -------------
System.Security.SecureString Husker_augurs_144_girts.
```
