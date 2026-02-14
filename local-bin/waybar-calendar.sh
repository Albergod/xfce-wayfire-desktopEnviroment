#!/usr/bin/env bash
# Centered under the top bar, 360x320, with no title bar
width=360
height=320
screen_w=1920
x=$(( (screen_w - width) / 2 ))
y=50

exec yad --calendar \
  --undecorated \
  --skip-taskbar \
  --no-buttons \
  --width="$width" \
  --height="$height" \
  --posx="$x" \
  --posy="$y" \
  --borders=8 \
  --class=waybar-calendar
