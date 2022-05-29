FROM nginx:1.21-alpine
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV TZ=Asia/Tokyo

RUN apk update && \
    apk add --update --no-cache --virtual=.build-dependencies g++ tzdata shadow && \
    groupmod www-data -g 1000 && \
    useradd -u 1000 -g www-data www-data && \
    apk del .build-dependencies

COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./ssl/server.crt /etc/nginx/ssl/server.crt
COPY ./ssl/server.key /etc/nginx/ssl/server.key
COPY ./ssl/server.password /etc/nginx/ssl/server.password

WORKDIR /var/www/cake_app