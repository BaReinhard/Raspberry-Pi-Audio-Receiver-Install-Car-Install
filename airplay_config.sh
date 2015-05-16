#!/bin/bash

read -p "Airplay device name: " AP_NAME

#--------------------------------------------------------------------
function tst {
    echo "Executing: $*"
    if ! $*; then
        echo "Exiting scrip due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------

# Configure shairplay

tst cd ~/projects/airplay-audio-project/shairport
tst sudo cp scripts/debian/init.d/shairport /etc/init.d/
tst sudo chmod +x /etc/init.d/shairport
tst sudo update-rc.d shairport defaults
sudo patch /etc/init.d/shairport << EOT
***************
*** 20,22 ****
  DESC="Shairport Airtunes emulator"
! NAME=shairport
  DAEMON=/usr/local/bin/shairport
--- 20,23 ----
  DESC="Shairport Airtunes emulator"
! #NAME=shairport
! NAME="${AP_NAME}"
  DAEMON=/usr/local/bin/shairport
EOT
tst sudo useradd -g audio shairport
