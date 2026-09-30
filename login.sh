#!/bin/bash

# systemd-run --user steam -silent &
systemd-run --user discord --start-minimized &
openrgb --profile "white1" &
