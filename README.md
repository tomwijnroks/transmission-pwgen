# transmission-pwgen
Transmission password generator.

## About
The Transmission BitTorrent client (transmission-daemon) uses a settings.json file where you can set a plain text password for the rpc interface. After restarting transmission the plain text password will be changed to an encrypted password string.

Transmission does not have a command line tool to generate the encrypted password string in advance. This transmission-pwgen script will generate a plain text password + the encrypted password string which can be used in the settings.json file.

## Usage
Download transmission-pwgen and make it executable:
```
curl -so transmission-pwgen.sh https://raw.githubusercontent.com/tomwijnroks/transmission-pwgen/master/transmission-pwgen.sh
chmod +x transmission-pwgen.sh
```
Now you can use `./transmission-pwgen.sh` to generate a password and rpc-password string.

## Example
This is an example:
```
pi@raspberry:~# ./transmission-pwgen.sh

plain_text_password = EOsJAezYIlESfYJ2
rpc_password_string = {93e2b099a0b96ed73bacc937f146826ed7f9b96a5VSE46DL
```
Transmission must be stopped before adding the rpc_password_string into settings.json. On Debian linux it works like this:

1. Stop transmission:
```
sudo service transmission-daemon stop
```
2. Edit `/etc/transmission-daemon/settings.json` and replace the rpc-password string:
```
"rpc-password": "{93e2b099a0b96ed73bacc937f146826ed7f9b96a5VSE46DL",
```
3. Start transmission:
```
sudo service transmission-daemon start
```
