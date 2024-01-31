#!/bin/bash

# Installation av vår plattform
sudo apt-get update
sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mysql
sudo apt-get install -y certbot # Klient för Let's Encrypt (SSL-certification)
sudo apt-get install -y slapd ldap-utils
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin


# Undersök ifall installationen var lyckad!
if [ $? -ne 0 ]; then
    echo "Installation failed. Exiting."
    exit 1
fi

# Konfiguration utav MySQL
echo -e "\e[1;31mDetta lösenord är till för ditt databas\e[0m"
sudo mysql -u root -p <<EOF
CREATE DATABASE WordPress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON WordPress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Konfigurera OpenLDAP automatiskt genom att använda dpkg-reconfigure
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure slapd <<EOF
slapd slapd/internal/generated_adminpw password admin
slapd slapd/internal/adminpw password admin
slapd slapd/password2 password admin
slapd slapd/password1 password admin
EOF

# Startar om Apache2
sudo systemctl restart apache2

# Ladda ner och installera WordPress
cd /var/www/html
sudo wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
cd wordpress
cp wp-config-sample.php wp-config.php

echo "define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', 'password');">test.php

# Konfigurera WordPress
sudo sed -i "s/database_name_here/WordPress/" wp-config.php
sudo sed -i "s/username_here/wpuser/" wp-config.php
sudo sed -i "s/password_here/password/" wp-config.php

# Skriv ut om det lyckades
echo "WordPress installation and configuration completed successfully!"

# Visa i terminalen status på Apache2, MySQL och OpenLDAP 
echo "Apache Status:"
sudo systemctl status apache2
echo "MySQL Status:"
sudo systemctl status mysql
echo "OpenLDAP Status:"
sudo systemctl status slapd
echo "Docker Status:"
sudo systemctl status docker

# Stoppar skriptet
echo "Nu stoppas skriptet"
exit 0