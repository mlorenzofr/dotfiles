#!/bin/bash

internal='eDP-1'
internal_res='1600x900' # previous 1920x1080
screen_top_left='DP-2-2'
screen_top_right='DP-2-1'
screen_above="DP-2"

/usr/bin/xrandr --verbose --output "${internal}" --mode "${internal_res}"

# Temporal with 2 hubs
# /usr/bin/xrandr --output "DP-1" --auto --above eDP-1 --output "DP-2-1" --auto --right-of DP-1 --output eDP-1 --primary

if /usr/bin/xrandr --listmonitors | grep -q "${screen_top_left}"; then
  /usr/bin/xrandr --output "${screen_top_right}" --auto --right-of "${screen_top_left}" \
                  --output "${screen_top_left}" --auto \
                  --output "${internal}" --below "${screen_top_left}" --primary
else
  /usr/bin/xrandr --output "${screen_above}" --auto --above "${internal}"
fi
