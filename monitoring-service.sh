#!/bin/bash

#Monitoring service 
sudo -i

#Alsnog via de EzServerMonitor aangezien netdata te zwaar is voor de windows server en ik niet in staat was het werkend te krijgen
#op het floating ip.
#installeer op master
#apt-get install unzip -y
#wget --content-disposition http://www.ezservermonitor.com/esm-sh/downloads/version/2.2 

#unzip ezservermonitor-sh_v2.2.zip -y

#Sta toe
#chmod u+x eZServerMonitor.sh

#wget --content-disposition http://www.ezservermonitor.com/esm-sh/downloads/version/2.2 

#unzip ezservermonitor-sh_v2.2.zip 

#Sta toe
#chmod u+x eZServerMonitor.sh

#Voor uitvoeren
#./eZServerMonitor.sh --all

#?


#installeer op minion 1
#salt 'minion' cmd.run 'sudo -i'
#salt 'minion' cmd.run 'apt-get install unzip '
#salt 'minion' cmd.run 'wget --content-disposition http://www.ezservermonitor.com/esm-sh/downloads/version/2.2'

#salt 'minion' cmd.run 'unzip ezservermonitor-sh_v2.2.zip '


#Sta toe
#salt 'minion' cmd.run "chmod u+x eZServerMonitor.sh"

#salt 'minion' cmd.run "./eZserverMonitor.sh -all"


#installeer op minion 2
#salt 'minion2' cmd.run 'wget --content-disposition http://www.ezservermonitor.com/esm-sh/downloads/version/2.2'
#salt 'minion2' cmd.run 'apt-get install unzip '
#salt 'minion2' cmd.run 'wget --content-disposition http://www.ezservermonitor.com/esm-sh/downloads/version/2.2'

#salt 'minion2' cmd.run 'unzip ezservermonitor-sh_v2.2.zip '

#Sta toe
#salt 'minion2' cmd.run 'chmod u+x eZServerMonitor.sh'
























#Voor de monitoring service heb ik er uiteindelijk voor gekozen Netdata te gebruiken, aangezien dit redelijk
#simpel lijkt en in staat is meerdere servers te monitorin, in tegenstelling tot EzServerMonitor
#Installatie aan de hand van: https://www.digitalocean.com/community/tutorials/how-to-set-up-real-time-performance-monitoring-with-netdata-on-ubuntu-16-04

#poort openzetten
ufw allow 19999/tcp

#installeren
yes | bash <(curl -Ss https://my-netdata.io/kickstart.sh) 

#instellen zodat er 4 uur monitoring wordt opgeslagen


#Maak van main een registry zodat alle dingen er weergegeven kunnen worden
sed -ie '88s/# enabled = no/enabled = yes/' /etc/netdata/netdata.conf

#Ip adres als regisry zetten
sed -ie 's*# registry to announce = https://registry.my-netdata.io*registry to announce = 145.37.234.182*' /etc/netdata/netdata.conf

service netdata restart

#Installeren monitoring service op minions
#poort openzetten
salt 'minion' cmd.run 'ufw allow 19999/tcp'

#installeren
salt 'minion' cmd.run "wget -O - https://my-netdata.io/kickstart.sh | bash"

#2e keer installeren want hij doet het op 1 of andere manier niet na 1 keer installeren fking vaag
salt 'minion' cmd.run "wget -O - https://my-netdata.io/kickstart.sh | bash"
salt 'minion' cmd.run 'service netdata restart'


#Installeren monitoring service op minions
#poort openzetten
salt 'minion2' cmd.run 'ufw allow 19999/tcp'

#installeren
salt 'minion2' cmd.run "wget -O - https://my-netdata.io/kickstart.sh | bash"
#2e keer installeren want hij doet het op 1 of andere manier niet na 1 keer installeren fking vaag
salt 'minion2' cmd.run "wget -O - https://my-netdata.io/kickstart.sh | bash"
salt 'minion2' cmd.run 'service netdata restart'


var1=$(salt '*' network.ip_addrs)
touch /var/log/netwerklijst.txt
echo "$var1"
echo "$var1" >> /var/log/netwerklijst.txt





#registry option aanzetten
#salt 'minion' cmd.run "sed -ie '88s/# enabled = no/enabled = no/' /etc/netdata/netdata.conf"

#registry op de master zetten
#salt 'minion' cmd.run "sed -ie 's*# registry to announce = https://registry.my-netdata.io*registry to announce = 10.5.0.142*' /etc/netdata/netdata.conf"

#alt 'minion' cmd.run 'service netdata restart'



#Installeren monitoring service op minions
#poort openzetten
#salt 'minion2' cmd.run 'ufw allow 19999/tcp'

#installeren
#salt 'minion2' cmd.run 'yes |curl -Ss https://my-netdata.io/kickstart.sh'


#registry option aanzetten
#salt 'minion2' cmd.run "sed -ie '88s/# enabled = no/enabled = no/' /etc/netdata/netdata.conf"

#registry op de master zetten
#salt 'minion2' cmd.run "sed -ie 's*# registry to announce = https://registry.my-netdata.io*registry to announce = 10.5.0.142*' /etc/netdata/netdata.conf"

#salt 'minion2' cmd.run 'service netdata restart'