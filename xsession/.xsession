#!/bin/sh
setxkbmap -option ctrl:nocaps
xrandr --dpi 192
xrdb -merge /home/mckinley/.Xresources
exec i3
