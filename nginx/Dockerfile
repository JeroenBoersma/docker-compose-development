FROM nginx
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

CMD "/bin/bash"

RUN groupadd -g 1000 app && \
    useradd -g 1000 -u 1000 -d /data app

COPY nginx /nginx
WORKDIR /data

CMD ["nginx", "-g", "daemon off;", "-c", "/nginx/nginx.conf"]

