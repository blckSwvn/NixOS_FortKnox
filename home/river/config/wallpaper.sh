#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/pictures/wallpapers"
WALLPAPERS=("$WALLPAPER_DIR"/*)

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Pick a random wallpaper
NEW_WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

# Kill existing swaybg instances
# pkill swaybg 2>/dev/null

# Set wallpaper
if command -v swaybg >/dev/null 2>&1; then
    swaybg -i "$NEW_WALLPAPER" -m fill &
    NEW_PID=$!
else
    exit 1
fi

# Give it a moment to start
sleep 0.1

# Kill all other swaybg processes except the new one
for pid in $(pgrep swaybg); do
    if [ "$pid" -ne "$NEW_PID" ]; then
        kill "$pid"
    fi
done
