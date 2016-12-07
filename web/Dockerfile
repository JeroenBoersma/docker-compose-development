FROM nginx:alpine
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ARG UID=1000
ARG GID=1000

RUN adduser -u $UID -g $GID -h /data -s /bin/nologin -D app

COPY nginx /etc/nginx

WORKDIR /data

CMD ["nginx"]

