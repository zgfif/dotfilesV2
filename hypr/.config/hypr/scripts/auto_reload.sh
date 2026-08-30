#!/usr/bin/bash

# restart waybar if there is a change
# in ~/.config/waybar file.
while inotifywait -e close_write ~/.config/waybar; do
	killall -USR2 waybar;
done
