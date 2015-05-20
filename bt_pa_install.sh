#!/bin/bash

bluez_version="5.30"
pulse_version="5.0"

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
tst cd ~
tst wget http://freedesktop.org/software/pulseaudio/releases/pulseaudio-${pulse_version}.tar.xz
tst tar xvf pulseaudio-${pulse_version}.tar.xz
tst cd pulseaudio-${pulse_version}/
tst ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-bluez4 --disable-rpath --with-module-dir=/usr/lib/pulse/modules
tst make
tst sudo make install

# Install Bluez from source
tst cd ~
tst wget https://www.kernel.org/pub/linux/bluetooth/bluez-${bluez_version}.tar.xz
tst tar xvf bluez-${bluez_version}.tar.xz
tst cd bluez-${bluez_version}/
tst ./configure --prefix=/usr --sysconfdir=/etc  --localstatedir=/var --enable-library --disable-systemd
tst make
tst sudo make install
tst sudo install -v -dm755 /etc/bluetooth
tst sudo install -v -m644 src/main.conf /etc/bluetooth/main.conf

# Create users and priviliges for Bluez-Pulse Audio interaction
tst sudo addgroup --system pulse
tst sudo adduser --system --ingroup pulse --home /var/run/pulse pulse
tst sudo addgroup --system pulse-access
tst sudo adduser pulse audio
tst sudo adduser root pulse-access
tst sudo adduser pulse lp

echo "Done! You should reboot now"
