#!/bin/bash

CIS_name="CIS Debian Linux 9 Benchmark v1.0.0 - 12-21-2018"
OK='\e[32mOK\e[0m'
BAD='\e[31mFALSE\e[0m'
status_OK=0
status_BAD=0
total_score=0
scored=0
cis_log_file=run_cis_date.log #how to redirect stderr to this file?
# status_log_file=run_cis_status_date.log #how to redirect stdout to this file?

if [ `echo $(whoami)` != root ]; then
# if [ `echo $(whoami)` != pzu-rescue ]; then
	echo "Not enough privileges. Please, run script as root or with sudo"
	exit 127
fi

rm $cis_log_file #delete prev log file
#declare -a array=("line1" "str2" "str3")
cis_text=(
"1	Initial Setup\n
\t 1.1	Filesystem Configuration\n
\t\t 1.1.1	Disable unused filesystems\n
\t\t\t 1.1.1.1 Ensure mounting of freevxfs filesystems is disabled (Scored)"
"\t\t\t 1.1.1.2 Ensure mounting of jffs2 filesystems is disabled (Scored)"
"\t\t\t 1.1.1.3 Ensure mounting of hfs filesystems is disabled (Scored)"
"\t\t\t 1.1.1.4 Ensure mounting of hfsplus filesystems is disabled (Scored)"
"\t\t\t 1.1.1.5 Ensure mounting of udf filesystems is disabled (Scored)"
"\t\t 1.1.2 Ensure /tmp is configured (Scored)"
"\t\t 1.1.3 Ensure nodev option set on /tmp partition (Scored)"
"\t\t 1.1.4 Ensure nosuid option set on /tmp partition (Scored)"
"\t\t 1.1.5 Ensure noexec option set on /tmp partition (Scored)"
"\t\t 1.1.6 Ensure separate partition exists for /var (Scored)"
"\t\t 1.1.7 Ensure separate partition exists for /var/tmp (Scored)"
"\t\t 1.1.8 Ensure nodev option set on /var/tmp partition (Scored)"
"\t\t 1.1.9 Ensure nosuid option set on /var/tmp partition (Scored)"
"\t\t 1.1.10 Ensure noexec option set on /var/tmp partition (Scored)"
"\t\t 1.1.11 Ensure separate partition exists for /var/log (Scored)"
"\t\t 1.1.12 Ensure separate partition exists for /var/log/audit (Scored)"
"\t\t 1.1.13 Ensure separate partition exists for /home (Scored)"
"\t\t 1.1.14 Ensure nodev option set on /home partition (Scored)"
"\t\t 1.1.15 Ensure nodev option set on /dev/shm partition (Scored)"
"\t\t 1.1.16 Ensure nosuid option set on /dev/shm partition (Scored)"
"\t\t 1.1.17 Ensure noexec option set on /dev/shm partition (Scored)"
"\t\t 1.1.22 Disable Automounting (Scored)"
"\t	1.2 Configure Software Updates\n
\t\t	1.2.1 Ensure package manager repositories are configured (Not Scored)"
"\t\t 1.2.2 Ensure GPG keys are configured (Not Scored)"
"\t	1.4 Secure Boot Settings\n
\t\t	1.4.1 Ensure permissions on bootloader config are configured (Scored)"
"\t\t 1.4.2 Ensure bootloader password is set (Scored)"
"\t\t 1.4.3 Ensure authentication required for single user mode (Scored)"
"\t	1.5 Additional Process Hardening\n
\t\t	1.5.1 Ensure core dumps are restricted (Scored)"
"\t\t	1.5.3 Ensure address space layout randomization (ASLR) is enabled (Scored)"
"\t 1.7 Warning Banners\n
\t\t	1.7.1 Command Line Warning Banners\n
\t\t\t	1.7.1.1 Ensure message of the day is configured properly (Scored)"
"\t\t\t 1.7.1.2 Ensure local login warning banner is configured properly (Scored)"
"\t\t\t 1.7.1.3 Ensure remote login warning banner is configured properly (Scored)"
"\t\t\t 1.7.1.4 Ensure permissions on /etc/motd are configured (Scored)"
"\t\t\t 1.7.1.5 Ensure permissions on /etc/issue are configured (Scored)"
"\t\t\t 1.7.1.6 Ensure permissions on /etc/issue.net are configured (Scored)"
"3 Network Configuration\n
\t 3.1 Network Parameters (Host Only)\n
\t\t\t 3.1.1 Ensure IP forwarding is disabled (Scored)"
"\t\t\t 3.1.2 Ensure packet redirect sending is disabled (Scored)"
"\t 3.2 Network Parameters (Host and Router)\n
\t\t	3.2.1 Ensure source routed packets are not accepted (Scored)"
"\t\t	3.2.2 Ensure ICMP redirects are not accepted (Scored)"
"\t\t	3.2.3 Ensure secure ICMP redirects are not accepted (Scored)"
"\t\t	3.2.4 Ensure suspicious packets are logged (Scored)"
"\t\t	3.2.5 Ensure broadcast ICMP requests are ignored (Scored)"
"\t\t	3.2.6 Ensure bogus ICMP responses are ignored (Scored)"
"\t\t	3.2.7 Ensure Reverse Path Filtering is enabled (Scored)"
"\t\t	3.2.8 Ensure TCP SYN Cookies is enabled (Scored)"
"\t\t	3.2.9 Ensure IPv6 router advertisements are not accepted (Scored)"
"\t 3.3 TCP Wrappers\n
\t\t 3.3.1 Ensure TCP Wrappers is installed (Scored)"
"\t\t 3.3.2 Ensure /etc/hosts.allow is configured (Not Scored)"
"\t\t 3.3.3 Ensure /etc/hosts.deny is configured (Not Scored)"
"\t\t 3.3.4 Ensure permissions on /etc/hosts.allow are configured (Scored)"
"\t\t 3.3.5 Ensure permissions on /etc/hosts.deny are configured (Scored)"
# "\t 3.4 Uncommon Network Protocols
# \t\t 3.4.1 Ensure DCCP is disabled (Not Scored)"

# "\t "
# "\t\t "
#UP
# "\t\t\t "

)

# 'echo -e "#CIS-${cis_number[1]}\n""install #1 /bin/true" > /etc/modprobe.d/command1.conf'
# 'echo -e "#CIS-1.1.1.1\n" "install freevxfs /bin/true" > /etc/modprobe.d/freevxfs.conf'

cis_command=(
'scored=true
fs=freevxfs
echo -e "#--- CIS-1.1.1.1 ---\n install $fs /bin/true" > /etc/modprobe.d/$fs.conf;
rmmod $fs > /dev/null 2>&1;
modprobe -n -v $fs | egrep -w "install /bin/true" > /dev/null 2>&1
'
'scored=true
fs=jffs2
echo -e "#--- CIS-1.1.1.2 ---\n install $fs /bin/true" > /etc/modprobe.d/$fs.conf;
rmmod $fs > /dev/null 2>&1;
modprobe -n -v $fs | egrep -w "install /bin/true" > /dev/null 2>&1
'
'scored=true
fs=hfs
echo -e "#--- CIS-1.1.1.3 ---\n install $fs /bin/true" > /etc/modprobe.d/$fs.conf;
rmmod $fs > /dev/null 2>&1;
modprobe -n -v $fs | egrep -w "install /bin/true" > /dev/null 2>&1
'
'scored=true
fs=hfsplus
echo -e "#--- CIS-1.1.1.4 ---\n install $fs /bin/true" > /etc/modprobe.d/$fs.conf;
rmmod $fs > /dev/null 2>&1;
modprobe -n -v $fs | egrep -w "install /bin/true" > /dev/null 2>&1
'
'scored=true
fs=udf
echo -e "#--- CIS-1.1.1.5 ---\n install $fs /bin/true" > /etc/modprobe.d/$fs.conf;
rmmod $fs > /dev/null 2>&1;
modprobe -n -v $fs | egrep -w "install /bin/true" > /dev/null 2>&1
'
'scored=true
touch /etc/systemd/system/tmp.mount
cat << EOF > /etc/systemd/system/tmp.mount
# --- CIS-1.1.2 ---
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

[Unit]
Description=Temporary Directory
Documentation=man:hier(7)
Documentation=http://www.freedesktop.org/wiki/Software/systemd/APIFileSystems
ConditionPathIsSymbolicLink=!/tmp
DefaultDependencies=no
Conflicts=umount.target
Before=local-fs.target umount.target
After=swap.target

[Mount]
What=tmpfs
Where=/tmp
Type=tmpfs
Options=mode=1777,strictatime,noexec,nodev,nosuid,relatime,size=512000000

[Install]
WantedBy=local-fs.target
EOF
systemctl daemon-reload
systemctl unmask tmp.mount
systemctl enable tmp.mount
systemctl start tmp.mount
systemctl is-enabled tmp.mount && mount | grep -w /tmp
'
'scored=true
mount | grep -w /tmp | grep -w nodev
'
'scored=true
mount | grep -w /tmp | grep -w nosuid
'
'scored=true
mount | grep -w /tmp | grep -w noexec
'
'scored=true
mount | grep -w /var
'
'scored=true
mount | grep -w /var/tmp
'
'scored=true
mount | grep -w /var/tmp | grep -w nodev
'
'scored=true
mount | grep -w /var/tmp | grep -w nosuid
'
'scored=true
mount | grep -w /var/tmp | grep -w noexec
'
'scored=true
mount | grep -w /var/log
'
'scored=true
mount | grep -w /var/log/audit
'
'scored=true
mount | grep -w /home
'
'scored=true
mount | grep -w /home | grep -w nodev
'
'scored=true
echo "tmpfs /dev/shm tmpfs nosuid,nodev,noexec,relatime" >> /etc/fstab
umount /dev/shm
mount -a && mount | grep -w /dev/shm | grep -w nodev
'
'scored=true
mount | grep -w /dev/shm | grep -w nosuid
'
'scored=true
mount | grep -w /dev/shm | grep -w noexec
'
'scored=true
dpkg -s autofs
if [ $? = 0 ]; then
	systemctl stop autofs
	systemctl disable autofs
	systemctl is-enabled autofs | grep -w disabled
else
	echo -e "\t autofs is not installed"
	true
fi
'
'scored=false
apt-cache policy | grep -w 192.168.25.230
'
'scored=false
apt-key list
'
'scored=true
chown root:root /boot/grub/grub.cfg
chmod og-rwx /boot/grub/grub.cfg
stat /boot/grub/grub.cfg | grep -w "Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)"
'
'scored=true
grep "^set superusers=\"pzu-grub\"" /boot/grub/grub.cfg && grep "^password_pbkdf2 pzu-grub" /boot/grub/grub.cfg
'
'scored=true
grep ^root:[*\!]: /etc/shadow
'
'scored=true
echo "* hard core 0" >> /etc/security/limits.d/cis_coredump.conf
echo "fs.suid_dumpable = 0" > /etc/sysctl.d/cis_coredump.conf
sysctl -w fs.suid_dumpable=0
grep "hard core" /etc/security/limits.conf /etc/security/limits.d/* && grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*
'
'scored=true
sysctl -w kernel.randomize_va_space=2
echo "kernel.randomize_va_space = 2" > /etc/sysctl.d/cis_kernel_ASLR.conf
'
'scored=true
cat <<EOF > /etc/motd
The device is private property of PZU.
Only PZU System Administrators are allowed to setup the device.
Illegal access to computer network will be prosecuted by law.
EOF
'
'scored=true
echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue
'
'scored=true
echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue.net
'
'scored=true
chown root:root /etc/motd && chmod 644 /etc/motd
'
'scored=true
chown root:root /etc/issue && chmod 644 /etc/issue
'
'scored=true
chown root:root /etc/issue.net && chmod 644 /etc/issue.net
'
'scored=true
sysctl -w net.ipv4.ip_forward=0
sysctl -w net.ipv6.conf.all.forwarding=0
sysctl -w net.ipv4.route.flush=1
sysctl -w net.ipv6.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_ip_forwarding_is_disabled.conf
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0
EOF
'
'scored=true
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_packet_redirect_sending_is_disabled.conf
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
EOF
'
'scored=true
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv6.conf.all.accept_source_route=0
sysctl -w net.ipv6.conf.default.accept_source_route=0
sysctl -w net.ipv4.route.flush=1
sysctl -w net.ipv6.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_source_routed_packets.conf
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0
EOF
'
'scored=true
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv6.conf.all.accept_redirects=0
sysctl -w net.ipv6.conf.default.accept_redirects=0
sysctl -w net.ipv4.route.flush=1
sysctl -w net.ipv6.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_icmp_redirects.conf
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
EOF
'
'scored=true
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_secure_icmp_redirects.conf
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
EOF
'
'scored=true
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.default.log_martians=1
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_suspicious_packets.conf
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
EOF
'
'scored=true
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_broadcast_packets.conf
net.ipv4.icmp_echo_ignore_broadcasts = 1
EOF
'
'scored=true
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_bogus_icmp.conf
net.ipv4.icmp_ignore_bogus_error_responses = 1
EOF
'
'scored=true
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_reverse_path_filtering.conf
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
EOF
'
'scored=true
sysctl -w net.ipv4.tcp_syncookies=1
sysctl -w net.ipv4.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_tcp_syn_cookies.conf
net.ipv4.tcp_syncookies = 1
EOF
'
'scored=true
sysctl -w net.ipv6.conf.all.accept_ra=0
sysctl -w net.ipv6.conf.default.accept_ra=0
sysctl -w net.ipv6.route.flush=1
cat <<EOF > /etc/sysctl.d/cis_ipv6_router_advertisements
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
EOF
'
'scored=true
apt-get install tcpd
dpkg -s tcpd
'
'scored=false
echo "ALL: 192.168.13.0/255.255.255.0, 192.168.25.0/255.255.255.0" > /etc/hosts.allow
'
'scored=true
echo "ALL: ALL" > /etc/hosts.deny
'
'scored=true
chown root:root /etc/hosts.allow && chmod 644 /etc/hosts.allow
'
'scored=true
chown root:root /etc/hosts.deny && chmod 644 /etc/hosts.deny
'
# 'scored=true
# '
)
#UP
# mount | grep /tmp | grep noexec

# eval '(while : ; do
# echo -e "-------------------------------------- CIS-1.1.1.1 --------------------------------------"
# echo -n "Checking module...   "
# lsmod | grep freevxfs
# if [ $? -eq 0 ]; then
# 	echo -e "--> \e[33mModule loaded.\e[0m"
# 	echo -en "Trying to unload freevxfs kernel module...\t"
# 	rmmod freevxfs
# 	if [ $? -eq 0 ]; then echo -e "---> $OK"; else echo -e "---> $BAD"; fi
# else
# 	echo -e "---> $OK   Module NOT loaded"
# fi
# echo -n "Applying config...   "
# echo "install freevxfs /bin/true" > /etc/modprobe.d/freevxfs.conf
# if [ $? = 0 ]; then
# 	echo -e "--> $OK"
# else
# 	echo -e "--> $BAD   NO permissions... Can NOT apply!"
# 	false
# 	exit
# fi
# echo "Checking config..."
# modprobe -n -v freevxfs | grep -w "install /bin/true"
# if [ $? = 0 ]; then
# 	echo "Config applied!"
# 	echo -e "CIS-1.1.1.1 --> $OK"
# 	echo -e "-------------------------------------- CIS-1.1.1.1 --------------------------------------"
# else
# 	echo -e "CIS-1.1.1.1 ---> $BAD   Maybe. Just maybe Config is NOT Applied. Check it! Is module still loaded?"
#   echo -e "-------------------------------------- CIS-1.1.1.1 --------------------------------------"
# 	false
# 	exit
# fi
# exit
# done)' > $cis_log_file 2>&1

echo "----------------------------------------------------------------"
echo -e "\t$CIS_name"
echo "----------------------------------------------------------------"
echo

text_index=0
for command in "${cis_command[@]}"; do
		echo -ne ${cis_text[$text_index]} >> $cis_log_file 2>&1
		eval "$command" >> $cis_log_file 2>&1
		if [ $? -eq 0 ]; then
			echo -ne ${cis_text[$text_index]}
			echo -e "   \t\t\t---> $OK <---" 2>&1 | tee -a $cis_log_file
			if [ $scored = "true" ]; then
				total_score=$[ $total_score + 1]
			fi
			# echo $total_score
			# echo -ne '\t'
		else
			echo -en ${cis_text[$text_index]}
			echo -e "   \t\t\t---> $BAD <---" 2>&1 | tee -a $cis_log_file
			# echo -e "\tScore = $total_score"
			# echo -ne '\t'
		fi
		text_index=$[ $text_index + 1 ]
		# echo INDEX "$text_index"
done

echo -e "-----------------\nTotal Score = $total_score\n-----------------"

# echo RUN TEXT:
# for text in "${cis_text[@]}"; do
# 	echo "$text"
# done

#
# status_OK=5
# status_BAD=1
#
# echo "--------------------------"
# echo -e "CIS Apply Summary:"
# echo "--------------------------"
# echo -e "  \e[32mScore\e[0m = $score"
# echo -e "  ------------"
# echo -e "  $OK = $status_OK"
# if [ "$status_BAD" != 0 ]; then
# 	echo -e "  $BAD = $status_BAD"
# fi
# echo "--------------------------"
