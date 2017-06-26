#!/bin/bash
ast_version=certified/13.13

#apt-get -y install build-essential
#Dependences * v13
#apt-get -y install openssl libxml2-dev libncurses5-dev uuid-dev sqlite3 libsqlite3-dev pkg-config libjansson-dev
#Download source
cd /usr/local/src
#git clone -b $ast_version https://github.com/asterisk/asterisk.git
cd asterisk*
#need some temp dir
cp /tmp/menuselect.makeopts .
./configure
make && make install
make basic-pbx


#Dahdi
apt install linux-headers-`uname -r`
