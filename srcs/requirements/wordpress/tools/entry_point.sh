#!/bin/bash

sleep 10

# sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
# sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
# sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
# sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
# echo "define('WP_HOME','https://scloutie.42.fr/');" >> wp-config-sample.php
# echo "define('WP_SITEURL','https://scloutie.42.fr/');" >> wp-config-sample.php
# cp wp-config-sample.php wp-config.php

cd /var/www/wp
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=$MYSQL_HOSTNAME \
		--path="/var/www/wp"
	wp core install \
		--url='https://scloutie.42.fr' \
		--path="/var/www/wp" \
		--title="inception" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PASS" \
		--admin_email="$WP_EMAIL" \
		--allow-root
	cd /var/www/wp
	wp user create $WP_USER $WP_USER_EMAIL \
		--role=administrator  \
		--user_pass=$WP_USER_PASS \
		--allow-root

/usr/sbin/php-fpm7.3 -F