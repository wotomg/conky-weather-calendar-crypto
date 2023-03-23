#!/bin/bash

DayOfMonth=`date +%_d`
DayOfWeek=`date +%a | head -c 2`
DefaultColor="\$color"
SelectingColor='${color0}'

cal | sed s/"$DayOfWeek"/"$SelectingColor$DayOfWeek$DefaultColor"/ | sed s/"\(^\|[^0-9]\)$DayOfMonth"'\b'/"\1$SelectingColor$DayOfMonth$DefaultColor"/
