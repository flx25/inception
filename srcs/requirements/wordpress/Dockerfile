FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y

RUN apt-get install php wget php7.4 php-fpm mariadb-client php-mysql -y

RUN mkdir -p /var/www && \
	cd /var/www && \
	wget https://de.wordpress.org/wordpress-6.0-de_DE.tar.gz && \
	tar -xzf wordpress-6.0-de_DE.tar.gz && \
	rm wordpress-6.0-de_DE.tar.gz && \
	chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/auto_config.sh /auto_config.sh

ENTRYPOINT /auto_config.sh