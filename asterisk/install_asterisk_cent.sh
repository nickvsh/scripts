#!/bin/bash
ast_version=certified/13.13
version_dahdi_tool=v2.11.1
version_dahdi_linux=v2.11.1

#yum update -y #&& reboot
#yum install -y bzip2 epel-release dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel
#
#mkdir -p /usr/local/src/asterisk && cd /usr/local/src/asterisk
#wget http://pjsip.org/release/2.6/pjproject-2.6.tar.bz2
#tar jxvf pjproject-2.6.tar.bz2
#cd pjproject-2.6
#./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
#make dep && make && make install #&& ldconfig && ldconfig -p | grep pj

#Dahdi-linux
#mkdir -p /usr/local/src/dahdi 
#yum update -y && yum install kernel-devel-`uname -r` -y #&& reboot ?????
#cd /usr/local/src/dahdi && git clone https://github.com/asterisk/dahdi-linux.git linux
#cd linux*
#make && make install
#Dahdi-tools
#yum -y install autoconf automake libtool
#cd /usr/local/src/dahdi && git clone https://github.com/asterisk/dahdi-tools.git tools 
#cd tools*
#autoreconf -i
#./configure #--libdir=/usr/lib64
#make && make install


#LibPRI


#Asterisk
#Download source
cd /usr/local/src
git clone -b $ast_version https://github.com/asterisk/asterisk.git $ast_version
#wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.13-current.tar.gz && tar xvf asterisk-certified-13.*.tar.gz &&
cd $ast_version
./configure
make menuselect
make && make install && make config
#./configure --libdir=/usr/lib64 #&& make menuselect && make && make install && make samples && make config


