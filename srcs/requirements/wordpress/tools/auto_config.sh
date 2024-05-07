#!/bin/bash
sleep 10

# Create wp-config.php file manually
cat << EOF > /var/www/wordpress/wp-config.php
<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${MYSQL_PASSWORD}');
define('DB_HOST', 'mariadb:3306');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
\$table_prefix = 'wp_';
/* That's all, stop editing! Happy publishing. */
require_once(ABSPATH . 'wp-settings.php');
EOF

sleep 2
wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
wp user create --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log.txt

# if /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir ./run/php
fi
/usr/sbin/php-fpm7.4 -F