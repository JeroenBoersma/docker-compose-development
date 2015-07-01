FROM nginx
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

CMD "/bin/bash"

RUN groupadd -g 1000 app && \
    useradd -g 1000 -u 1000 -d /data -s /bin/bash app

COPY nginx /etc/nginx
WORKDIR /data

CMD ["nginx"]

