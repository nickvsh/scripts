#!/bin/bash


DN=$1
name=$2

#upgradecode:3,0x601,0x0400,0x0100,0.0.0.0,69,0x060412a,CP7912080001SIP060412A.sbin
cat << EOF
#txt

UIPassword:Adm1n2019
dhcp:1
Proxy:192.168.25.101
UID:$DN
PWD:Ph0ne7912
NTPIP:192.168.25.25
AltNTPIP:192.168.25.27
LoginID:cisco7912
VoiceMailNumber:0
DisplayName:$name
ShortName:$name
UseLoginID:1
SIPPort:5060
SIPRegInterval:600
SIPRegOn:1
AudioMode:0x00000010
NumTxFrames:2
ConnectMode:0x00000010
TimeZone:2
UseTftp:1
CfgInterval:86400
TraceFlags:0x00000000
DialPlan:911|1>#t8.r9t2-|0>#t811.rat4-|^1t4>#.-
RingOnOffTime:2,4,25
DialTone:2,31538,814,30831,2032,0,0,0,0,0,0
DialTone2:2,30743,1384,29864,1252,0,0,0,0,0,0
BusyTone:2,30467,1104,28959,1404,1,4000,4000,0,0,0
ReorderTone:0,2,30467,1104,28959,1404,0,0,1,2000,2000,0,0,0,0,0,0
RingBackTone:2,30831,2032,30467,1104,1,16000,32000,0,0,0
CallWaitTone:1,30831,2412,0,0,1,2400,2400,0,0,4800
MediaPort:16384
SigTimer:0x00000064
TimeFormat:H:i:s
DateFormat:d/m/y
CallWaiting:1
AttendedTransfer:1
BlindTransfer:1
Conference:1
EOF
