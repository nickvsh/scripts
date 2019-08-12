#!/bin/bash

SEP=$1
DN=$2
name_en=$3
name_ukr=$4
cgroup=$5
pgroup=$6

cat << EOF
[$DN](defaultline)
id = $DN
label = $DN
description = $name_ukr
cid_name = $name_ukr
cid_num = $DN

EOF
#callgroup = $cgroup
#pickupgroup = $pgroup
