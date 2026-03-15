#!/usr/bin/bash 


# decrease brightness on 5%
brightnessctl -e4 -n2 set 5%- 1> /dev/null


# get brightness in %
brightness=$(( $(brightnessctl g) * 100 / $(brightnessctl m) ))

# show notification
notify-send \
    -r 1 \
    -a 'volume' \
    -h int:value:$brightness \
    -t 1500 \
    -i display-brightness-symbolic \
    "Brightness"

