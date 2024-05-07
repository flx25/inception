FROM debian:bullseye

RUN apt update
RUN apt install nginx nano curl openssl -y

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -days 42 -nodes -x509 \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=fvon-nag.42.fr/UID=fvon-nag" \
        -out /etc/ssl/certs/inception.crt \
        -keyout /etc/ssl/private/inception.key && \
    mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]