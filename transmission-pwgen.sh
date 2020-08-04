#!/bin/bash
#
# https://github.com/tomwijnroks/transmission-pwgen

# Define the password length.
PASSWORD_LENGTH=16

# Generate a random password (alphanumeric).
PASS=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${PASSWORD_LENGTH} | head -n1)

# Generate a random salt (alphanumeric + two special chars).
# Source: https://github.com/transmission/transmission/blob/master/libtransmission/crypto-utils.c#L132-L136
SALT=$(cat /dev/urandom | tr -dc '[:alnum:]./' | fold -w 8 | head -n1)

# Combine password + salt and use shasum (sha1) to create the hash.
HASH=$(echo -n ${PASS}${SALT} | shasum -a1 | awk '{print $1}')

# Print the plain text password.
echo "plain_text_password = ${PASS}"

# Print the rpc-password string and prepend it with a curly bracket.
# Source: https://github.com/transmission/transmission/blob/master/libtransmission/crypto-utils.c#L153
echo "rpc_password_string = {${HASH}${SALT}"
