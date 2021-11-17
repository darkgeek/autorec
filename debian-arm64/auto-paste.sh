#!/bin/sh

echo "Input anything, Paste anywhere:"
read user_input
echo -n "$user_input" | xclip -selection clipboard
xdotool windowminimize --sync $(xdotool getactivewindow)
sleep 1
xdotool key ctrl+v
