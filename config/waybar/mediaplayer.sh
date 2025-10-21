#!/bin/sh

spotifystatus=$(playerctl -p spotify status)
if [ -z "$spotifystatus" ]; then
    echo "{\"text\": \"\",\"class\": \"mediaplayer\"}"
    exit 0
fi

icon=""
if [ "$spotifystatus" = "Playing" ]; then
    icon=""
elif [ "$spotifystatus" = "Paused" ]; then
    icon=""
fi

track=$(playerctl -p spotify metadata --format '{{ title }} - {{ artist }}')


echo "{\"text\": \"$icon $track \", \"class\": \"mediaplayer\"}"
exit 0
