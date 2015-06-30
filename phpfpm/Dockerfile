FROM php:5.4-fpm
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=app --with-fpm-group=app

RUN groupadd -g 1000 app && \
    useradd -g 1000 -u 1000 -d /data app

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        msmtp \
    && docker-php-ext-install mcrypt mysql mysqli pdo_mysql mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && rm -rf /var/lib/apt/lists/*

COPY etc/php-fpm.conf /usr/local/etc/
COPY etc/php.ini /usr/local/etc/php/

WORKDIR /data
CMD "php-fpm"

