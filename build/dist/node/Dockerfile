ARG FROM_IMAGE=node
ARG FROM_TAG=lts

FROM ${FROM_IMAGE}:${FROM_TAG}
LABEL maintainer="Jeroen Boersma <jeroen@srcode.nl>"

RUN npm -g install\
    webpack webpack-cli webpack-dev-server\
    eslint-plugin-import eslint-plugin-promise\
    eslint eslint-config-standard eslint-plugin-node eslint-plugin-react eslint-plugin-standard

COPY ./php /usr/local/bin/

ARG GID=1000
ARG UID=1000

WORKDIR /data

RUN groupmod -g $GID node && \
    usermod -g $GID -u $UID node

