export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export AUDIODEVICE="snd@darkgeek-alpine-tiangong/0"
export PATH=$PATH:$HOME/Apps/bin:$HOME/bin:/usr/local/jdk-11/bin/

ulimit -c 0

#exec startxfce4 --with-ck-launch 

if [ -x /usr/local/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	eval `dbus-launch --sh-syntax --exit-with-x11`
fi
#/usr/local/bin/startlxqt
exec ck-launch-session mate-session
