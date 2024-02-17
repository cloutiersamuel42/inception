#!/bin/bash

set -e
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	service mysql start
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > inception.sql
	echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> inception.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> inception.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> inception.sql
	echo "FLUSH PRIVILEGES;" >> inception.sql
	mysql -u root  < inception.sql
	chmod -R 777 /var/lib/mysql/$MYSQL_DATABASE
	pkill mysql
	sleep 2
fi

mysqld_safe