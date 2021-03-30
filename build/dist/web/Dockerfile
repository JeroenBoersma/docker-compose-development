ARG FROM_IMAGE=nginx
ARG IMAGE_TAG=alpine
ARG FROM_TAG=${IMAGE_TAG}

FROM ${FROM_IMAGE}:${FROM_TAG}
LABEL maintainer="Jeroen Boersma <jeroen@srcode.nl>"

ARG UID=1000
ARG GID=1000

RUN adduser -u $UID -g $GID -h /data -DHs /bin/nologin app

COPY nginx /etc/nginx
COPY run-nginx.sh /run-nginx.sh

WORKDIR /data

CMD ["/run-nginx.sh"]

