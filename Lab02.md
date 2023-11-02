# Lab 02 - DIY NAS ✧
Monica Reed monrd11@gmail.com
### Contents ❀ུ۪
* [Part 1](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab02/README.md#part-1---nfs-server-configuration-) - NFS Server Configuration
* [Part 2](https://github.com/WSU-kduncan/ceg2410-projects-monreed/edit/main/Lab02/README.md#part-2---firewall-fixes-) - Firewall Fixes
* [Part 3](https://github.com/WSU-kduncan/ceg2410-projects-monreed/blob/main/Lab02/README.md#part-3---mounting-an-nfs-share-) - Mounting an NFS Share

# Part 1 - NFS Server Configuration ✼
### (1) Create a space
1. Create array

    - `sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sda /dev/sdb`

2. Create filesystem

    - `sudo mkfs.ext4 -F /dev/md0`

---

### (2) Mount the partition & allow others to collaborate

1. Create a mountpoint

   - `sudo mkdir -p /mnt/md0`

2. Mount the filesystem

    - `sudo mount /dev/md0 /mnt/md0`

3. Allow others to add / edit files

    - `sudo chmod 777 /mnt/md0`

---

### (3) Configure /etc/fstab to auto mount the partition to the folder on boot
1. Save array layout

    - `sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf`

2. Update the initramfs

    - `sudo update-initramfs -u`

---

### (4) Install NFS server

1. Install NFS

    - `sudo apt update`

    - `sudo apt install nfs-kernel-server`

2. Check NFS status

    - `sudo service nfs-kernel-server status`

---

### (5) Configure /etc/exports to share folder

1. Edit /etc/exports > `sudo vim /etc/exports` and append ...

    - ```
      /mnt/md0 10.0.0.25(rw,sync,no_subtree_check)
      ```
    - Where `rw` allows read and write permissions, `sync` allows the writing of any change before applying it, and `no_subtree_check` prevents subtree checking

---

### (6) Enable NFS share

1. Export all directories in `/etc/exports`

    - `sudo exportfs -a`

2. Restart NFS

    - `sudo service nfs-kernel-server restart`

---

### Screenshot of `lsblk`, `md0` permissions, and `exportfs` /

> ![image](https://user-images.githubusercontent.com/97551273/224575306-365d3bd5-fd2a-476e-bb0e-e90d264bd6b3.png)

# Part 2 - Firewall Fixes ✼
### EC2 > Security Groups > Select SG > `Edit inbound rules`
1. ALLOW `https` from any IPv4 address (can add IPv6)
    - ![image](https://user-images.githubusercontent.com/97551273/224576894-b36f056a-ae1c-483f-ad94-2c79e7b460c8.png)

2. ALLOW `http` from any IPv4 address (can add IPv6)
    - ![image](https://user-images.githubusercontent.com/97551273/224576931-e89393c2-2d84-4aef-8c10-6669f10be686.png)

3. ALLOW `ssh` from "home" - public IP from ISP
    - ![image](https://user-images.githubusercontent.com/97551273/224576949-ef5e5d8e-b768-4727-8b7f-47783859331c.png)

4. ALLOW `ssh` from WSU - 130.108.0.0/16
    - ![image](https://user-images.githubusercontent.com/97551273/224576966-39aa1a32-2aee-4fd3-b735-5845f4edd6a5.png)

5. ALLOW `ssh` within virtual network - 10.0.0.0/16
    - ![image](https://user-images.githubusercontent.com/97551273/224576980-135909a5-0851-42ff-a1df-0c9b95c89e7c.png)

6. ALLOW `nfs` from "home" - public IP from ISP
    - ![image](https://user-images.githubusercontent.com/97551273/224576988-c60959a9-4f7e-4111-8abe-988b3b384a79.png)

7. ALLOW `nfs` from WSU - 130.108.0.0/16
    - ![image](https://user-images.githubusercontent.com/97551273/224577000-26f0a6a4-9b39-4ec7-8c66-dcc8ca367837.png)

8. ALLOW `nfs` within virtual network - 10.0.0.0/16
    - ![image](https://user-images.githubusercontent.com/97551273/224577008-463e87b5-dbf0-4fd1-b6e6-50b7fac93a43.png)

## All Inbound Rules (10)

> ![image](https://user-images.githubusercontent.com/97551273/224577042-a83ff9d5-f189-47fb-86cb-53dd9193dfa5.png)

# Part 3 - Mounting an NFS Share ✼

1. Install NFS client

    - `sudo apt install nfs-common`

---

2. Create a directory to mount the NFS share to

    - `sudo mkdir /var/nfs/shared -p`

- Change group ownership

    - `sudo chown nobody:nogroup /var/nfs/shared/`

- Edit /etc/exports and append ...

    - ```
      /var/nfs/shared 10.0.0.25(rw,sync, no_subtree_check)
      ```
    - `sudo exportfs -a`

    - `sudo service nfs-kernel-server restart`

---

3. Mount the share folder using the host's IP (public or private)

    - ` sudo mount 10.0.0.25:/var/nfs/shared /nfs/shared`

---

4. Prove that you can add files to the nfs share

    - `sudo touch /nfs/shared/shared.test` success !
    - `ls -l /nfs/shared/shared.test` =

      ```
      -rw-r--r-- 1 nobody nogroup 0 Mar 13 00:41 /nfs/shared/shared.test
      ```

---

5. Document how to unmount the nfs share

    - `sudo umount /nfs/shared`
