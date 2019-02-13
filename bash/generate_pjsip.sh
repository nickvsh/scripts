#!/bin/bash

DN=$1

cat << EOF
[$DN](endpoint-cisco-7912)
aors=$DN

[$DN](aor-basic)
; ---------------------
EOF
