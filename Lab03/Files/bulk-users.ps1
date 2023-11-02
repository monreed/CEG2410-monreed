$secpass = Read-Host "Enter Default Password for Accounts" -AsSecureString

Import-Csv C:\Users\Administrator\Documents\users.csv |
foreach {
  $name = "$($_.FirstName) $($_.LastName)"

 New-ADUser -GivenName $($_.FirstName) -Surname $($_.LastName) `
 -Name $name -SamAccountName $($_.SamAccountName) `
 -UserPrincipalName "$($_.SamAccountName)@ad.darkroast.com" `
 -AccountPassword $secpass `
 -Path "ou=$($_.OU2),ou=$($_.OU1),dc=ad,dc=darkroast,dc=com" `        // Line containing EC
 -Enabled:$true

}
