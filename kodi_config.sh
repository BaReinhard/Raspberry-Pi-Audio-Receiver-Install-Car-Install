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
tst usermod -a -G lp kodi
tst usermod -a -G pulse-access,audio root
tst adduser kodi pulse-access

exit 0
