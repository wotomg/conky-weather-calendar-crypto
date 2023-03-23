#!/bin/bash

#Day of month
DOM=`date +%_d`
#Day of week
DOW=`date +%a | head -c 2`
#Conky default text color
DC="\$color"
#Selection color
SC='${color0}'

cal | sed s/"$DOW"/"$SC$DOW$DC"/ | sed s/"\(^\|[^0-9]\)$DOM"'\b'/"\1$SC$DOM$DC"/
