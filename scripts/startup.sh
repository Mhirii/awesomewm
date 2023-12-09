#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
sh ~/.screenlayout/reddragon.sh
run nm-applet --indicator 
run blueman-applet 
# dunst &
# feh --bg-fill --randomize ~/.config/qtile/wallpapers/ &
run alacritty 
run xclip 
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
disown
# flameshot &
run copyq 
sleep 1

run megasync 
run telegram-desktop 
