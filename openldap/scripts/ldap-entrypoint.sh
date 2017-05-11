#!/bin/bash

ulimit -n 8192
current="$(cd "`dirname "$0"`"/..;pwd)"

if [ ! -f "/var/lib/ldap/DB_CONFIG" ]; then 
    cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
fi

exec "$@"
