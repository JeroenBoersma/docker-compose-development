ARG FROM_IMAGE=nginx
ARG IMAGE_TAG=alpine
ARG FROM_TAG=${IMAGE_TAG}

FROM ${FROM_IMAGE}:${FROM_TAG}
LABEL maintainer="Jeroen Boersma <jeroen@srcode.nl>"

COPY nginx /etc/nginx

