#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.color=$WHITE
  icon.padding_left=5
  icon.padding_right=5
  icon.width=30
  padding_right=2
  padding_left=2
  label.drawing=on
  label.color=$WHITE
  label.padding_left=0
  label.padding_right=5
  update_freq=120
  background.color=$CAT
  background.border_color=$CAT
  background.height=23
  background.drawing=on
  updates=on
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
