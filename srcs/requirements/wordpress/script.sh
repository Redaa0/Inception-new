#!/bin/bash

cd /var/www/html

rm -rf *

sed -i -r "s/\/run\/php\/php7.4-fpm.sock/9000/1" /etc/php/7.4/fpm/pool.d/www.conf

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i -r "s/database_name_here/${MYSQL_DATABASE}/1"   wp-config.php

sed -i -r "s/username_here/${MYSQL_USER}/1"   wp-config.php

sed -i -r "s/password_here/${MYSQL_PASSWORD}/1"   wp-config.php

sed -i -r "s/localhost/mariadb/1"   wp-config.php

wp core install --url=${DOMAIN_NAME} --title="${WORDPRESS_TITLE}" --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root

wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PASSWORD} --allow-root

wp theme install astra --activate --allow-root

mkdir /run/php

chown -R nobody:nogroup /var/www

echo "Wordpress is ready!!!"

/usr/sbin/php-fpm7.4 -F