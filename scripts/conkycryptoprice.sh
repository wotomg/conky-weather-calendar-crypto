#!/bin/bash

is_online(){
  ping=$(curl -s -X 'GET' 'https://api.coingecko.com/api/v3/ping' -H 'accept: application/json' | jq '.gecko_says' | sed 's/\"//g')
  if [[ $ping != "(V3) To the Moon!" ]]; then
    exit
  fi
}

get_price_coingecko(){
  price=`curl -s --compressed -X 'GET' \
  'https://api.coingecko.com/api/v3/simple/price?ids='$1'&vs_currencies=usd' \
  -H 'accept: application/json' | jq '.[].usd'`
  print_conky ${2^^} $price
}

print_conky(){
  echo "\${font}$1\${alignr}\${color0}$2\$color\${font :size=4}"
  echo "\${hr 1}\${font :size=1}"
}

#MAIN

is_online

#Cryptocurency list.
#cc='Btc ETH ltc xmr'
cc=`cat ~/.config/conky/config-cc`
coinslistjson=~/.config/conky/temp/coinslist.json

if [[ ! -f $coinslistjson ]]; then
  curl -s --compressed -o $coinslistjson "https://api.coingecko.com/api/v3/coins/list"
fi

ccid=''

for c in ${cc,,}; do
  id=$(cat $coinslistjson | jq '.[] | select(.symbol == "'$c'")' | jq '.id' | grep -v wormhole | grep -v wrapped | grep -v '\-peg\-' | sed 's/"//g')
  get_price_coingecko $id $c
done
