#!/data/data/com.termux/files/usr/bin/bash

function check-if-running-foreground {
    dumpsys window windows | grep "$1"
}

function check-if-running-background {
    ps -A | grep "$1"
}

function kill-app {
    am force-stop "$1"
}

HOME=/data/data/com.termux/files/home
LOG_FILE="$HOME/bad-apps-state.log"
BAD_APPS=("com.eg.android.AlipayGphone" "com.autonavi.minimap")

echo "`date` ==> Starting detecting bad apps running states..." >> $LOG_FILE

for app in "${BAD_APPS[@]}"
do
    check-if-running-foreground "$app"
    is_running_foreground=$?

    if [ $is_running_foreground -eq 0 ];then
        echo "$app is running foreground, keep it there." >> $LOG_FILE
        continue
    fi

    check-if-running-background "$app"
    is_running_background=$?

    if [ $is_running_background -eq 0 ];then
        echo "$app is running in background while no visible activity, kill it." >> $LOG_FILE
        kill-app "$app"
    fi
done

echo "`date` ==> Done." >> $LOG_FILE
