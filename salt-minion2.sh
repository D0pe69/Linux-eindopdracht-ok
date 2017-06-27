#!/bin/bash
#Wordt root
sudo -i

#Minion naar hosts
echo "127.0.0.1 minion2" >> /etc/hosts

#installeer salt-minion
apt-get install salt-minion -y

#ipadres van master: 10.5.0.142 in config aanzetten
sed -i 's/#master: salt/master: 10.5.0.142/g' /etc/salt/minion

#herstarten minion
service salt-minion restart

#curl -s https://raw.githubusercontent.com/D0pe69/Linux-eindopdracht-ok/master/salt-minion2.sh | bash -s arg1 arg2
