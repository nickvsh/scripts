#!/bin/bash

SEP=$1
DN=$2
name_en=$3
name_ukr=$4
cgroup=$5
pgroup=$6

#/Users/nickvsh/git/scripts/bash/generate_sccp_device.sh $SEP $DN $name_en "$name_ukr" $cgroup $pgroup  
/Users/nickvsh/git/scripts/bash/generate_sccp_line.sh $SEP $DN $name_en "$name_ukr" $cgroup $pgroup  
