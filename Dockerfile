FROM    nginx

MAINTAINER  Joe Black <joe@valuphone.com>

COPY    nginx.conf /etc/nginx/
COPY    .htpasswd /etc/nginx/
