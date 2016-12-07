FROM alpine:latest
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

# Install perl packages and remove unused dependencies
# Makes a small image
RUN apk add --no-cache perl perl-dbd-mysql perl-term-readkey && \

    rm -rf /usr/share/mysql && \

    cd /usr/lib/perl5 && \
    mv * /tmp/ && mkdir -p core_perl/auto vendor_perl/auto && \

    mv /tmp/core_perl/auto/Socket core_perl/auto/ && \
    mv /tmp/core_perl/CORE core_perl/ && \
    mv /tmp/core_perl/Config.pm core_perl/ && \
    mv /tmp/core_perl/DynaLoader.pm core_perl/ && \
    mv /tmp/core_perl/Socket.pm core_perl/ && \

    mv /tmp/vendor_perl/auto/DB* vendor_perl/auto/ && \
    mv /tmp/vendor_perl/DB* vendor_perl/ && \
    mv /tmp/vendor_perl/auto/Term vendor_perl/auto/ && \
    mv /tmp/vendor_perl/Term vendor_perl/ && \

    rm -rf /tmp/* && \

    cd /usr/share/perl5 && \
    mv * /tmp && mkdir core_perl && \

    mv /tmp/core_perl/AutoLoader.pm core_perl/ && \
    mv /tmp/core_perl/Carp.pm core_perl/ && \
    mv /tmp/core_perl/Exporter* core_perl/ && \
    mv /tmp/core_perl/Getopt core_perl/ && \
    mv /tmp/core_perl/Term core_perl/ && \
    mv /tmp/core_perl/XSLoader.pm core_perl/ && \
    mv /tmp/core_perl/constant.pm core_perl/ && \
    mv /tmp/core_perl/overload.pm core_perl/ && \
    mv /tmp/core_perl/overloading.pm core_perl/ && \
    mv /tmp/core_perl/strict.pm core_perl/ && \
    mv /tmp/core_perl/vars.pm core_perl/ && \
    mv /tmp/core_perl/warnings* core_perl/ && \

    rm -rf /tmp/*


# Get MyTop from remote
RUN wget http://jeremy.zawodny.com/mysql/mytop/mytop-1.6.tar.gz && \
    tar xzvf mytop-1.6.tar.gz && \
    mv mytop-1.6/mytop /mytop && \
    rm -rf mytop-1.6.tar.gz mytop-1.6

# Set correct entrypoint
ENTRYPOINT ["/mytop"]

