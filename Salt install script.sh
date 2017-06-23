#!/bin/bash
#(Alle aanpassingen in de configuratie files worden door zelf geschreven sed commands uitgevoerd.
echo "127.0.0.1 master" >> /etc/hosts

#Het is de bedoeling dat dit script uiteindelijk misschien als eerste wordt gedraaid, dus een aantal setups zullen nodig zijn


#Dit script gaat als het goed is zometeen salt installeren|||| https://docs.saltstack.com/en/latest/topics/installation/ubuntu.html


#Wordt root
sudo -i

#Het installeren van de packages
apt-get install salt-api -y
apt-get install salt-cloud -y
apt-get install salt-master -y
apt-get install salt-minion -y
apt-get install salt-ssh -y
apt-get install salt-syndic -y

#Alternatieve methode, uitvinden welke beter is.|| https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-salt-master-and-minion-servers-on-ubuntu-14-04 
sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update
sudo apt-get install salt-master salt-minion salt-ssh salt-cloud salt-doc

#Configuratie aan de hand van https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-salt-master-and-minion-servers-on-ubuntu-14-04 


#Aanmaken salt directory structures
sudo mkdir -p /srv/{salt,pillar}

#Salt master configuratie aanpassen https://www.digitalocean.com/community/tutorials/saltstack-infrastructure-installing-the-salt-master

#file_recv aanzetten, hierdoor kunnen salt minions files zenden naar de master
sed -i 's/file_recv: False/file_recv: True/g' /etc/salt/master


#het configureren van de minion Daemon op de master zodat de master server Salt commands accepteert
sed -i 's/master: salt/master: 127.0.0.1/g' /etc/salt/minion

#herstarten en accepteren van de salt keys
apt install upstart -y

#Momenteel krijg ik de foutmelding unable to connect to Upstart: Fauled to connect to socket /com/ubuntu....
#Morgen verder uitzoeken
restart salt-master
restart salt-minion






