FROM composer/composer:alpine
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ARG GID=1000
ARG UID=1000

RUN apk add --no-cache openssh-client && \
    adduser -u $UID -g $GID -h /app -DHs /bin/nologin app

WORKDIR /app

