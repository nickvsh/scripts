#!/bin/bash
wget -O - https://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add -
 
echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.6/ jessie main" > /etc/apt/sources.list.d/freeswitch.list
apt-get update
apt-get install -y --force-yes freeswitch-video-deps-most
 
# because we're in a branch that will go through many rebases it's
# better to set this one, or you'll get CONFLICTS when pulling (update)
git config --global pull.rebase true
 
# then let's get the source. Use the -b flag to get a specific branch
#Compile
cd /usr/src/
git clone https://freeswitch.org/stash/scm/fs/freeswitch.git -bv1.6 freeswitch
cd freeswitch
./bootstrap.sh -j
./configure
make
make install

echo create user 'freeswitch'
# create user 'freeswitch'
# add it to group 'freeswitch'
echo change owner and group of the freeswitch installation
# change owner and group of the freeswitch installation
#cd /usr/local
#groupadd freeswitch
#adduser --quiet --system --home /usr/local/freeswitch --gecos "FreeSWITCH open source softswitch" --ingroup freeswitch freeswitch --disabled-password
#chown -R freeswitch:freeswitch /usr/local/freeswitch/
#chmod -R ug=rwX,o= /usr/local/freeswitch/
#chmod -R u=rwx,g=rx /usr/local/freeswitch/bin/*
