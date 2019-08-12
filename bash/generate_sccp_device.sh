#!/bin/bash

SEP=$1
DN=$2
name_en=$3
name_ukr=$4
cgroup=$5
pgroup=$6

cat << EOF
[$SEP](7912)
description = $name_en 
button = line, $DN,default

EOF
