ARG FROM_IMAGE=srcoder/development-php
ARG FROM_TAG=php71-fpm

ARG INSTALL_MSMTP=0
ARG MAIL_HOST=mailcatch
ARG MAIL_PORT=1025
ARG MAIL_FROM=app@fpm.dev

FROM ${FROM_IMAGE}:${FROM_TAG}
LABEL maintainer="Jeroen Boersma <jeroen@srcode.nl>"

ARG INSTALL_MSMTP
ARG MAIL_HOST
ARG MAIL_PORT
ARG MAIL_FROM

ARG GID=1000
ARG UID=1000

RUN groupmod -g $GID app && \
    usermod -g $GID -u $UID app

USER root

RUN if [ "$INSTALL_MSMTP" = "1" ]; then \
      set -eux; \
      if command -v apk >/dev/null 2>&1; then \
        apk add --no-cache msmtp; \
      elif command -v apt-get >/dev/null 2>&1; then \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive apt-get install -y msmtp; \
      elif command -v dnf >/dev/null 2>&1; then \
        dnf install -y msmtp; \
      else \
        echo "geen package manager gevonden" >&2; exit 1; \
      fi; \
      PHP_SCAN_DIR="$(php -r 'echo PHP_CONFIG_FILE_SCAN_DIR;')" || true; \
      PHP_CONF_DIR="${PHP_SCAN_DIR%%:*}"; \
      if [ -z "$PHP_CONF_DIR" ]; then PHP_CONF_DIR="/usr/local/etc/php/conf.d"; fi; \
      mkdir -p "$PHP_CONF_DIR"; \
      MS="$(command -v msmtp || echo /usr/bin/msmtp)"; \
      echo "sendmail_path = \"$MS --host=${MAIL_HOST} --port=${MAIL_PORT} -f ${MAIL_FROM} -t -i\"" > "$PHP_CONF_DIR/zz-msmtp.ini"; \
      echo "mail.force_extra_parameters =" >> "$PHP_CONF_DIR/zz-msmtp.ini"; \
    fi

USER app:app

