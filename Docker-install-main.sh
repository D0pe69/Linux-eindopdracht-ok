#!/bin/bash

#wordt root
sudo -i

#installatie aan de hand van: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

#haal GPK key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


#Voeg repository toe aan apt
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

#update packages
apt-get update -y

#Zorg dat je vanuit docker repository installeert
apt-cache policy dockers-ce 

#installeer docker daadwerkelijk
apt-get install -y docker-ce -y

#test dat de boel werkt || Dit werkt, maar de terminal opent dan iets waar je handmatig uitmoet
#systemctl status docker

#verifieer dat docker runt,
docker run hello-world


wget -O - https://raw.githubusercontent.com/D0pe69/Linux-eindopdracht-ok/master/docker-minion.sh | bash