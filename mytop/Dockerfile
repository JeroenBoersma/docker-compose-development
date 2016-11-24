FROM alpine:latest
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

RUN apk add --no-cache perl perl-dbd-mysql perl-term-readkey

RUN wget http://jeremy.zawodny.com/mysql/mytop/mytop-1.6.tar.gz && \
    tar xzvf mytop-1.6.tar.gz && \
    mv mytop-1.6/mytop /usr/local/bin/mytop && \
    rm -rf mytop-1.6.tar.gz mytop-1.6

ENTRYPOINT ["/usr/local/bin/mytop"]

