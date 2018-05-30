#!/bin/bash
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
