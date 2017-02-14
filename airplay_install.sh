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

# Install shairplay-sync from source

tst sudo apt-get -y install build-essential git autoconf automake libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev avahi-daemon libavahi-client-dev libssl-dev libpolarssl-dev libsoxr-dev
tst cd /~
tst git clone https://github.com/mikebrady/shairport-sync.git
tst cd shairport-sync
tst sudo autoreconf -i -f
tst sudo ./configure --sysconfdir=/etc --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-soxr --with-systemd
tst sudo make
tst sudo getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
tst sudo getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null
tst sudo make install
tst sudo systemctl enable shairport-sync

echo "Done! You should reboot now"