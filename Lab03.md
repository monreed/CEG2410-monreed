# Lab 03 - Active Directory ✧
Monica Reed monrd11@gmail.com

Contents ❀ུ۪
- [Part 1](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/README.md#setup-ad-domain-controller-) - Setup AD DC
- [Part 2](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/README.md#ad-structure-) - AD Structure
- [Part 3]() - OUs & GPOs

# Setup AD Domain Controller ✼
### Configuring a Windows Server to be a Domain Controller /
- Install necessary tools via PowerShell

  - `Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools`

- Edit adapter options

  - Network status > Change adapter options > `RClick` on "Ethernet" -> Properties
  - Internet Protocol Version 4 (TCP/IPv4) > Properties and specify ...

 >![image](https://user-images.githubusercontent.com/97551273/230247893-36853486-1067-4f60-b7e2-d6b99e1c1242.png)

- Change computer name

  - File explorer > `RClick` on "This PC" ...
> ![image](https://user-images.githubusercontent.com/97551273/230482533-8fec9af4-0983-4d3a-80fb-179fedb53271.png)

> ![image](https://user-images.githubusercontent.com/97551273/230482936-6bb0d6a3-1905-4cc3-9fa9-bedb1f0c149d.png)

> ![image](https://user-images.githubusercontent.com/97551273/230483390-1d6609b4-e1c9-4be8-8109-80ed3518c0c3.png)

- Promote server to domain controller

  - Start Menu > Server Manager > Flag icon ...
> ![image](https://user-images.githubusercontent.com/97551273/230512551-3ffffebb-c5ce-454c-8a14-67a3192d881c.png)

> ![image](https://user-images.githubusercontent.com/97551273/230512725-2ce482f6-a709-4994-8b33-470d24c3e0d3.png)

> ![image](https://user-images.githubusercontent.com/97551273/230512755-17482674-8a73-4f3c-9f75-db3dbf80d220.png)

- Finish setup *(mostly left as default)* & `Install` + `Restart`

### Domain Name /
- ad.darkroast.com
### Domain Controller Name /
- DC1
### Domain DNS IP /
- 127.0.0.1

# AD Structure ✼
### Create Organizational Units `Extra credit ✓`
- Create `bulk-ous.ps1` and append ...
```
Import-Csv ous.csv |
foreach {
    New-ADOrganizationalUnit -Name $_.Name -Path $_.Path `
    -ProtectedFromAccidentalDeletion $true -PassThru
}
```
- Create `ous.csv` and append ...
```
Name,Path
darkroast Users,"dc=ad,dc=darkroast,dc=com"
Finance,"OU=darkroast Users,dc=ad,dc=darkroast,dc=com"
HR,"OU=darkroast Users,dc=ad,dc=darkroast,dc=com"
Engineers,"OU=darkroast Users,dc=ad,dc=darkroast,dc=com"
Developers,"OU=darkroast Users,dc=ad,dc=darkroast,dc=com"
darkroast Computers,"dc=ad,dc=darkroast,dc=com"
Conference,"OU=darkroast Computers,dc=ad,dc=darkroast,dc=com"
Secure,"OU=darkroast Computers,dc=ad,dc=darkroast,dc=com"
Workstations,"OU=darkroast Computers,dc=ad,dc=darkroast,dc=com"
darkroast Servers,"dc=ad,dc=darkroast,dc=com"
```
- Run script `bulk-ous.ps1` via PowerShell

> ![image](https://user-images.githubusercontent.com/97551273/230520576-3be2c7b8-5a76-475b-a095-dda8d6f9d68e.png)

- Check for success /
> ![image](https://user-images.githubusercontent.com/97551273/230520782-f783289e-9338-4de5-9314-933ba69f5f92.png)

> ![image](https://user-images.githubusercontent.com/97551273/230520971-e66cdee7-5e51-4af8-9d93-a0d243ea4664.png)

### Joining Users `Extra credit ✓`
- Create `bulk-users.ps1` and append ...
```
$secpass = Read-Host "Enter Default Password for Accounts" -AsSecureString

Import-Csv C:\Users\Administrator\Documents\users.csv |
foreach {
  $name = "$($_.FirstName) $($_.LastName)"

 New-ADUser -GivenName $($_.FirstName) -Surname $($_.LastName) `
 -Name $name -SamAccountName $($_.SamAccountName) `
 -UserPrincipalName "$($_.SamAccountName)@ad.darkroast.com" `
 -AccountPassword $secpass `

                -Path "ou=$($_.OU2),ou=$($_.OU1),dc=ad,dc=darkroast,dc=com" `           // Line containing EC

 -Enabled:$true

}
```
- Create `users.csv` and append ...
```
FirstName,LastName,SamAccountName,OU1,OU2
Sam,Adams,sadams,darkroast Users,Engineers
Bob,Baker,bbaker,darkroast Users,Engineers
John,Clark,jclark,darkroast Users,Engineers
Jim,Davis,jdavis,darkroast Users,Developers
Sue,Evans,sevans,darkroast Users,Developers
Mabel,Frank,mfrank,darkroast Users,Developers
Kylie,Ghosh,kghosh,darkroast Users,Developers
Sammy,Hills,shills,darkroast Users,HR
Steve,Irwin,sirwin,darkroast Users,HR
Jessy,Jones,jjones,darkroast Users,Finance
Kevin,Klein,kklein,darkroast Users,Finance
Max,Lopez,mlopez,darkroast Users,Finance
Sarah,Mason,smason,darkroast Users,Developers
Frank,Nalty,fnalty,darkroast Users,Developers
Izzie,Ochoa,iochoa,darkroast Users,Developers
Kelly,Patel,kpatel,darkroast Users,Engineers
Liz,Quinn,lquinn,darkroast Users,Engineers
Owen,Reily,oreily,darkroast Users,Engineers
Taylor,Trott,ttrott,darkroast Users,Engineers
James,Usman,jusman,darkroast Users,Engineers
Elsie,Smith,esmith,darkroast Users,Engineers
Waldo,Valdo,wvaldo,darkroast Users,Developers
Griffin,White,gwhite,darkroast Users,Developers
```
- Check for success /

> ![image](https://user-images.githubusercontent.com/97551273/230656616-60b352bd-e83f-4844-a485-5dfcb4eba61b.png) ![image](https://user-images.githubusercontent.com/97551273/230656381-8038bcd9-3abc-4a86-a08b-b37bdbb8e50e.png) ![image](https://user-images.githubusercontent.com/97551273/230656424-9c9f5926-ded5-46c0-96a1-d898c7caab5c.png) ![image](https://user-images.githubusercontent.com/97551273/230656718-0b3c1afe-6a8d-4f05-9b8c-50bfa623c999.png)

### Joining Computers
