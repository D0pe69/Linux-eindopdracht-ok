#!/bin/bash
# Setup hoofdserver

#Wordt root
sudo -i

#installeren essentials.

sudo apt-get update

#Apache Uitvogelen hoe je automatisch alles accepteert
sudo apt-get install apache2 -y

#Php
sudo apt-get install php -y 




#wellicht ffe uitvogelen hoe je het wachtwoord invoert via script 
sudo apt-get install mysql-server -y

#https://stackoverflow.com/questions/14670716/simulate-user-input-in-bash-script 
set pass "placeholder"

spawn /usr/bin/passwd

expect "password: "
send "$pass"
expect "password: "
send "$pass"






#Installeren en configureren syslog // Bron: http://www.computernetworkingnotes.com/network-administrations/syslog-server.html
apt-get install syslog-ng -y











#Installeren Ezservermonitor.com https://www.ezservermonitor.com/esm-sh/documentation
apt install unzip
#downloaden
wget --content-disposition http://www.ezservermonitor.com/esm-sh/downloads/version/2.2
unzip ezservermonitor-sh_v2.2.zip -y


chmod u+x eZServerMonitor.sh
./eZServerMonitor.sh
















































#Configureren MySQL
sudo mysql_install_db

sudo /usr/bin/mysql_secure_installation
