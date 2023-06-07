#!/bin/bash

swww query || swww init
wallpaper=$(find ~/Downloads/wallpaper/ -type f | shuf --random-source=/dev/urandom -n 1)
swww img $wallpaper --transition-type random
