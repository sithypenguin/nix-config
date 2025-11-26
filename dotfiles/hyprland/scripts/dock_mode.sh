#!/usr/bin/env bash

# Check if laptop display is enabled
if hyprctl monitors | grep -q "eDP-1"; then
    # Currently undocked - switch to docked mode
    # Replace DP-1 and DP-2 with your actual monitor names
    hyprctl keyword monitor "DP-3,preferred,0x0,1.0"
    hyprctl keyword monitor "DP-5,preferred,1920x0,1.0"  # Adjust position based on DP-1 resolution
    hyprctl keyword monitor "eDP-1,disable"
    notify-send "Display Mode" "Switched to Docked Mode" -i video-display
else
    # Currently docked - switch to laptop mode
    hyprctl keyword monitor "eDP-1,preferred,0x0,1.0"
    hyprctl keyword monitor "DP-3,disable"
    hyprctl keyword monitor "DP-5,disable"
    notify-send "Display Mode" "Switched to Laptop Mode" -i computer
fi