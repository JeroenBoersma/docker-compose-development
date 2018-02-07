# Sharing with the world via Ngrok.io
## Ngrok service
This is a service lets you share your progress with the world via a generated URL.

## Using this service
From within you project directory(let's say workspace/test/project) invoke `dev ngrok`
This will display a generated URL inside the command line which you can share with the world. Following that URL will take you to your project.

You can also run `dev ngrok test.project.localhost` (or the subdomain you've chosen in your configuration) from anywhere and this will generate a URL which forwards to the given domain. This is also useful when using a custom service like Magento, Silex or Symfony.
