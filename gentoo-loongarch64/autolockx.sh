#!/bin/sh

# config
# specify the screen activity idle timeout in millisecond, when this threshold is exceeded, we will invoke xlock to do locking
IDLE_TIMEOUT=900000
# end of config

current_idle=0
while true; do
    current_idle=`xprintidle`
    if [ $current_idle -gt $IDLE_TIMEOUT ]; then
        xlock -mode blank
        echo "I'm going to lock the screen."
    fi
    sleep 60
done
