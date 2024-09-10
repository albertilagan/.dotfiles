#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

clear() {
  sketchybar --set $NAME icon=$BELL icon.color=$WHITE
}

alert() {
  sketchybar --set $NAME icon=$BELL_DOT icon.color=$BLACK background.color=$RED
}

update() {

  RES=$(lsappinfo -all list | grep discord)

  if [[ "$RES" == *"label\"=\"\""* ]] || [[ "$RES" == "" ]]; then
    clear
  else
    alert
  fi
}


case "$SENDER" in
  "routine"|"forced") update
  ;;
esac
