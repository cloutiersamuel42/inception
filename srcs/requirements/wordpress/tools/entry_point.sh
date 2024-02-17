#!/bin/bash

sleep 10

cd /var/www/wp

# Create wp-config
wp config create --allow-root \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=$MYSQL_HOSTNAME \
	--path="/var/www/wp"

# Install
wp core install --allow-root \
	--url='https://scloutie.42.fr' \
	--path="/var/www/wp" \
	--title="Inception" \
	--admin_user="$WP_ADMIN" \
	--admin_password="$WP_ADMIN_PASS" \
	--admin_email="$WP_EMAIL" \

# Create second user
wp user create $WP_USER $WP_USER_EMAIL --allow-root \
	--role=editor  \
	--user_pass=$WP_USER_PASS \

/usr/sbin/php-fpm7.3 -F