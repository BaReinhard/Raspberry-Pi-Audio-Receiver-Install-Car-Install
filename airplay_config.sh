#!/bin/bash

read -p "Airplay device name: " MYNAME

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
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
*** 29,31 ****
  PIDFILE=/var/run/$NAME.pid
! AP_NAME=\$(hostname)
  NICE=0
--- 29,32 ----
  PIDFILE=/var/run/$NAME.pid
! #AP_NAME=\$(hostname)
! AP_NAME=${MYNAME}
  NICE=0
EOT
sudo useradd -g audio shairport
tst sudo service shairport start
