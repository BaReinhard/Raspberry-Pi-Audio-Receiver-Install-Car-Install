 cd ~
 sudo apt-get -y install  libao-dev libssl-dev git avahi-utils libwww-perl
 mkdir projects
 cd projects
 mkdir airplay-audio-project
 cd airplay-audio-project
 git clone https://github.com/njh/perl-net-sdp.git
 cd perl-net-sdp
 perl Build.PL
 ./Build
 ./Build test
 sudo ./Build install
 cd ..
 git clone https://github.com/abrasive/shairport.git
 cd shairport
 make
 sudo make install
