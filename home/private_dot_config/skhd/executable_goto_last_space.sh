#!/bin/bash

# Get the number of the last space
LAST_SPACE=$(yabai -m query --spaces | jq 'max_by(.index) | .index')

# If not, focus on the last space
yabai -m space --focus $LAST_SPACE

