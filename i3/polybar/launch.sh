#!/usr/bin/env sh

# Terminate already running bar instances
pkill polybar

# Wait for all to close
while pgrep 'polybar' > /dev/null; do 0; done

# Get all connected monitors
screens=$(xrandr --query | grep ' connected' | cut -d' ' -f1)

# Loop through all screens
for m in $screens; do
    # Start polybar and fork it
    MONITOR=$m polybar --reload --config=/home/holo/.config/i3/polybar/config.ini primary &
done
