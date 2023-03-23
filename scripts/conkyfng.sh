#!/usr/bin/env bash
data=$(curl --silent https://api.alternative.me/fng/ | tail -10 | head -2 | sed 's/.*\:\ \"//g' | sed 's/\"\,//g')

index=$(echo $data | cut -d " " -f1)
state=$(echo $data | cut -d " " -f2-3)

echo "\${alignc}\${font :size=20}$index\$font"
echo "\${alignc}$state\$font"