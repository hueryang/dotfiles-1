#!/bin/sh
xrandr --output DP1 --primary --mode 1920x1080 --pos 0x315 --rotate normal \
	--output HDMI1 --off \
	--output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate left  \
	--output HDMI3 --off  
