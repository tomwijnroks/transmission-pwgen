#!/bin/bash
#
# https://github.com/tomwijnroks/transmission-pwgen

if [ -z $1 ]; then
    # Define the password length.
    PASSWORD_LENGTH=16

    # Generate a random password (alphanumeric).
    PASS=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${PASSWORD_LENGTH} | head -n1)
else
    PASS=$1
fi

# Generate a random salt (alphanumeric + two special characters).
# Source: https://github.com/transmission/transmission/blob/master/libtransmission/crypto-utils.c#L132-L136
SALT=$(cat /dev/urandom | tr -dc '[:alnum:]./' | fold -w 8 | head -n1)

# Combine password + salt and use sha1sum to create the hash.
HASH=$(echo -n ${PASS}${SALT} | sha1sum | awk '{print $1}')

if [ -z $1 ]; then
    # Print the plain text password.
    echo "plain_text_password = ${PASS}"

    # Print the rpc-password string: hash + salt prepended with a curly bracket.
    # Source: https://github.com/transmission/transmission/blob/master/libtransmission/crypto-utils.c#L153
    echo "rpc_password_string = {${HASH}${SALT}"
else
    #Print password hash
    echo "{${HASH}${SALT}"
fi
