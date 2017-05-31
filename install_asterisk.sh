#!/bin/bash
#yum update -y && reboot
#yum install -y bzip2 
#yum install -y epel-release dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel

mkdir -p /usr/src/asterisk && cd /usr/src/asterisk
#wget http://pjsip.org/release/2.6/pjproject-2.6.tar.bz2
#tar jxvf pjproject-2.6.tar.bz2

#cd pjproject-2.6
#./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
#make dep && make && make install && ldconfig && ldconfig -p | grep pj
cd /usr/src/asterisk && wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.13-current.tar.gz && tar xvf asterisk-certified-13.*.tar.gz && cd asterisk-certified-13.*

#./configure --libdir=/usr/lib64 && make menuselect && make && make install #&& make samples #&& make config
