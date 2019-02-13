#/bin/bash

unset IFS

mac=$1
dn=$2
name=$3

mkdir -p tmp_tftp_profiles
#/Users/nickvsh/git/scripts/bash/generate_tftp_profile.sh $dn $name > tmp_tftp_profiles/gk$mac
/Users/nickvsh/git/scripts/bash/generate_tftp_profile.sh $dn $name
