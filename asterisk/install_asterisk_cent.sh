#!/bin/bash
#ast_version=certified/13.13
#version_dahdi_tool=v2.11.1
#version_dahdi_linux=v2.11.1

#yum update -y #&& reboot
#yum install -y bzip2 epel-release dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel
#
#mkdir -p /usr/local/src/asterisk && cd /usr/local/src/asterisk

#PJPROJECT
#wget http://pjsip.org/release/2.6/pjproject-2.6.tar.bz2
#tar jxvf pjproject-2.6.tar.bz2
#cd pjproject-2.6
#./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
#make dep && make && make install #&& ldconfig && ldconfig -p | grep pj

#Install SRTP
#
#cd /opt  
#wget https://downloads.sourceforge.net/project/srtp/srtp/1.4.4/srtp-1.4.4.tgz 
#tar zxvf srtp-1.4.4.tgz
#cd srtp 
#autoconf 
#./configure CFLAGS=-fPIC --prefix=/usr  
#make 
#make runtest
#make install
#ldconfig

#Install jansson
#
#cd /opt 
#wget http://www.digip.org/jansson/releases/jansson-2.7.tar.gz
#tar zvxf jansson-2.7.tar.gz 
#cd jansson-2.7
#autoreconf -i
#./configure --prefix=/usr/ --libdir=/usr/lib64
#make  
#make install 
#ldconfig

#Install Lame
#
#cd /opt 
#wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
#tar zxvf lame-3.99.5.tar.gz 
#cd lame-3.99.5
#./configure 
#make 
#make install

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
#_1. DAHDI-LINUX-COMPLETE
#cd dahdi-linux-complete-2.X.Y+2.X.Y
#make && make install && make config

#_2. LibPRI
#cd libpri-1.X.Y
#make && make install

#Asterisk
#adduser asterisk -M -c "Asterisk User"
#Download source
cd /usr/local/src
git clone -b $ast_version https://github.com/asterisk/asterisk.git $ast_version
#wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.13-current.tar.gz && tar xvf asterisk-certified-13.*.tar.gz &&
cd $ast_version
./configure
make menuselect
make && make install && make config
#./configure --libdir=/usr/lib64 #&& make menuselect && make && make install && make samples && make config

#Asterisk	https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-14-current.tar.gz
#libpri		https://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
#dahdi-linux	https://downloads.asterisk.org/pub/telephony/dahdi-linux/dahdi-linux-current.tar.gz
#dahdi-tools	https://downloads.asterisk.org/pub/telephony/dahdi-tools/dahdi-tools-current.tar.gz
#dahdi-complete	https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz


ast_version=certified/13.13
pj_version=2.6
yum update -y && reboot

yum install -y mlocate git vim bzip2 epel-release 
yum install -y dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel

mkdir -p /usr/src/voip && cd /usr/src/voip
wget http://pjsip.org/release/$pj_version/pjproject-$pj_version.tar.bz2
tar jxvf pjproject-*.tar.bz2
cd pjproject-$pj_version
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep && make && make install
ldconfig && ldconfig -p | grep pj > /tmp/install_info

cd /usr/src/voip
#wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.13-current.tar.gz && tar xvf asterisk-certified-13.*.tar.gz &&
#cd asterisk-certified-13.*

git clone -b $ast_version https://github.com/asterisk/asterisk.git $ast_version
cd asterisk*

./configure --libdir=/usr/lib64 && make menuselect && make && make install \
#&& make samples 
&& make config
