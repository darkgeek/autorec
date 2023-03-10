#!/bin/sh

ssh -p 8925 justin@localhost -t "DISPLAY=$DISPLAY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS fcitx" &
