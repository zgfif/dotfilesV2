!#/usr/bin/bash

# increase volume on 5%
wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
 
# get current volume. Example: "Volume: 0.20"
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
 
# assign the 0.20 to var2. 
read -r var1 var2 <<< $volume
   
# assign 0.2 * 100
vol=$(awk -v num="$var2" 'BEGIN {print num * 100}')
 
# echo $vol

notify-send \
    -a "volume" \
    -i audio-volume-high-symbolic \
    -h int:value:"$vol" \
    -r 1 \
    -t 1500 \
    "Volume $vol%"
