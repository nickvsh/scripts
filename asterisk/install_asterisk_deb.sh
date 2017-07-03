#!/bin/bash
ast_version=certified/13.13

apt-get -y install build-essential
#Dependences * v13
apt-get -y install openssl libxml2-dev libncurses5-dev uuid-dev sqlite3 libsqlite3-dev pkg-config libjansson-dev
#Download source
cd /usr/src
git clone -b $ast_version https://github.com/asterisk/asterisk.git $ast_version
cd asterisk*
#need some temp dir
cp /home/nickvsh/scripts/asterisk/menuselect.makeopts .
./configure
make && make install
#make basic-pbx
#mkdir -p cd /etc/asterisk && 
cd /etc/asterisk
git clone https://github.com/nickvsh/aster_configs
