#!/usr/bin/env bash

$HOME/.bin/screen.sh &

function disable-accel() {
    while true; do
        for id in $(xinput list | grep "pointer" | cut -d '=' -f 2 | cut -f 1); do
            xinput --set-prop "$id" 'libinput Accel Profile Enabled' 0, 1
        done
        sleep 20
    done
}
disable-accel &
blueman-applet &
nm-applet &
pasystray &
killall -KILL emacs &
# xscreensaver -no-splash &
$HOME/.bin/screensaverd &
$HOME/.onStartup.sh &

sleep 1
feh "$HOME/.local/share/dwm/background.png" --bg-scale &
