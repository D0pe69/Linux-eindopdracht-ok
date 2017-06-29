#!/bin/bash
#Wordt root
sudo -i

sudo apt-get install expect -y

#Opzetten wordpress aan de hand van https://docs.docker.com/compose/wordpress/


docker pull mariadb

apt install mariadb-client-core-10.0 -y

mkdir /opt/wordpress
mkdir -p /opt/wordpress/database
mkdir -p /opt/wordpress/html

salt 'minion' cmd.run 'docker run -e MYSQL_ROOT_PASSWORD=XXX -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=XXX -e MYSQL_DATABASE=wordpress_db -v /opt/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb'

salt 'minion' var1="$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb)"

pass="$(echo "XXX")"

mysql -u wpuser -h $var1 -p



docker pull wordpress:latest

docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=XXX -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /opt/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress

echo $var1





