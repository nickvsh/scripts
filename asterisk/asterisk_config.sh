#!/bin/bash

#yum install ntp && ntpdate pool.ntp.org && systemctl enable ntpd && systemctl start ntpd
#adduser --system --home /usr/sbin --no-create-home --disabled-password  --group asterisk --gecos "Asterisk PBX user"
chown -R asterisk:asterisk {/var/run,/var/spool,/var/lib,/var/log}/asterisk

