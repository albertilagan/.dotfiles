#!/bin/bash

clock=(
  icon=$CLOCK
  icon.color=$WHITE
  icon.padding_left=5
  icon.padding_right=0
  label.width=80
  label.align=left
  label.padding_left=-5
  label.padding_right=5
  label.color=$WHITE
  background.color=$CAT
  background.border_color=$CAT
  background.height=23
  background.drawing=on
  padding_left=2
  padding_right=2
  update_freq=1
  script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item clock right    \
           --set clock "${clock[@]}" \
           --subscribe clock system_woke
