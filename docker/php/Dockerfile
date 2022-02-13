FROM php:8.0-fpm-buster
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

ENV TZ=Asia/Tokyo \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer

RUN echo "${TZ}" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/cake_app

RUN apt-get update && \
    apt-get -y install git \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    unzip \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    mkdir /var/run/php-fpm && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install intl mbstring zip pdo_mysql gd fileinfo opcache && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    { \
        echo "alias ll='ls -l --color=auto'"; \
    } >> /root/.bashrc

COPY ./php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./php.ini /usr/local/etc/php/php.ini