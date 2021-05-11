#!/data/data/com.termux/files/usr/bin/bash

function check-if-running-foreground {
    dumpsys window windows | grep -E 'Window #[0-9]+ Window' | grep "$1"
}

function check-if-running-background {
    ps auxww | grep "$1" | grep -v grep
}

function kill-app {
    /system/bin/am force-stop "$1"
}

HOME=/data/data/com.termux/files/home
LOG_FILE="$HOME/bad-apps-state.log"
BAD_APPS=("com.eg.android.AlipayGphone" "com.autonavi.minimap" "com.tencent.mobileqq" "com.netease.cloudmusic" "com.taobao.taobao")

for app in "${BAD_APPS[@]}"
do
    check-if-running-foreground "$app"
    is_running_foreground=$?

    if [ $is_running_foreground -eq 0 ];then
        echo `date "+%F %R"` "$app is running foreground, keep it there." >> $LOG_FILE
        continue
    fi

    check-if-running-background "$app"
    is_running_background=$?

    if [ $is_running_background -eq 0 ];then
        echo `date "+%F %R"` "$app is running in background while no visible activity, kill it." >> $LOG_FILE
        kill-app "$app"
    fi
done
