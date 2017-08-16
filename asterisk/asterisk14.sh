#!/bin/bash
prefix=/usr/local/VoIP
mkdir -p $prefix
cd $prefix
wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-14-current.tar.gz
wget https://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
wget https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz

tar zxvf asterisk*.tar.gz
tar zxvf libpri*.tar.gz
tar zxvf dahdi-linux-comlete*.tar.gz

cd dahdi-linux-complete*
make && make install && make config
cd libpri*
make && make install
cd asterisk*
./configure --with-pjproject-bundled
