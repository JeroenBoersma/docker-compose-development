#!/bin/sh

INDEX='DOMAINSUFFIX';
DOMAIN=${DOMAINSUFFIX};

grep -rl ${INDEX} /etc/nginx/ | while read a; do sed -i 's/\['${INDEX}'\]/'${DOMAIN}'/' $a; done;

exec nginx-debug

