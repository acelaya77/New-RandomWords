# new-randomwords

Used to generate temporary AD password.

The returned object contains three parts, one that can be passed directly as a secure string, one that can be used for the plain text, and one containing the Password Pusher URL to send to user.



[Example]
```
new-passphrase

             AccountPassword PlainPassword        Url
             --------------- -------------        ---
System.Security.SecureString Art-220-uphill-xbox. https://pwpush.com/p/oz6kosu_wjymiykj
```

[Example]
```
$passwords = @(1..5).foreach({ new-passphrase })

             AccountPassword PlainPassword            Url
             --------------- -------------            ---
System.Security.SecureString Owl dagger nanny 908?    https://pwpush.com/p/0-lnayw6lqpshg
System.Security.SecureString Chimp_214_from_chomp!    https://pwpush.com/p/qztnnxefyvdtr5qikg
System.Security.SecureString Think clutch 10 elf!     https://pwpush.com/p/ra-4vea99g__
System.Security.SecureString Thrash delay nape 318.   https://pwpush.com/p/vajb8seh98g
System.Security.SecureString Bovine-quirk-deduct-382. https://pwpush.com/p/fbu6grhq8bfge0issg

$passwords[0]

             AccountPassword PlainPassword         Url
             --------------- -------------         ---
System.Security.SecureString Owl dagger nanny 908? https://pwpush.com/p/0-lnayw6lqpshg
```
