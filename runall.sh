#!/bin/bash

read -p "Device name: " MYNAME

#--------------------------------------------------------------------
function tst {
    echo "Executing: $*"
    if ! $*; then
        echo "Exiting scrip due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------

tst ./bt_pa_prep.sh
tst echo "${MYNAME}" | ./bt_pa_config.sh
tst ./bt_pa_install.sh
tst echo "${MYNAME}" | ./airplay_config.sh
tst ./airplay_install.sh
