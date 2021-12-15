#!/bin/bash


discord &disown
spotify &disown
whatsapp &disown
albert	&disown
function link-usb() {
	if [[ `ls /run/media/$USER/` == "" ]]
	then
		rm -r $HOME/USB
		return
	fi
	if [[ ! -d $HOME/USB ]]
	then
		mkdir $HOME/USB
	fi
	if [[ ! `ls $HOME/USB` == "" ]]
	then
		unlink $HOME/USB/*
	fi

	for d in /run/media/$USER/* 
	do 
		ln -s  $d $HOME/USB/
	done	
}
while true; do
    link-usb
    sleep 2
done &

xbindkeys
sleep 10
xkbcomp /home/gibi/.xkbmap $DISPLAY &> /home/gibi/.keybind.log
inputplug -d -c ~/.on-new-kbd.sh &disown
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false
