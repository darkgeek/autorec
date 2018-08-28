#!/bin/sh

echo start ss...
/usr/bin/ss-local -c /root/private/shadowsocks/config.json &

echo start privoxy...
cd /etc/privoxy/
/usr/bin/privoxy --no-daemon
