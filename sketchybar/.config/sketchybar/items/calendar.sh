#!/bin/bash

calendar=(
  icon=$CALENDAR
  icon.color=$WHITE
  icon.padding_left=5
  icon.padding_right=5
  label.align=right
  label.padding_left=0
  label.padding_right=5
  label.color=$WHITE
  background.color=$CAT
  background.border_color=$CAT
  background.height=23
  background.drawing=on
  padding_left=2
  padding_right=2
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke mouse.clicked
