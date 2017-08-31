#
#
#
#
# how to using
#
# yum install wget -y
# wget and.ro.lt/freeswitch/gitit.sh
# chmod +x gitit.sh
# ./gitit.sh
#
#
#
#
#
# original: http://voicenetwork.ca/gitit.sh
#
# Provided by: VoiceNetwork.ca
#
# Install the required packages for FreeSwitch
#
echo "Please visit:  www.VoiceNetwork.ca"
echo ""
echo "Your System Cpu:"
awk '/model name/  {ORS=""; count++; if ( count == 1 ) print  $0; }  END {  print " : " count "\n" }' /proc/cpuinfo
echo ""
echo ""
yum install perl-ExtUtils-MakeMaker -y
yum install autoconf automake libtool gcc-c++ ncurses-devel make expat-devel zlib zlib-devel unixODBC-devel openssl-devel gnutls-devel libogg-devel libvorbis-devel curl-devel gettext-devel expat-devel curl-devel zlib-devel openssl-devel bzip2 libjpeg-devel -y
#
# Install Git
#
cd /usr/src
wget http://distfiles.macports.org/git-core/git-1.7.6.tar.bz2
tar -xvjf git-1.7.6.tar.bz2
cd git-1.7.6
make prefix=/usr/local all
make prefix=/usr/local install
#Detect the number of CPU Cores
NUM_CORES=$(cat /proc/cpuinfo | grep processor | wc -l)
#
# Get FreeSwitch
#
#
echo "Making FreeSwitch Directory"
mkdir /usr/src/freeswitch
cd /usr/src/freeswitch
git clone git://git.freeswitch.org/freeswitch.git /usr/src/freeswitch
cd /usr/src/freeswitch
echo "Running Bootstrap"
./bootstrap.sh -j
cd /usr/src/freeswitch
echo "Running Configure"
./configure
cd /usr/src/freeswitch
echo "Installing FreeSWITCH"
make -j$NUM_CORES && make install && make moh-install && make sounds-install

#Make the Prompt Pretty and add a few aliases that come in handy
cat >>~/.bashrc <<EOT
export LESSCHARSET="latin1"
export LESS="-R"
export CHARSET="ISO-8859-1"
export PS1='\n\[\033[01;31m\]\u@\h\[\033[01;36m\] [\d \@] \[\033[01;33m\] \w\n\[\033[00m\]<\#>:'
export PS2="\[\033[1m\]> \[\033[0m\]"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export VISUAL=vim

umask 022
alias vi='vim'
alias fstop='top -p `cat /usr/local/freeswitch/run/freeswitch.pid`'
alias fsgdb='gdb /usr/local/freeswitch/bin/freeswitch `cat /usr/local/freeswitch/run/freeswitch.pid`'
alias fscore='gdb /usr/local/freeswitch/bin/freeswitch `ls -rt core.* | tail -n1`'
EOT

#Add a screenrc with a status line, a big scroll back and ^\ as the metakey as to not screw with emacs users
cat >> ~/.screenrc <<EOT
hardstatus alwaysignore
startup_message off
escape ^\b
defscrollback 8000

# status line at the bottom
hardstatus on
hardstatus alwayslastline
hardstatus string "%{.bW}%-w%{.rW}%f%n %t%{-}%+w %=%{..G}[%H %l] %{..Y} %m/%d %c "
EOT


# and finally lets fix up IPTables so things works correctly

#Block 'friendly-scanner' AKA sipvicious
iptables -I INPUT -p udp --dport 5060 -m string --string "friendly-scanner" --algo bm -j DROP
iptables -I INPUT -p udp --dport 5080 -m string --string "friendly-scanner" --algo bm -j DROP

#rate limit registrations to keep us from getting hammered on
iptables -I INPUT -m string --string "REGISTER sip:" --algo bm --to 65 -m hashlimit --hashlimit 4/minute --hashlimit-burst 1 --hashlimit-mode srcip,dstport --hashlimit-name sip_r_limit -j ACCEPT

# FreeSwitch ports internal SIP profile
iptables -I INPUT -p udp -m udp --dport 5060 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5060 -j ACCEPT

# FreeSwitch Ports external SIP profile
iptables -I INPUT -p udp -m udp --dport 5080 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 5080 -j ACCEPT

# RTP Traffic 16384-32768
iptables -I INPUT -p udp -m udp --dport 16384:32768 -j ACCEPT

# Ports for the Web GUI
iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT

#save the IPTables rules for later
service iptables save

