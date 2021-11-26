#!/usr/bin/fish -l

echo "Input anything, Paste anywhere:"
read user_input
echo -n "$user_input" | xclip -selection clipboard
xdotool windowminimize --sync (xdotool getactivewindow)
sleep 0.5
xdotool key ctrl+v
#xvkbd -no-repeat -text "\Cv"
