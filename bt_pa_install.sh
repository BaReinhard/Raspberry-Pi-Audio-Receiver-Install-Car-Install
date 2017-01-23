#!/bin/bash

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------

# Install Pulse Audio & Bluez
tst sudo apt-get install bluez pulseaudio pulseaudio-module-bluetooth

# Install dbus for python
tst sudo apt-get install python-dbus

# Install espeak
tst sudo apt-get install -qy espeak

# Create users and priviliges for Bluez-Pulse Audio interaction - most should already exist
tst sudo addgroup --system pulse
tst sudo adduser --system --ingroup pulse --home /var/run/pulse pulse
tst sudo addgroup --system pulse-access
tst sudo adduser pulse audio
tst sudo adduser root pulse-access
tst sudo adduser pulse lp

echo "Done! You should reboot now"