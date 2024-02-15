FROM debian:buster

RUN apt update && apt install -y \
	curl \
	php \
	php-fpm \
	php-cgi \
	php-mysql \
	php-cli \
	php-pdo \
	php-gd \
	php-mbstring \
	mariadb-client

# Download wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Donne droit d'exec et déplace l'archive au bon endroit
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Remplace la conf fpm de base par notre conf
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir /run/php

WORKDIR /var/www/wp/

# Download wordpress 6.3 / Deplace les fichiers dans le directory html
RUN curl -O https://wordpress.org/wordpress-6.3.tar.gz \
	&& tar xzf wordpress-6.3.tar.gz \
	&& cp -r wordpress/* /var/www/wp \
	&& rm -rf wordpress-6.3.tar.gz  \
	&& chown -R root:root /var/www/wp \
	&& chmod 777 /var/www/wp/*

# expose port a nginx
EXPOSE 9000

COPY ./tools/entry_point.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entry_point.sh
ENTRYPOINT [ "/usr/local/bin/entry_point.sh" ]