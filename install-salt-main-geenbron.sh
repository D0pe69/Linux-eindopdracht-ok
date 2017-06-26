#!/bin/bash
#(Alle aanpassingen in de configuratie files worden door zelf geschreven sed commands uitgevoerd.

#Het is de bedoeling dat dit script uiteindelijk misschien als eerste wordt gedraaid, dus een aantal setups zullen nodig zijn


#Dit script gaat als het goed is zometeen salt installeren. 


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

#Alternatieve methode, uitvinden welke beter is. =
#sudo add-apt-repository ppa:saltstack/salt
#sudo apt-get update
#sudo apt-get install salt-master salt-minion salt-ssh salt-cloud salt-doc



#Installatie aan de hand van de officiele salt docks. https://repo.saltstack.com/#ubuntu
#wget -O - =
#sla file op in /etc/apt/sources.list.d/saltstack.list19:40 26-6-2017
#deb
#dpkg-deb --extract  =



#Configuratie aan de hand van=


#Aanmaken salt directory structures
sudo mkdir -p /srv/{salt,pillar}

#Salt master configuratie aanpassen =

#Interface aanzetten waar de master naar luister, staat momenteel uitgecomment. 0.0.0.0 betekend dat de master over elke interface luister
sed -ie 's/#interface: 0.0.0.0/interface: 0.0.0.0/g' /etc/salt/master

#file_recv aanzetten, hierdoor kunnen salt minions files zenden naar de master
sed -i 's/#file_recv: False/file_recv: True/g' /etc/salt/master



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

#De main moet de key van de minion accepteren
#Er worden momenteel geen keys gevonden, dus wellicht moet ik in de configuratie file wat  aanpassen.
salt-key --list all

#Gezien het in deze fase gaat om 1 key kunnen alle keys geaccepteerd worden
salt-key -A -y

#Check of salt-master op commands reageert
salt '*' test.ping
#Wanneer er true komt te staan runt de service


#Straks kan als het goed is via deze line het script automatisch gedownload worden en uitgevoerd worden
#curl -s https://raw.githubusercontent.com/D0pe69/Linux-eindopdracht-ok/master/Salt%20install%20script.sh

#bash <(curl -s https://raw.githubusercontent.com/D0pe69/Linux-eindopdracht-ok/master/Salt%20install%20script.sh)

#wget -O - https://www.dropbox.com/s/txkbc97rodi3iq0/install-salt-main-geenbron.sh?dl=0 | bash




