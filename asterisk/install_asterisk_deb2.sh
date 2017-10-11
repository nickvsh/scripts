#!/bin/bash
apt update -y && apt upgrade -y 
#&& reboot
apt-get install -y build-essential linux-headers-`uname -r` openssh-server apache2 mysql-server\
  mysql-client bison flex php5 php5-curl php5-cli php5-mysql php-pear php-db php5-gd curl sox\
  libncurses5-dev libssl-dev libmysqlclient-dev mpg123 libxml2-dev libnewt-dev sqlite3\
  libsqlite3-dev pkg-config automake libtool autoconf git subversion unixodbc-dev uuid uuid-dev\
  libasound2-dev libogg-dev libvorbis-dev libcurl4-openssl-dev libical-dev libneon27-dev libsrtp0-dev\
  libspandsp-dev libiksemel-dev libiksemel-utils libiksemel3 libmyodbc libncurses5-dev
sudo apt-get install libsqlite3-dev sqlite3 libjansson-dev libxml2-dev uuid-dev libncurses5-dev

mkdir -p /usr/src/asterisk && cd /usr/src/asterisk
wget http://pjsip.org/release/2.6/pjproject-2.6.tar.bz2
tar jxvf pjproject-2.6.tar.bz2

cd pjproject-2.6
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep && make && make install && ldconfig && ldconfig -p | grep pj

cd /usr/src/asterisk && wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.13-current.tar.gz && tar xvf asterisk-certified-13.*.tar.gz && cd asterisk-certified-13.*

./configure --libdir=/usr/lib64 && make menuselect && make && make install && make samples && make basic-config
