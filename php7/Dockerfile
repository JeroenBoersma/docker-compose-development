FROM srcoder/development-php:php7-fpm
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ARG GID=1000
ARG UID=1000

RUN groupmod -g $GID app && \
    usermod -g $GID -u $UID app

RUN apt-get update 
RUN apt-get install -y libmagickwand-dev imagemagick 
RUN pecl install imagick 
RUN docker-php-ext-enable imagick

