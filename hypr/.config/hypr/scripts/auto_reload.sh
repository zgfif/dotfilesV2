#!/usr/bin/bash

# restart waybar if change code in ~/.config/waybar.

while inotifywait -e close_write ~/.config/waybar; do
	killall -USR2 waybar;
done

