#!/bin/bash

if wpctl status | grep \* | grep -q 56.; then
    wpctl set-default 45 # Headset
else
    wpctl set-default 56 # Speakers
fi
