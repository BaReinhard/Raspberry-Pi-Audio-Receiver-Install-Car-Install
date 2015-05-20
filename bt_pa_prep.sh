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

# Install Pulse Audio from source

tst sudo apt-get install -qy libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libltdl-dev libsamplerate0-dev libsndfile1-dev libasound2-dev libavahi-client-dev libspeexdsp-dev liborc-0.4-dev intltool libtdb-dev libssl-dev libjson0-dev libsbc-dev libcap-dev

tst sudo apt-get remove -qy libpulse0

tst sudo apt-get install -qy espeak mplayer

echo ""
echo "Done! You should insert your bluetooth-dongle now and reboot"
