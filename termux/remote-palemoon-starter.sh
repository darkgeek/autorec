#!/data/data/com.termux/files/usr/bin/sh

cd $HOME

echo copy .Xauthority to proot distro inside
cp .Xauthority ../usr/var/lib/proot-distro/installed-rootfs/archlinux/home/justin && echo Done.

echo Start palemoon...
curl http://127.0.0.1:9900/palemoon/DISPLAY=localhost:10.0/PULSE_SERVER=127.0.0.1

while [ true ]
do
    pgrep -x palemoon > /dev/null
    if [ $? -ne 0 ]; then
        echo \npalemoon has exited. Bye.
        exit 0
    fi
    sleep 2
done
