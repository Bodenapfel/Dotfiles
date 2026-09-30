#!/bin/bash

run() {
    systemd-run --user --collect "$@" &
}

run steam -silent
run discord --start-minimized
run openrgb --profile "white1"
