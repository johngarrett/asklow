#!/bin/bash

function print_ascii() {
    sed -n '/<table /,/<\/table>/p' <(curl -s http://www.asciiartfarts.com/random.cgi) | sed 1d | sed '$d'
}
function fromhex() {
  hex=$1
  if [[ $hex == "#"* ]]; then
    hex=$(echo $1 | awk '{print substr($0,2)}')
  fi
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})
  echo -e `printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))"`
}

FIRST_LINE=$(sed -n '/<table /,/<\/table>/p' <(curl -s http://www.asciiartfarts.com/random.cgi) | grep -m1 "" )

BG_COLOR=$(echo $FIRST_LINE | grep -oP 'bgcolor="\K[^"]+')
FONT_COLOR=$(echo $FIRST_LINE | grep -oP 'font color="\K[^"]+')
echo $bg_color
echo $font_color
#print_ascii

b=$(fromhex "#804040")
echo $b
#echo -e '\x1b[32mtest'
echo -e '\x1b[$b testing out some words\033[0m'
