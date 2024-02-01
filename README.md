# School Project in a Linux Environment

This repository contains scripts and configurations developed as part of a school project conducted within a Linux environment. The project aimed to automate various software installations and configurations. Below, you'll find an overview of the included scripts and their purposes.

Feel free to explore and utilize these scripts as necessary, and refer to each script's respective section for detailed information on their functionality and usage.


Installation Script (install.sh):

This script automates the installation of various components for your platform.
It installs Apache2, MySQL, PHP, Let's Encrypt client (Certbot), OpenLDAP, and Docker.
It configures MySQL for use with WordPress.
It downloads and sets up WordPress in the Apache web server.
It provides status updates for Apache2, MySQL, OpenLDAP, and Docker.
It is designed to be run on a Linux-based system using the Bash shell.
LDAP Backup Script (backup-ldap.sh):

This script takes backups of your LDAP (Lightweight Directory Access Protocol) configuration and data.
It exports LDAP configuration to config.ldif and LDAP data to pulttibois.ldif.
It logs the backup status to /var/log/backup-ldap.log.
It is intended to be run periodically to ensure data backup.
Certbot Renewal Script (renew-certbot.sh):

This script attempts to renew Let's Encrypt SSL certificates using Certbot.
It logs the result of the renewal process to /var/log/certbot-log.log.
It is typically scheduled as a cron job to ensure SSL certificate renewal.
LDAP Import Script (import-ldap.sh):

This script is used to import user data into an LDAP directory.
It reads user data from a CSV file and creates LDAP entries for each user.
It logs the status of each user import.
It requires a CSV file as an argument, and the CSV file should contain user information in a specific format.
