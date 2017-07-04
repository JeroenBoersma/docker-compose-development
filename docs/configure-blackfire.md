# Configure Blackfire
The Blackfire library is already available in PHP, but not loaded by default.
To load blackfire, simply add a `conf/blackfire` file with content from the [Blackfire website][1].
Copy/paste the contents from the first block in the configuration file and remove the `export ` from the beginning of the line.
`./bin/dev/down` and `./bin/dev/up` to load blackfire.

[1]: https://blackfire.io/docs/integrations/docker#documentation