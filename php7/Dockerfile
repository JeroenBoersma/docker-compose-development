FROM srcoder/development-php:php7-fpm
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ARG GID=1000
ARG UID=1000

RUN groupmod -g $GID app && \
    usermod -g $GID -u $UID app
