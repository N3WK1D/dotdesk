#!/bin/bash

run() {
if ! pgrep -f "$1"; then
    "$@" &
else
    killall "$1"
    "$@" &
fi
}

run "polybar" "main"
run "conky"
run "mpd"
