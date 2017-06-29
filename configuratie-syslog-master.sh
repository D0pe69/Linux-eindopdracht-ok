#!/bin/bash
#(SED commands, of soort gelijke dingen zijn zelf geschreven, configuraties en installaties worden aan de hand van bronnen uitgevoerd.
#Configuratie aan de hand van: https://www.balabit.com/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/configure-servers.html


#door de ip() optie uit te schakelen luistert de server als het goed is naar alle logs, dat is voor de toekomst wel zo makkelijk
#sed -ie 's/#source s_net { tcp(ip(127.0.0.1) port(1000)); };/source s_net { tcp(ip()(port(1000)); };/g' /etc/syslog-ng/syslog-ng.conf

#source s_network { syslog(ip(0.0.0.0) transport("tcp")); };
#/etc/init.d/syslog-ng
#Zorg ervoor dat de messages worden opgeslagen per host
#sed -ie 's=destination d_messages { file("/var/log/messages"); };=destination d_messages { file("/var/log/messages_${HOST}"); };=g' /etc/syslog-ng/syslog-ng.conf

#maak een log statement die ervoor zorgt dat de externe bronnen lokaal worden opgeslagen || Werkt momenteel niet dus uitgecomment
#sed -ie '133i log { source(s_local); source(s_network); destination(d_local); };' /etc/syslog-ng/syslog-ng.conf

#installeren van syslog op beide minions aan de hand van: https://www.balabit.com/blog/installing-the-latest-syslog-ng-on-ubuntu-and-other-deb-distributions/

#pak de release key
#salt 'minion' cmd.run 'wget -qO – http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10/Release.key | sudo apt-key add –'

#maak nieuwe file waar de respository inkomt
#salt 'minion' cmd.run 'touch /etc/apt/sources.list.d/syslog-ng'

#Voeg dowload toe aan file
#salt 'minion' cmd.run 'echo "deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./" >> /etc/apt/sources.list.d/syslog-ng'

#update
#salt 'minion' cmd.run 'apt-get update -y'

#sleep 60s

#installeer
#salt 'minion' cmd.run 'apt-get install syslog-ng-core -y'

#salt 'minion' cmd.run 'pidof syslog-ng'

#Installatie minion 2
#pak de release key
#salt 'minion2' cmd.run 'wget -qO – http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10/Release.key | sudo apt-key add –'

#maak nieuwe file waar de respository inkomt
#salt 'minion2' cmd.run 'touch /etc/apt/sources.list.d/syslog-ng'

#Voeg dowload toe aan file
#salt 'minion2' cmd.run 'echo "deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_16.10 ./" >> /etc/apt/sources.list.d/syslog-ng'

#update
#salt 'minion2' cmd.run 'apt-get update -y'

#sleep 60s

#installeer
#salt 'minion2' cmd.run 'apt-get install syslog-ng-core -y'

#salt 'minion2' cmd.run 'pidof syslog-ng'

#Configureer Syslopg-ng op minion
#salt 'minion' cmd.run "sed -ie 's/#destination d_net { tcp/destination d_net { tcp/g' /etc/syslog-ng/syslog-ng.conf"

#salt 'minion' cmd.run "sed -ie 's/127.0.0.1/10.5.0.142/g' /etc/syslog-ng/syslog-ng.conf"

#salt 'minion' cmd.run "sed -ie 's/#log { source(s_src); destination(d_net); };/log { source(s_src); destination(d_net); };/g' /etc/syslog-ng/syslog-ng.conf"

#Configureer Syslopg-ng op minion2
#salt 'minion2' cmd.run "sed -ie 's/#destination d_net { tcp/destination d_net { tcp/g' /etc/syslog-ng/syslog-ng.conf"

#salt 'minion2' cmd.run "sed -ie 's/127.0.0.1/10.5.0.142/g' /etc/syslog-ng/syslog-ng.conf"

#salt 'minion2' cmd.run "sed -ie 's/#log { source(s_src); destination(d_net); };/log { source(s_src); destination(d_net); };/g' /etc/syslog-ng/syslog-ng.conf"

#uninstall
#salt 'minion2' cmd.run 'apt-get remove --purge syslog-ng-core -y'

#salt 'minion' cmd.run 'apt-get remove --purge syslog-ng-core -y'

sudo -i

#na behoorlijke struggles heb ik er besloten geen gebruik te maken van syslog, maar alles via Rsyslog te doen ||https://devops.profitbricks.com/tutorials/configure-remote-logging-with-rsyslog/
#Laat TCP logs toe in de firewall op poort 514
ufw allow 514/tcp

#configureer rsyslog om logs te ontvangen
sed -ie 's/#module(load="imtcp")/module(load="imtcp")/g' /etc/salt/master /etc/rsyslog.conf
sed -ie 's/#input(type="imtcp" port="514")/input(type="imtcp" port="514")/g' /etc/rsyslog.conf

service rsyslog restart


#configuratie minions
salt 'minion' cmd.run 'ufw allow 514/tcp'
salt 'minion' cmd.run "touch /etc/rsyslog.d/loghost.conf"
salt 'minion' cmd.run 'echo "*.* @@10.5.0.142:514" >> /etc/rsyslog.d/loghost.conf'
salt 'minion' cmd.run 'service rsyslog restart'
