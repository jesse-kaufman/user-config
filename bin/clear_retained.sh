#!/usr/bin/env bash
echo "cleaning $1 :: usage: cleanmqtt <host>"
mosquitto_sub -h "$1" -t "#" -v --retained-only | while
read -r line
do
    mosquitto_pub -h "$1" -t "${line% *}" -r -n
done
