#!/bin/bash
#Wordt root
sudo -i


#Minion naar hosts
echo "127.0.0.1 minion" >> /etc/hosts
apt-get update -y
#installeer salt-minion
apt-get install salt-minion -y

#ipadres van master: 10.5.0.142 in config aanzetten
sed -i 's/#master: salt/master: 10.5.0.142/g' /etc/salt/minion

#herstarten minion
service salt-minion restart





