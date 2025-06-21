#!/usr/bin/env bash

# get the main keyboard device name
kb=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name')

# switch to next layout
hyprctl switchxkblayout "$kb" next

# get the active layout name
layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name=="'"$kb"'") | .active_keymap')

# notify via hyprpanel (fallback to notify-send if needed)
hyprctl notify -1 1500 0 "Layout: $layout"
