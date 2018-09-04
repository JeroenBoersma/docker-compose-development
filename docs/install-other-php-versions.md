# If you need to use a different PHP version other than the out-of-the-box supported versions than follow instructions below.

Example written for PHP5.4

- copy `https://github.com/JeroenBoersma/docker-php/tree/master/php5/fpm` to `build/custom/php54`
  - change the `FROM` section to `php:5.4-fpm` in the dockerfile
  - build in manually to see what works or if you need to adapt some things,
    I could imagine that some xdebug need to be adapted or removed if you don't use them
    I removed most extra things like opcache/blackfire/xdebug/redis
- create a `docker-custom.yml` and add a new service(see `docker-compose.yml` for some copy/paste contents: 
```
  php54:
    build: build/custom/php54
    volumes:
      - ./workspace:/data
    links:
      - db
      - mailcatch
    network_mode: bridge
```
- copy `build/dist/web` to `build/custom/web`
- change `docker-custom.yml` to build your custom web service
```
  web:
    build: build/custom/web
    links:
      - php54:fpm54
```
- edit `build/custom/web/nginx/content/backends.conf`
  copy/paste section `56` and change to `54`
- edit `build/custom/web/nginx/content/php`
  copy/paste all `56` sections and change them to `54`

Configuration finished, whoop

- `dev rebuild`
- goto your project root `cdw; cd myawesome/project`
- `dev changephp php54`

If you have a succesful build for a new PHP version 7.3 for instance.
Tell us and create a PR on https://github.com/JeroenBoersma/docker-php
And a PR here to update the `docker-compose.yml`/`docs`/`nginx` 

