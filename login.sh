#!/bin/bash

run() {
    systemd-run --user --collect "$@" &
}

run steam -silent
run discord --start-minimized
# handled via openrgb
# run openrgb --profile "white1"
(sleep 30 && run flatpak run com.ktechpit.whatsie) &
