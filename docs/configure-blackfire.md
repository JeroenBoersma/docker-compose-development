# Configure Blackfire
The Blackfire library is already available in PHP, but not loaded by default.
To load blackfire, simply add a `conf/blackfire` file with content from the [Blackfire website][1].
Copy/paste the contents from the env vars including their names in the configuration file `conf/blackfire` (make sure you are logged in).
`./bin/dev/down` and `./bin/dev/up` to load Blackfire.

Make sure to list all 4 env variables;

```
BLACKFIRE_CLIENT_ID=
BLACKFIRE_CLIENT_TOKEN=
BLACKFIRE_SERVER_ID=
BLACKFIRE_SERVER_TOKEN=
```

[1]: https://blackfire.io/docs/integrations/docker#documentation

