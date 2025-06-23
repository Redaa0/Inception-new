FROM debian:bullseye

EXPOSE 8080

RUN apt update && apt -y upgrade && apt install -y apache2 php libapache2-mod-php php-mysql wget

RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

RUN chown -R www-data:www-data /var/www/html/adminer.php

RUN chmod 755 /var/www/html/adminer.php

RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf

CMD ["apache2ctl", "-D", "FOREGROUND"]