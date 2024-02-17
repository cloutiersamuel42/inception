#!/bin/bash

# Wait for mariadb
MAX_RETRIES=10
retries=1
success=0
while [ $retries -lt $MAX_RETRIES ]; do
	if mariadb -h "$MYSQL_HOSTNAME" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DATABASE;" >/dev/null 2>&1; then
		echo "Connection to wordpress database successful"
		success=1
		break
	else
		echo "Could not connect to database. Retry $retries"
		retries=$((retries + 1))
		sleep 2
	fi
done

if [ $success -eq 0 ]; then
	echo "ERROR: Too many retries."
	exit 1
fi

# Install wp if no config file is found
if [ ! -f "/var/www/wp/wp-config.php" ]; then
	cd /var/www/wp
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=$MYSQL_HOSTNAME \
		--path="/var/www/wp"

	wp core install --allow-root \
		--url='https://scloutie.42.fr' \
		--path="/var/www/wp" \
		--title="Inception" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PASS" \
		--admin_email="$WP_EMAIL"

	wp user create $WP_USER $WP_USER_EMAIL --allow-root \
		--role=editor  \
		--user_pass=$WP_USER_PASS
fi

echo "Wordpress is ready!"
/usr/sbin/php-fpm7.3 -F