FROM debian:buster

RUN apt update && apt install -y \
	procps \
	mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir /run/mysql
RUN chown -R mysql:mysql /run/mysql
RUN chown -R mysql:mysql /var/lib/mysql && \
	chmod -R 777 /var/lib/mysql

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb_create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_create.sh
ENTRYPOINT [ "/usr/local/bin/mariadb_create.sh" ]



#CMD ["mysqld", "--bind-address=0.0.0.0"]