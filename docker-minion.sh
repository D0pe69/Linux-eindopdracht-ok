#!/bin/bash
#installatie docker op minions
sudo -i

#installatie aan de hand van: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

#haal GPK key
salt 'minion' cmd.run 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'


#Voeg repository toe aan apt
salt 'minion' cmd.run 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y'

#update packages
salt 'minion' cmd.run 'apt-get update -y'

#Zorg dat je vanuit docker repository installeert
salt 'minion' cmd.run 'apt-cache policy dockers-ce' 

#installeer docker daadwerkelijk
salt 'minion' cmd.run 'apt-get install -y docker-ce -y'

#test dat de boel werkt || Dit werkt, maar de terminal opent dan iets waar je handmatig uitmoet
#systemctl status docker

#verifieer dat docker runt,
salt 'minion' cmd.run 'docker run hello-world'

#installatie aan de hand van: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

#haal GPK key
salt 'minion2' cmd.run 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'


#Voeg repository toe aan apt
salt 'minion2' cmd.run 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y'

#update packages
salt 'minion2' cmd.run 'apt-get update -y'

#Zorg dat je vanuit docker repository installeert
salt 'minion2' cmd.run 'apt-cache policy dockers-ce' 

#installeer docker daadwerkelijk
salt 'minion2' cmd.run 'apt-get install -y docker-ce -y'

#test dat de boel werkt || Dit werkt, maar de terminal opent dan iets waar je handmatig uitmoet
#systemctl status docker

#verifieer dat docker runt,
salt 'minion2' cmd.run 'docker run hello-world'