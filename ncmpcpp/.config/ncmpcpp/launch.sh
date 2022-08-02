#!/bin/bash
# Check for MPD daemon
if [[ ! -s ~/.config/mpd/pid ]]; then mpd; fi

# Start ncmpcpp
ncmpcpp
