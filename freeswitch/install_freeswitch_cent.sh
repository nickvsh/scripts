#!/bin/bash

#Disable SELINUX
#/bin/sed -i -e s,'SELINUX=enforcing','SELINUX=disabled', /etc/selinux/config

#Install FS repo for actual dependances
#yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm epel-release

#Install dependences
#yum install git autoconf automake libtool ncurses-devel libjpeg-devel sqlite-devel libcurl-devel pcre-devel speex-devel libedit-devel
#yum install gcc gcc-c++ 
#yum install -y git gcc-c++ wget alsa-lib-devel autoconf automake bison broadvoice-devel bzip2 curl-devel db-devel e2fsprogs-devel flite-devel g722_1-devel gdbm-devel gnutls-devel ilbc2-devel ldns-devel libcodec2-devel libcurl-devel libedit-devel libidn-devel libjpeg-devel libmemcached-devel libogg-devel libsilk-devel libsndfile-devel libtiff-devel libtheora-devel libtool libvorbis-devel libxml2-devel lua-devel lzo-devel mongo-c-driver-devel ncurses-devel net-snmp-devel openssl-devel opus-devel pcre-devel perl perl-ExtUtils-Embed pkgconfig portaudio-devel postgresql-devel python26-devel python-devel soundtouch-devel speex-devel sqlite-devel unbound-devel unixODBC-devel libuuid-devel which zlib-devel yasm nasm

#Install from packages
#yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm epel-release
#yum install -y freeswitch-config-vanilla freeswitch-lang-* freeswitch-sounds-*
#systemctl enable freeswitch

#Download sources
#mkdir -p /usr/local/src
#cd /usr/local/src
#git clone -b v1.6 https://freeswitch.org/stash/scm/fs/freeswitch.git freeswitch
#cd /usr/local/src/freeswitch
#./bootstrap.sh -j

#Select modules to compile
#cd /usr/local/src
#sed -i -e s,'#endpoints/mod_rtmp','endpoints/mod_rtmp', modules.conf
#sed -i 's/#applications\/mod_curl/applications\/mod_curl/' modules.conf
#sed -i 's/#asr_tts\/mod_flite/asr_tts\/mod_flite/' modules.conf

#mod_directory
#mod_callcenter
#mod_tts_commandline
#mod_dingaling
#mod_flite
#mod_shout
#mod_pocketsphinx
#mod_cidlookup
#mod_skypopen
#mod_curl
#mod_xml_curl

#Compile
#./configure
#make
#make install
#make cd-sounds-install
#make cd-moh-install
