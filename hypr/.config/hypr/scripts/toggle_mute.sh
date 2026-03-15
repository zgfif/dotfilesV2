#!/usr/bin/bash

# toggle muted 
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# get status of volume
status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# assign "Volume 0.2 [MUTED]" to varibales:
read -r var1 var2 var3 <<< $status


if [[ $var3 = '[MUTED]' ]]; then

    # send notification with "muted" message
    dunstify \
        -a volume \
        -r 1 \
        -t 1500 \
        -i audio-volume-muted-symbolic \
        'muted'

else
    # convert 0.2 to 20
    vol=$(awk -v num="$var2" 'BEGIN {print num * 100}')
    
    dunstify \
            -a volume \
            -r 1 \
            -t 1500 \
            -i audio-volume-medium-symbolic \
            -h int:value:$vol \
            'unmute'
fi

