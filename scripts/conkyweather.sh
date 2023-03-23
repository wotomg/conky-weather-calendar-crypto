#!/bin/bash
town=`cat ~/.config/conky/config-town`
tmpdir=~/.config/conky/temp

weather=$(curl -s "https://wttr.in/$town?format=%c;%t*%C")

if [[ $? != 0 ]]; then
  echo "Network problem"
  exit
fi

pango-view --font="DejaVu Sans Book 35" \
    -qo $tmpdir/weather-icon.png --background=black \
    --foreground=white --margin=1px -t $(echo $weather| sed 's/\ .*//')


temperature=$(echo $weather | sed 's/.*\;//' | sed 's/\*.*//')
weatherdescription=$(echo $weather | sed 's/.*\*//')

echo $weatherdescription > $tmpdir/weatherdescription.txt
echo $temperature > $tmpdir/temperature.txt
