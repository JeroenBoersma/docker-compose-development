FROM ruby:latest
MAINTAINER Jeroen Boersma <jeroen@srcode.nl>

RUN gem install -n /usr/local/bin magentify json curb colored nokogiri sshkit capistrano

ARG GID=1000
ARG UID=1000

RUN groupadd -g $GID app && \
    useradd -g $GID -u $UID -d /app -s /bin/bash app

WORKDIR /app

