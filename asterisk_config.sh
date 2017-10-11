#!/bin/bash

#yum install ntp && ntpdate pool.ntp.org && systemctl enable ntpd && systemctl start ntpd
#adduser --system --home /usr/sbin --no-create-home --disabled-password  --group asterisk --gecos "Asterisk PBX user"

#cd ~/src/asterisk-complete/asterisk/11
#for f in acl manager udptl features ccss res_stun_monitor smdi; do
#cp configs/$f.conf.sample /etc/asterisk/$f.conf;
#done

chown -R asterisk:asterisk {/var/run,/var/spool,/var/lib,/var/log}/asterisk
#chown -R root:asterisk /etc/asterisk
