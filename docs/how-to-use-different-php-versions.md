# How to use different PHP versions

We run PHP 7.0 as the default PHP version, but we also support PHP 5.6.x and PHP 7.1.x. 
Running different PHP version is as simple as changing the hostname.

## PHP 7.1.x

Change the hostname from `*.dev` to `*.php71.dev`

## PHP 5.6.x

Change the hostname from `*.dev` to `*.php56.dev`

## PHP-CLI version

Same goes for `dev [COMMAND]`, just suffix the php command with a `5` or `71`.
You can get a list of these commands by running `./dev/bin` from your development folder.