#!/bin/bash

subnet=$1

cat << EOF
subnet $subnet.0 netmask 255.255.255.0 {
  range $subnet.2 $subnet.50;
  option routers $subnet.1;
}
EOF
