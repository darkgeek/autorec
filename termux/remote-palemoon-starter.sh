#!/data/data/com.termux/files/usr/bin/sh

cd $HOME

echo copy .Xauthority to proot distro inside
cp .Xauthority ../usr/var/lib/proot-distro/installed-rootfs/archlinux/home/justin && echo Done.

echo Start palemoon...
curl http://127.0.0.1:9900/palemoon/DISPLAY=localhost:10.0/PULSE_SERVER=127.0.0.1 && printf "\nDone.\n"

running_pids=`pgrep -x palemoon`
echo Palemoon is running as PID $running_pids.

# wait until running_pids are all exited
for pid in "$running_pids"; do
    tail --pid=$pid -f /dev/null
done
echo Palemoon has exited. Bye.
