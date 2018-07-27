# How to use different PHP versions

We run PHP 7.0 as the default PHP version, but we also support PHP 5.6.x, PHP 7.1.x and PHP 7.2.x
Running different PHP version is as simple as adding a .php{version} file.

To change all to default PHP 7.2, goto your workspace directory and create a file named `.php72`
This will make all webrequest and console request default to PHP 7.2.

You can set PHP versions for a customer/project namespace. It'll look up from the deepest path.

- `workspace/customer/project/.php56`
- `workspace/customer/.php71`
- `workspace/.php72`

Using the example above;

- Default for is PHP 7.2
- Customer scope is PHP 7.1
- Project runs PHP 5.6

## PHP-CLI version

You do'nt need to add a suffix anymore(for older versions) for cli commands, it'll take the same version as above.
You need to make sure you change your workpath before running commands.

