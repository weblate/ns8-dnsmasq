#!/bin/sh

# first arg is `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- dnsmasq "$@"
fi

exec "$@"
