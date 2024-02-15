FROM debian:buster

RUN apt update && apt install -y \
	mariadb-server \
	mariadb-client

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir /run/mysql
RUN chown -R mysql:mysql /run/mysql
RUN chown -R mysql:mysql /var/lib/mysql

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./tools/mariadb_create.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_create.sh
ENTRYPOINT [ "/usr/local/bin/mariadb_create.sh" ]

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]