#!/bin/bash

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting scrip due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------

# Install shairplay from source

tst cd ~
tst sudo apt-get -y install  libao-dev libssl-dev git avahi-utils libwww-perl
mkdir projects
tst cd projects
mkdir airplay-audio-project
tst cd airplay-audio-project
tst git clone https://github.com/njh/perl-net-sdp.git
tst cd perl-net-sdp
tst perl Build.PL
tst ./Build
tst ./Build test
tst sudo ./Build install
tst cd ..
tst git clone https://github.com/abrasive/shairport.git
tst cd shairport
tst make
tst sudo make install
