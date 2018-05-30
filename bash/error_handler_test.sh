#!/bin/sh

cp /Volumes/Documents/criticalfile.txt /Volumes/BackUp/.
if [ "$?" -ne "0" ];
then
 echo "[ERROR] copy failed" 1>&2
 exit 1
fi
