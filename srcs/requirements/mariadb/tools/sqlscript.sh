#!/bin/bash

set -e

if [ ! -e /var/lib/mysql/.inception_firstrun ]; then
    mysql_install_db \
        --auth-root-authentication-method=socket \
        --datadir=/var/lib/mysql \
        --skip-test-db \
        --user=mysql \
        --group=mysql >/dev/null
    mysqld_safe &
    mysqladmin ping -u root --silent --wait >/dev/null
    cat << EOF | mysql --protocol=socket -u root -p=
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
GRANT ALL PRIVILEGES on *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
    mysqladmin shutdown
    touch /var/lib/mysql/.inception_firstrun
fi

exec mysqld_safe
