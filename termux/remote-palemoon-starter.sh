#!/data/data/com.termux/files/usr/bin/sh

cd $HOME

echo copy .Xauthority to proot distro inside
cp .Xauthority ../usr/var/lib/proot-distro/installed-rootfs/archlinux/home/justin && echo Done.

echo Start palemoon...
curl http://127.0.0.1:9900/palemoon/DISPLAY=localhost:10.0/PULSE_SERVER=127.0.0.1 && printf "\nDone.\n"

running_pid=`pgrep -x palemoon`
echo Palemoon is running as PID $running_pid.

# wait until running_pid is exited
tail --pid=$running_pid -f /dev/null
echo Palemoon has exited. Bye.
