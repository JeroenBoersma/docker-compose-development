FROM php:7.0-fpm
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=app --with-fpm-group=app

RUN groupadd -g 1000 app && \
    useradd -g 1000 -u 1000 -d /data -s /bin/bash app

RUN apt-get update --fix-missing && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        msmtp \
        imagemagick \
        libssl-dev \
        libxml2-dev \
        libicu-dev \
        libxslt-dev \
        wget git vim ruby ruby-dev libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mcrypt mysqli pdo_mysql mbstring ftp soap zip intl xsl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN wget http://xdebug.org/files/xdebug-2.4.0rc2.tgz \
    && tar -xvzf xdebug-2.4.0rc2.tgz \
    && cd xdebug-2.4.0* \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012 \
    && cd && rm -rf xdebug-2.4.0rc2

# Install blackfire agent
RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so

RUN gem install -n /usr/local/bin magentify json curb colored nokogiri sshkit capistrano

# Enable debug extension
RUN echo ";extension=blackfire.so\nblackfire.agent_socket=\${BLACKFIRE_PORT}" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && echo "zend_extension=`ls /usr/local/lib/php/extensions/no-debug-non-zts-*/xdebug.so`" > /usr/local/etc/php/conf.d/xdebug.ini

RUN wget http://files.magerun.net/n98-magerun.phar -O /usr/bin/n98-magerun \
    && chmod +x /usr/bin/n98-magerun

COPY etc/php-fpm.conf /usr/local/etc/
COPY etc/php.ini /usr/local/etc/php/
RUN chmod ugo+rX -R /usr/local/etc/php

WORKDIR /data
CMD ["php-fpm"]

