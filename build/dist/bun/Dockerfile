ARG FROM_IMAGE=oven/bun
ARG FROM_TAG=latest

FROM ${FROM_IMAGE}:${FROM_TAG}
LABEL maintainer="Jeroen Boersma <jeroen@srcode.nl>"

RUN bun add --global\
    webpack webpack-cli webpack-dev-server\
    eslint-plugin-import eslint-plugin-promise\
    eslint eslint-config-standard eslint-plugin-node eslint-plugin-react eslint-plugin-standard

COPY ./php /usr/local/bin/

ARG GID=1000
ARG UID=1000

WORKDIR /data

RUN groupmod -g $GID bun && \
    usermod -g $GID -u $UID bun

