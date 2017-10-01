# Customize Docker Containers
Of course you would love day-to-day updates and still have room to add your own changes.
Just add a `docker-custom.yml`, add `version: '2'` to the top and override whatever you want.

`docker-custom.yml` and the `./custom` directory are excluded from git.

For example: to add a custom components to the default PHP, add the following `docker-custom.yml` file:

```yaml
version: '2'

services:
    php:
        build: custom/php7
```

This won't build the regular php7 directory, instead it will run build in the custom directory.
So, next up you copy the php/Dockerfile and add your own additions which will be build everytime updates are available.
