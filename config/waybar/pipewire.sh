#!/bin/zsh

info=$(eval "amixer get Master")
volume=$(echo $info | grep -o -E '[0-9]{1,3}%' | head -1)
mute=$(echo $info | grep -o -E '\[\w*\]' | head -1)

icon=""
if [[ $mute == "[off]" ]]; then
  icon=""
elif [[ $volume < 50 ]]; then
  icon=""
fi

echo "{\"text\": \"$icon $volume\",\"class\": \"volume\"}"