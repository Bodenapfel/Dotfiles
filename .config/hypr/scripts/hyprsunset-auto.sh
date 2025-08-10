#!/usr/bin/env bash

TEMP=5000   # color temperature
ON_START=23 # hour to enable
ON_END=6    # hour to disable

while true; do
  HOUR=$(date +%H)

  if ((HOUR >= ON_START || HOUR < ON_END)); then
    # Time is within night range → start if not running
    if ! pgrep -x hyprsunset >/dev/null; then
      hyprsunset -t "$TEMP" &
    fi
  else
    # Time is outside night range → stop if running
    pkill -x hyprsunset
  fi

  sleep 300 # check every 5 minutes
done
