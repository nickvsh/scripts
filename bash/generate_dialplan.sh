#!/bin/bash

DN=$1
EXTEN='${EXTEN}'

cat << EOF
exten => $DN,1,GoSub(sub-call-dn,start,1(${EXTEN}))
EOF
