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


# Install Dependencies
tst apt-get install kodi -y
patch /etc/default/kodi << EOT
@@ -1,5 +1,5 @@
 # Set this to 1 to enable startup
-ENABLED=0
+ENABLED=1
 
 # The user to run Kodi as
 USER=kodi

EOT

cat << EOT > /etc/udev/rules.d/10-permissions.rules
# input
KERNEL=="mouse*|mice|event*",   MODE="0660", GROUP="input"
KERNEL=="ts[0-9]*|uinput",      MODE="0660", GROUP="input"
KERNEL=="js[0-9]*",             MODE="0660", GROUP="input"

# tty
KERNEL=="tty[0-9]*",            MODE="0666"

# vchiq
SUBSYSTEM=="vchiq",  GROUP="video", MODE="0660"
EOT
usermod -a -G input kodi




exit 0
