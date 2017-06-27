#!/bin/bash
#(Alle aanpassingen in de configuratie files worden door zelf geschreven sed commands uitgevoerd.

#Het is de bedoeling dat dit script uiteindelijk misschien als eerste wordt gedraaid, dus een aantal setups zullen nodig zijn


#Dit script gaat als het goed is zometeen salt installeren. https://docs.saltstack.com/en/latest/topics/installation/ubuntu.html


#Wordt root
sudo -i
echo "127.0.0.1 master" >> /etc/hosts





#Het installeren van de packages. Deze manier werkte uiteindelijk wel, momenteel alleen master en minion installeren
#apt-get install salt-api -y
#apt-get install salt-cloud -y
apt-get install salt-master -y
apt-get install salt-minion -y
#apt-get install salt-ssh -y
#apt-get install salt-syndic -y

#Alternatieve methode, uitvinden welke beter is. https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-salt-master-and-minion-servers-on-ubuntu-14-04 
#sudo add-apt-repository ppa:saltstack/salt
#sudo apt-get update
#sudo apt-get install salt-master salt-minion salt-ssh salt-cloud salt-doc



#Installatie aan de hand van de officiele salt docks. https://repo.saltstack.com/#ubuntu
#wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add - -y

#sla file op in /etc/apt/sources.list.d/saltstack.list19:40 26-6-2017
#deb
#dpkg-deb --extract  http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main /etc/apt/sources.list.d/saltstack.list



#Configuratie aan de hand van https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-salt-master-and-minion-servers-on-ubuntu-14-04 


#Aanmaken salt directory structures
sudo mkdir -p /srv/{salt,pillar}

#Salt master configuratie aanpassen https://www.digitalocean.com/community/tutorials/saltstack-infrastructure-installing-the-salt-master

#Interface aanzetten waar de master naar luister, staat momenteel uitgecomment. 0.0.0.0 betekend dat de master over elke interface luister
sed -ie 's/#interface: 0.0.0.0/interface: 0.0.0.0/g' /etc/salt/master

#file_recv aanzetten, hierdoor kunnen salt minions files zenden naar de master
sed -i 's/#file_recv: False/file_recv: True/g' /etc/salt/master

#file-roots woordenboek aanmaken
sed -ie 's/# file_roots:/file_roots:/g' /etc/salt/master
sed -ie 's/#   base:/  base:/g' /etc/salt/master
sed -ie 's=#     - /srv/salt/=    - /srv/salt=g' /etc/salt/master
sed -ie '439i    - /srv/formulas' /etc/salt/master
sed -ie 's=- /srv/formulas=     - /srv/salt/formulas=g' /etc/salt/master

#Salt pillar configuration aanzetten.
sed -ie 's/#pillar_roots:/pillar_roots:/g' /etc/salt/master
sed -ie 's/#  base:/  base:/g' /etc/salt/master
sed -ie 's=#    - /srv/pillar=    - /srv/pillar=g' /etc/salt/master



#het configureren van de minion Daemon op de master zodat de master server Salt commands accepteert
sed -i 's/#master: salt/master: 127.0.0.1/g' /etc/salt/minion

#herstarten en accepteren van de salt keys

#apt install upstart -y

#Momenteel krijg ik de foutmelding unable to connect to Upstart: Fauled to connect to socket /com/ubuntu....
#Morgen verder uitzoeken
#restart salt-master  || Omdat ubuntu vanaf geen gebruik meer maakt van upstart werken deze commands niet
#restart salt-minion

#restart salt master
service salt-master restart

#restart salt minion
service salt-minion restart

#laat 30 seconden slapen
sleep 30s 

#De main moet de key van de minion accepteren
#Er worden momenteel geen keys gevonden, dus wellicht moet ik in de configuratie file wat  aanpassen.
salt-key --list all

#Gezien het in deze fase gaat om 1 key kunnen alle keys geaccepteerd worden
salt-key -A -y

#check of keys veranderd zijn
salt-key --list all

sleep 10s 
#Check of salt-master op commands reageert
salt '*' test.ping
#Wanneer er true komt te staan runt de service


#Straks kan als het goed is via deze line het script automatisch gedownload worden en uitgevoerd worden
#curl -s https://raw.githubusercontent.com/D0pe69/Linux-eindopdracht-ok/master/Salt%20install%20script.sh | bash -s arg1 arg2

#wget -O - https://raw.githubusercontent.com/D0pe69/Linux-eindopdracht-ok/master/Salt%20install%20script.sh | bash

#NICE

#Accepteer salt key van minion 1
salt-key -a minion -y

#check






