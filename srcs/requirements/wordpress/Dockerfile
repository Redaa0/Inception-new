FROM debian:bullseye

EXPOSE 9000

RUN apt -y update && apt -y upgrade && apt -y install mariadb-server php-fpm php-mysql curl

COPY script.sh /bin/script.sh

RUN chmod +x /bin/script.sh

CMD ["/bin/script.sh"]