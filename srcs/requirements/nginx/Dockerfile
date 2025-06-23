FROM debian:bullseye

EXPOSE 443

RUN apt -y update && apt -y upgrade && apt -y install nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=MO/L=BG/O=42/OU=IT/CN={DOMAIN_NAME}"

COPY default /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]