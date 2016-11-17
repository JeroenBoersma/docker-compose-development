FROM composer/composer
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ARG GID=1000
ARG UID=1000

RUN groupadd -g $GID app && \
    useradd -g $GID -u $UID -d /app -s /bin/bash app

WORKDIR /app

