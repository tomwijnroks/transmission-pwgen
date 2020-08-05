# transmission-pwgen
Transmission password generator.

## About
The Transmission BitTorrent client uses a settings.json file where you can set a plain text password for the rpc (web) interface. After restarting transmission the plain text password will be changed to an encrypted password string. Transmission does not have a command line option to generate the encrypted password string in advance.

This script will generate a plain text password + the encrypted rpc-password string which can be used in the settings.json file.

## Usage
Download transmission-pwgen and make it executable:
```
curl -so transmission-pwgen.sh https://raw.githubusercontent.com/tomwijnroks/transmission-pwgen/master/transmission-pwgen.sh
chmod +x transmission-pwgen.sh
```
Execute `./transmission-pwgen.sh` to generate a password and rpc-password string.

## Example
Example output from transmission-pwgen:
```
plain_text_password = EOsJAezYIlESfYJ2
rpc_password_string = {93e2b099a0b96ed73bacc937f146826ed7f9b96a5VSE46DL
```
**Transmission must be stopped before adding the rpc-password string into settings.json.**

On Debian linux it works like this:

Stop transmission:
```
sudo service transmission-daemon stop
```
Edit `/etc/transmission-daemon/settings.json` and replace the rpc-password string:
```
"rpc-password": "{93e2b099a0b96ed73bacc937f146826ed7f9b96a5VSE46DL",
```
Start transmission:
```
sudo service transmission-daemon start
```
