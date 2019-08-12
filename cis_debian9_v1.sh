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
"\t 1.3 Filesystem Integrity Checking"
"\t	1.4 Secure Boot Settings\n
\t\t	1.4.1 Ensure permissions on bootloader config are configured (Scored)"
"\t\t 1.4.2 Ensure bootloader password is set (Scored)"
"\t\t 1.4.3 Ensure authentication required for single user mode (Scored)"
"\t	1.5 Additional Process Hardening\n
\t\t	1.5.1 Ensure core dumps are restricted (Scored)"

# "\t "
# "\t\t "
# "\t\t\t "

)
#UP

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
echo "* hard core 0" >> /etc/security/limits.conf
echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
sysctl -w fs.suid_dumpable=0
grep "hard core" /etc/security/limits.conf /etc/security/limits.d/* && grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*
'

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
