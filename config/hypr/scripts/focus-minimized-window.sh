#!/usr/bin/env bash

FOCUSED=$(hyprctl activewindow -j 2>/dev/null)

if [ -z "$FOCUSED" ]; then
    exit 0
fi

WS=$(echo "$FOCUSED" | jq -r '.workspace')

if [[ "$WS" == special:* ]]; then
    exit 0
fi

hyprctl dispatch workspace "$WS"
