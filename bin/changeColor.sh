#!/bin/bash
# The line above has to be bash (not sh) because we're using the printf builtin

#First, get the name of the most recent Adafruit serial device connected
#Conveniently linux helps us by grouping them by manufacturer id
#Mac doesn't so we just take the most recently added serial device overall

DEVNAME=`ls -1t /dev/cu.usb* | head -1`
if [[ -z "$DEVNAME" ]]; then
    echo "No Serial Device Found"
    exit
fi
FULLDEVPATH=$DEVNAME

text=$@

if [[ -z "$text" ]]; then
    echo "Usage: colorChange.sh <Text To Send>"
    exit
fi

#Comment this to remove debug text
echo "Sending text '$text' to serial device"

printf "%b\r" $text > $FULLDEVPATH
