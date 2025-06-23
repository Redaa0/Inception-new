FROM debian:bullseye

EXPOSE 3306

RUN apt -y update && apt -y upgrade && apt -y install mariadb-server

COPY script.sh /bin/script.sh

RUN chmod +x /bin/script.sh

CMD ["/bin/script.sh"]