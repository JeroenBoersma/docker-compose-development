# UFW Firewall setting

By default `ufw` is disabled on Ubuntu.
All services are bound to the local interface(no place like home)

## Incoming trafic for XDEBUG

If you have `ufw` enabled, which you should!
Run the next command to allow traffic in:

`sudo ufw allow in on docker0 from 172.16.0.0/12 to 172.16.0.1/21 port 9000 comment xdebug`

