#!/usr/bin/env bash

shopt -s nocasematch

OIFS="$IFS"
IFS=$'\n'
for file in *.*
do
    if [[ $file =~ (jp[e]*g|png|webp|heic)$ ]]
    then
        echo "$file"
        magick "$file" -quality 75 "$file.jxl"
    fi
done
IFS="$OIFS"
