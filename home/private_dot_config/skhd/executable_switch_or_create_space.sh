#!/bin/bash

# The space number to switch to or create
SPACE_NUM=$1

# Check if the space exists
if yabai -m query --spaces --space $SPACE_NUM; then
    # If space exists, focus on it
    yabai -m space --focus $SPACE_NUM
else
    # If space does not exist, create it and then focus on it
    yabai -m space --create
    yabai -m space --focus $(yabai -m query --spaces | jq 'length')
fi

