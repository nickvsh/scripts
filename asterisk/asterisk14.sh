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

cd asterisk*/contrib/scripts/install_prereq install

cd dahdi-linux-complete*
make && make install && make config
cd libpri*
make && make install
cd asterisk*
./configure --with-pjproject-bundled #--libdir=/usr/lib64
make menuselect
make && make install && make config

#* config
useradd -M asterisk -D /usr/lib/asterisk #&& passwd asterisk
chown -R asterisk:asterisk {/var/run,/var/spool,/var/lib,/var/log}/asterisk
chown -R root:asterisk /etc/asterisk
chmod g+w root:asterisk /etc/asterisk

