## Part 1 - HTTP Server

1. **Install either Apache HTTP Server OR Nginx to your instance.  Document the following:**
    - What port is the service running on? `Port 80`

    - What directory does it serve content from by default? `/var/www/html`

    - What is the name of the primary configuration file for the service? `/etc/httpd/conf/httpd.conf`

2. **Host your content via the web server:**
    - Describe two ways (at least) that you can confirm the webserver is serving your site's content

        1. Run `curl http://localhost` on command line
        2. Visit http://localhost on browser

3. **Set appropriate access.  Ensure the following:**
- the content server can read the site files:

    - `html` folder permissions set to `755`, meaning the **owner** can `read, write, execute` while **group & others** can `read and execute`

        ```
        total 12K
        drwxr-xr-x  3 root root 4.0K Feb  6 14:01 .
        drwxr-xr-x 14 root root 4.0K Feb  6 14:01 ..
        drwxr-xr-x  4 root devs 4.0K Feb  6 14:01 html
        ```

    - `index.html` permissions set to `644`, meaning the **owner** can `read and write` while **group & others** can `read` only

        ```
        total 28K
        drwxr-xr-x 4 root     root     4.0K Feb  6 14:01 .
        drwxr-xr-x 3 root     root     4.0K Feb  6 14:01 ..
        -rw-r--r-- 1 root     root      11K Feb  6 14:01 index.html
        ```
    - members of a group named `devs` are allowed to edit and create new files:

        1. Create group: `groupadd devs`

        2. Add members to group: `sudo usermod -a -G devs <member>`

        3. Change the group of the target directory recursively: `chgrp -R devs /var/www/html`

            - `-R` will allow this command to set directory & all file/subdirectory permissions

        4. Set additional permissions to allow group to write: `chmod 775 /var/www/html`

        5. Utilize ACL to set default permissions: `sudo setfacl -Rdm g:devs:rwx /var/www/html`

            - Where `-R` indicates recursive, `-d` indicates default, and `-m` to add/modify rules

            - This will make future files inherit group permissions `rwx`

        6. Check permissions: `getfacl /var/www/html`
        ```
        getfacl: Removing leading '/' from absolute path names
        # file: var/www/html
        # owner: root
        # group: devs
        # flags: -s-
        user::rwx
        group::rwx
        other::r-x
        default:user::rwx
        default:group::rwx
        default:group:devs:rwx
        default:mask::rwx
        default:other::r-x
        ```

        7. Tested functionality by `creating` new file in `/var/www/html` through a `devs` member and seeing it is `writable` automatically then switching to `alternate user` **not** part of group `devs`, who is `unable` to edit or create files but is able to view them and navigate the directories.

**NOTE: IF YOU DO NOT COMPLETE ENABLING HTTPS, INCLUDE SCREENSHOT OF SITE RUNNING WITH HTTP**

## Part 2 - Enable HTTPS

1. **Create a self-signed TLS certificate for your server**

    - Make certificates directory: `mkdir Certs` > `cd Certs`

    - Create key: `openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out MyCertificate.crt -keyout MyKey.key`

2. **Enable HTTPS for your web content service**

    - Enable SSL: `sudo a2enmod ssl` (otherwise get config syntax error)

- Modify `/etc/apache2/sites-available/000-default.conf` to include:

    ```
    <VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ServerName localhost

        Redirect permanent / https://localhost/     <------------

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

    </VirtualHost>

    <VirtualHost _default_:443>     <------------

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ServerName localhost
        SSLEngine on

        SSLCertificateFile /root/Certs/localhost.com.crt
        SSLCertificateKeyFile /root/Certs/localhost.com.key

    </VirtualHost>

    ```
    - Restart the web content service: `sudo service apache2 reload` or `sudo service apache2 restart`
3. **Document:**

- **Configuration file changes** ...

    - Changes made to `/etc/apache2/sites-available/000-default.conf` can be seen above

- **Location of certificate files** ...

    - `/root/Certs/localhost.com.crt` (certificate) and `/root/Certs/localhost.com.key` (key)

- **Administrative commands (like how to restart the web content service)** ...

    - `sudo service apache2 reload` or `sudo service apache2 restart`

- **How you can confirm HTTPS is enabled** ...

    - When attempting to visit `http://localhost`, the address is automatically redirected to `https://localhost`

4. **Include screenshot of site after HTTPS is enabled** ...

>![image](https://user-images.githubusercontent.com/97551273/217972750-29377a4b-7b3b-4032-8659-2638552ba221.png)

> ![image](https://user-images.githubusercontent.com/97551273/217972682-eb3470e6-7eda-40ee-92bf-58baee3da1b8.png)

## Firewall Fixes - HARD MODE - 10% Extra Credit

Use either `ufw` or `iptables` to generate to the following firewall rules.  Move carefully and understand chaining (before you lock yourself out... forever!)

**Create 2 rules for SSH** ...

- allow SSH connections from your home (and any additional trusted sources)

    - `sudo iptables -I INPUT -p tcp -s 74.135.84.169/32 --dport 22 -j ACCEPT`

- allow SSH connections from campus (130.108.0.0/16)

    - `sudo iptables -A INPUT -p tcp -s 130.108.0.0/16 --dport 22 -j ACCEPT`

**Create 2 rules for HTTP/ HTTPS** ...

- allow HTTP from any source

    - `sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT`

- allow HTTPS from any source
    - `sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT`

**Remove any other rules that are too open** ...
- `sudo iptables --policy INPUT DROP` to default deny all other connections not specified above

```
Chain INPUT (policy DROP)
target     prot opt source               destination
ACCEPT     tcp  --  74.135.84.169        anywhere             tcp dpt:ssh
ACCEPT     tcp  --  130.108.0.0/16       anywhere             tcp dpt:ssh
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:https

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

```
- Save changes: `sudo iptables-save`

## Part 4 - Research

1. **Domain name registration** ...

    - Select a registrar you would use to register a domain name: [gandi.net](gandi.net)

    - Describe what steps would be needed to associate the domain name with your web server: After selecting and purchasing a DNS, I would open `/etc/apache2/sites-available/000-default.conf` once again and enter `ServerName <www.domain-name.com>`

2. **Certificate Authority Validation** ...

    - Select a CA you would use to validate your site & generate a certificate: [entrust.com](https://www.entrust.com/resources/certificate-solutions/tools/root-certificate-downloads) > `CA - L1C`

    - Describe what is needed for validation: The CA validation process involves checking that the certificate has been signed by a `Certificate Authority (CA)` that you trust. In order for this to be done, RSE daemon must be able to access a certificate that identifies the CA.

## Part 5 - Resources Used
- `Format:`  [ what I used it for ] ( the website )

- [change permissions recursively](https://www.baeldung.com/linux/change-folder-and-content-permissions)
- [setting default permissions ](https://unix.stackexchange.com/questions/115631/getting-new-files-to-inherit-group-permissions-on-linux)
- [creating an SSL certificate](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-22-04)
- [enabling HTTPS](https://www.arubacloud.com/tutorial/how-to-enable-https-protocol-with-apache-2-on-ubuntu-20-04.aspx)
- [configuring iptables rules](https://www.ibm.com/docs/hr/dsm?topic=iptables-configuring)
