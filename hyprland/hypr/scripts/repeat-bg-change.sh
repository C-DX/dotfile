#!/usr/bin/bash

while true; do
	wallpaper=$(find ~/Downloads/wallpaper/ -type f | shuf --random-source=/dev/urandom -n 1)
	swww img $wallpaper --transition-type random --transition-fps 120
	sleep 600
done
