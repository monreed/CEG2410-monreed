# Lab 03 - Active Directory ✧
Monica Reed reed.334@wright.edu

### Contents ❀ུ۪
#### [Part 1](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/README.md#setup-ad-domain-controller-) - Setup AD DC
- [i.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#configuring-a-windows-server-to-be-a-domain-controller-) - Configure DC
#### [Part 2](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/README.md#ad-structure-) - AD Structure
- [i.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#create-organizational-units-extra-credit-) - Create OU
- [ii.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#joining-users-extra-credit-) - Join Users
- [iii.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#joining-computers) - Join Computers
- [iv.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#creating-groups---format-group--folder-location) - Create Groups
#### [Part 3](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#ous-and-gpos-) - OUs & GPOs
- [i.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#applying-group-policies-extra-credit-) - Apply GPO
- [ii.](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab03/README.md#managing-ous) - Manage OUs

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
- Create [bulk-ous.ps1](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/Files/bulk-ous.ps1)

- Create [ous.csv](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/Files/ous.csv)

- Run script `bulk-ous.ps1` via PowerShell

> ![image](https://user-images.githubusercontent.com/97551273/230520576-3be2c7b8-5a76-475b-a095-dda8d6f9d68e.png)

- Check for success /
> ![image](https://user-images.githubusercontent.com/97551273/230520782-f783289e-9338-4de5-9314-933ba69f5f92.png)

> ![image](https://user-images.githubusercontent.com/97551273/230520971-e66cdee7-5e51-4af8-9d93-a0d243ea4664.png)

### Joining Users `Extra credit ✓`
- Create [bulk-users.ps1](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/Files/bulk-users.ps1)

- Create [users.csv](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab03/Files/users.csv)

  - Check for success /

> ![image](https://user-images.githubusercontent.com/97551273/230656616-60b352bd-e83f-4844-a485-5dfcb4eba61b.png) ![image](https://user-images.githubusercontent.com/97551273/230656381-8038bcd9-3abc-4a86-a08b-b37bdbb8e50e.png) ![image](https://user-images.githubusercontent.com/97551273/230656424-9c9f5926-ded5-46c0-96a1-d898c7caab5c.png) ![image](https://user-images.githubusercontent.com/97551273/230656718-0b3c1afe-6a8d-4f05-9b8c-50bfa623c999.png)

### Joining Computers
- Create new Windows EC2 Instance > Follow previous steps to setup ...

> ![image](https://user-images.githubusercontent.com/97551273/230960428-e4875b82-b81b-4ce3-b8cc-dbc1dab9dc82.png)

> ![image](https://user-images.githubusercontent.com/97551273/230964191-15ed4647-7cb0-4cf5-85db-efe52806268c.png)

- ^ Specifying Domain Controller Private IP as `Preferred DNS server`

> ![image](https://user-images.githubusercontent.com/97551273/230959699-538385dc-9797-4260-a823-eab79c6ede49.png)

- Follow login prompt after specifying domain info ...

> ![image](https://user-images.githubusercontent.com/97551273/230962531-ceb244a6-3d42-4c01-8e28-b32e72a436fe.png)

> ![image](https://user-images.githubusercontent.com/97551273/231560113-e41e8233-1e05-471d-85b5-863a5e17a50b.png)

### Creating Groups - Format `group | folder location`
- I created two new OU's within my domain, `darkroast Groups` and `darkroast Admins`. I wanted to be able to have all of my groups together, with the admin groups in one folder and all the rest in the other. I did this given the fact that various groups will end up containing users from more than one department, so it doesn't make sense to put them into individual department folders.

  - `project_repos_RW` | darkroast Groups
  - `finance_RW` | darkroast Groups
  - `onboarding_R` | darkroast Groups
  - `server_access` | darkroast Groups
  - `dev_eng_admins` | darkroast Admins
  - `hr_finance_admins` | darkroast Admins
  - `remote_workstation` | darkroast Groups

# OUs and GPOs ✼
### Applying Group Policies `Extra credit ✓`
- Lock out Workstations after 15 minutes of inactivity | [Guide](https://serverfault.com/questions/79418/enforcing-lock-screen-after-idle-time-via-gpo)

  - Start > Group Policy Management > ... > darkroast Computers > `RClick` **Workstations** > `Create GPO` named "Lock-Out"

  - `RClick` Policy > Edit > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > `Interactive logon: Machine inactivity limit properties` and set 900 sec (or 15 minute) limit

> ![image](https://user-images.githubusercontent.com/97551273/230989890-e89e716a-408a-4773-baf9-009d60e66089.png)

- After allowing window to sit for 15 minutes without activity ...

> ![image](https://user-images.githubusercontent.com/97551273/231612256-3c896b17-a278-4b17-94d5-7659b3922418.png)

- Prevent execution of programs on computers in Secure OU | [Guide](https://learn.microsoft.com/en-us/windows-server/identity/software-restriction-policies/administer-software-restriction-policies)

  - Start > Group Policy Management > ... > darkroast Computers > `RClick` **Secure** > `Create GPO` named "Software-Restrict"

  -  `RClick` Policy > Edit > User Configuration > Policies > Windows Settings > Security Settings > Software Restriction Policies > `Action : "New Software Restriction Policies"`

- Disable Guest account login to computers in Secure OU | [Guide](https://www.lepide.com/blog/top-10-most-important-group-policy-settings-for-preventing-security-breaches/#:~:text=from%20abusing%20access%3A-,In%20Group%20Policy%20Management%20Editor%20(opened%20for%20a%20custom%20GPO,checkbox%20and%20click%20%E2%80%9CDisabled%E2%80%9D.))

  - Start > Group Policy Management > ... > darkroast Computers > `RClick` **Secure** > `Create GPO` named "Disable-Guest"

  -   `RClick` Policy > Edit > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > `DoubleClick` Accounts: Guest account status > Define as `disabled`

- Allow server_access to sign on to Servers | [Guide](https://woshub.com/restrict-workstation-logon-ad-users/)

  -  Start > Group Policy Management > ... > `RClick` darkroast Servers > `Create GPO` named "Server-Allow"

  - `RClick` Policy > Edit > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > `Allow log on locally` > Add group server_access

- Set Desktop background for Conference computers to company logo | [Guide](https://www.techcrafters.com/portal/en/kb/articles/using-group-policy-to-change-desktop-background-wallpaper#How_to_Deploy_the_Desktop_Background_Wallpaper_using_Group_Policy)

  -  Start > Group Policy Management > ... > darkroast Computers > `RClick` **Conference** > `Create GPO` named "Default-Background"

  - `RClick` Policy > Edit > User Configuration > Policies > Administrative Templates > Desktop > Desktop Wallpaper and set

- Allow users in remote_workstation group to RDP to Workstations | [Guide](https://www.trustedtechteam.com/pages/remote-desktop-group-policy-configuration-guide?utm_source=google&utm_medium=cpc&utm_campaign=Gsearch_WSRemote}&utm_term=&cq_plac=&cq_net=g&cq_pos=&cq_med=&cq_plt=gp&gc_id=11809719251&h_ad_id=566026791070&gclid=CjwKCAjwrdmhBhBBEiwA4Hx5g-N3GBSkrd2oWWQp7f__rWqy5FWw-Bki27IjTQE0AcjPMHunH2vMFBoCGUsQAvD_BwE)

  - Start > Group Policy Management > ... > darkroast Computers > `RClick` **Workstations** > `Create GPO` named "Remote-Allow"

  - `RClick` Policy > Edit > Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > `Allow log on through Remote Desktop Services` > Add group remote_workstations

### Managing OUs
- Navigating to darkroast Users > HR ...

> ![image](https://user-images.githubusercontent.com/97551273/231612825-cfea6c41-7d4b-4d6b-a6f1-9f7056c99074.png)

> ![image](https://user-images.githubusercontent.com/97551273/231612855-d5040b94-bbf7-4d5d-a10e-c8905fa20be3.png)

- Delegate control via `RClick` on HR > Delegate Control ...

> ![image](https://user-images.githubusercontent.com/97551273/231613131-7a8993e7-e7e5-465c-a57b-f0f123285b7f.png)

> ![image](https://user-images.githubusercontent.com/97551273/231613321-d578a7b9-5e85-4228-af24-b941bc560a71.png)

- These tasks were granted due to the fact that it is an administrator group and I think that these tasks should at least be able to be carried out by this group (Create new users, reset passwords if needed).

  - Repeat this process for OU - `Finance`.

- Navigating to darkroast Users > Engineers ...

> ![image](https://user-images.githubusercontent.com/97551273/231613749-303668ba-816b-46f3-a45e-d15c22e0fea5.png)

> ![image](https://user-images.githubusercontent.com/97551273/231613868-fbcd4b3f-4142-4b17-a839-d01db77765dc.png)

- Delegate control via `RClick` on Engineers > Delegate Control ...

> ![image](https://user-images.githubusercontent.com/97551273/231613942-51a3b6c4-8be7-45b0-8d15-f62220b6b05b.png)

> ![image](https://user-images.githubusercontent.com/97551273/231613961-1dec3d9e-c239-4c55-a8b1-b191d728940d.png)

- These tasks were granted due to the fact that it is an administrator group and I think that these tasks should at least be able to be carried out by this group (Create new users, reset passwords if needed).

  - Repeat this process for OU - `Developers`.
