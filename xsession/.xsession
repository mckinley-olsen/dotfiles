if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
xrandr --dpi 192
xrdb -merge /home/mckinley/.Xresources
exec i3
