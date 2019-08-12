#!/bin/bash

number38=$1
number9=9${number38:2}
DESCR=${number38:2}
PEER=${number38:5}

cat << EOF
conf t
 no dial-peer voice ${PEER}00 voip
 no dial-peer voice ${PEER}11 voip
 no dial-peer voice ${PEER}01 voip
 no dial-peer voice ${PEER}02 voip
 no dial-peer voice ${PEER}91 voip
 no dial-peer voice ${PEER}92 voip
!
 dial-peer voice ${PEER}01 voip
  description $DESCR Vega-to-PBX
  destination-pattern $number38
  session protocol sipv2
  session target ipv4:192.168.250.241
  session transport udp
  voice-class codec 1
  voice-class sip asserted-id pai
  voice-class sip profiles 1
  dtmf-relay rtp-nte
  fax protocol pass-through g711alaw
  no vad
!
 dial-peer voice ${PEER}02 voip
  description $DESCR Vega-to-PBX
  destination-pattern $number38
  preference 1
  session protocol sipv2
  session target ipv4:192.168.250.242
  session transport udp
  voice-class codec 1
  voice-class sip asserted-id pai
  voice-class sip profiles 1
  dtmf-relay rtp-nte
  fax protocol pass-through g711alaw
  no vad
!
  dial-peer voice ${PEER}03 voip
  description $DESCR Vega-to-CUCM#1
  destination-pattern $number38
  preference 2
  session protocol sipv2
  session target ipv4:192.168.250.10
  session transport tcp
  voice-class codec 1
  voice-class sip asserted-id pai
  voice-class sip profiles 1
  dtmf-relay rtp-nte
  fax protocol pass-through g711alaw
  no vad
!
 dial-peer voice ${PEER}04 voip
  description $DESCR Vega-to-CUCM#2
  huntstop
  preference 3
  destination-pattern $number38
  session protocol sipv2
  session target ipv4:192.168.250.110
  session transport tcp
  voice-class codec 1
  voice-class sip asserted-id pai
  voice-class sip profiles 1
  dtmf-relay rtp-nte
  fax protocol pass-through g711alaw
  no vad
!
 dial-peer voice ${PEER}05 voip
  description $DESCR CUCM#1-LOOP
  translation-profile outgoing CUCM-LOOP
  destination-pattern $number9
  session protocol sipv2
  session target ipv4:192.168.250.10
  session transport tcp
  voice-class codec 1
  voice-class sip asserted-id pai
  voice-class sip profiles 1
  dtmf-relay rtp-nte
  fax protocol pass-through g711alaw
  no vad
!
 dial-peer voice ${PEER}06 voip
  description $DESCR CUCM#2-LOOP
  translation-profile outgoing CUCM-LOOP
  huntstop
  preference 1
  destination-pattern $number9
  session protocol sipv2
  session target ipv4:192.168.250.110
  session transport tcp
  voice-class codec 1
  voice-class sip asserted-id pai
  voice-class sip profiles 1
  dtmf-relay rtp-nte
  fax protocol pass-through g711alaw
  no vad
!
end
EOF
