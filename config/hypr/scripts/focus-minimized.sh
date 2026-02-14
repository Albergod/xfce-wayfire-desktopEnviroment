#!/bin/bash

MINIMIZED_WS=$(hyprctl workspaces -j 2>/dev/null | jq -r '.[] | select(.name == "special:minimized").id // empty')

if [ -z "$MINIMIZED_WS" ]; then
    hyprctl dispatch togglespecialworkspace minimized
    exit 0
fi

CURRENT=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id')

WINDOW_LIST=$(hyprctl clients -j 2>/dev/null | jq -r \
    '.[] | select(.workspace.name == "special:minimized") | "\(.pid) | \(.class) - \(.title)"')

if [ -z "$WINDOW_LIST" ]; then
    exit 0
fi

SELECTED=$(echo "$WINDOW_LIST" | fuzzel --dmenu --prompt="minimized: ")

if [ -z "$SELECTED" ]; then
    exit 0
fi

PID=$(echo "$SELECTED" | awk '{print $1}')

hyprctl dispatch focuswindow pid:"$PID"
hyprctl dispatch movetoworkspace "$CURRENT"
