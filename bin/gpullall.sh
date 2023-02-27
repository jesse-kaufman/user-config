#!/bin/bash

for FILE in fo-*;
do
echo $FILE;
cd $FILE
git pull
cd ../
done

