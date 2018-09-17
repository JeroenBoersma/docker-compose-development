FROM srcoder/development-php:php5-fpm
LABEL maintainer="Jeroen Boersma <jeroen@srcode.nl>"

ARG GID=1000
ARG UID=1000

RUN groupmod -g $GID app && \
    usermod -g $GID -u $UID app

