# Dev commands

We supply several helpful commands to get of easily. `./bin/dev COMMAND` or just `dev COMMAND` if you've added the development to your $PATH.

To control your docker environment.

- `build [IMAGE]`
  re-build a image
- `changephp`
  change current php version
- `config`
  show docker-compose configuration
- `down`
  destroy your local development environment, will not remove project/mysql files, only containers.
- `exec [CONTAINER] [OPTIONS]`
  execute commands in a specific container, for instance php or nginx
- `images`
  display used images
-  ngrok [HOSTNAME]
  share your environment with the outside world via ngrok.io
- `logs [CONTAINER]`
  show logs for a specific container
- `profile`
  show some useful commands to add to your SHELL
- `ps`
  show all running processes
- `rebuild`
  alias for `dev update && dev build && dev down && dev up`
- `restart [CONTAINER]`
  restart all or a specific container
- `run`
  run one-off commands in new container
- `setup`
  Run setup for defaults
- `start`
  start all exising container, will not create them if they don't exist(use `up` instead)
- `status`
  alias for ps
- `stop`
  stop all running containers
- `up`
  create/build/run all containers, bring your development to live
- `update`
  update/pull all used images from the web

There are also useful tools.

- `blackfire curl [URL]`
  The blackfire command to curl pages. Be sure you've setup blackfire correctly
- `composer [COMMANDS]` `composer5 [COMMANDS]`
  composer docker implementation, also runs in own container.
- `console` `console5`
  open a console inside your PHP containers.
- `magerun [COMMANDS]`
  run magerun commands on your Magento projects
- `magerun2 [COMMANDS]`
  run magerun2 commands on your Magento projects
- `myroot [OPTIONS]`
  run mysql as root.
- `mysql [OPTIONS]`
  run mysql as you, current user
- `mysqldump [OPTIONS]`
  run mysqldump as you, current user
- `mytop`
  run mytop as you, current user to monitor MySQL processes
- `top`
  monitor your running containers and see how much resources they are eating
- `php [OPTIONS]`
  run php commands
- `php-ext-enable [EXTENSION]`
  temporarily enable module for running container, use with `dev exec php php -v`
- `php-ext-disable [EXTENSION]`
  temporarily diable module for running container, use with `dev exec php php -v`

You can run these commands from within your workspace directories.
For example: `cd workspace/test/project/htdocs` `../../../../bin/dev php info.php` (or `dev php info.php` if you've added the bin directory to your path)

So you can also import data to mysql with `./bin/dev mysql database < dump.sql` or dump `./bin/mysqldump database > dump.sql`.
