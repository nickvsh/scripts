#!/bin/bash

yum install ntp && ntpdate pool.ntp.org && systemctl enable ntpd && systemctl start ntpd

useradd asterisk && passwd asterisk
chown -R asterisk:asterisk {/var/run, /var/spool, /var/lib,/var/log}/asterisk

