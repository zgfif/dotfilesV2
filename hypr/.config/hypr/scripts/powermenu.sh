#!/usr/bin/bash

options="Poweroff\nReboot\nLogout\nQuit"

option=$(
    echo -e $options |
    rofi -dmenu -p "" -i -theme-str 'window {width: 200px; height: 200px;}'
)

# echo $option

if [[ $option = 'Poweroff' ]]; then
    poweroff
elif [[ $option = 'Reboot' ]]; then
    reboot
elif [[ $option = 'Logout' ]]; then
    hyprctl dispatch exit
else
    exit 0
fi

