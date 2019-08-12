#!/bin/bash

DN=$1
NAME=$2

cat << EOF
[$DN](endpoint-cisco-7912)
aors=$DN
callerid="$NAME" <$DN>
[$DN](aor-basic)
; ---------------------
EOF
