#!/bin/bash

log="./runall.log"
echo "" > $log

read -p "Device name: " MYNAME
read -p "Device WiFi Password: " WIFIPASS

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi
}
#--------------------------------------------------------------------
chmod +x ./*
echo "Starting @ `date`" | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./bt_pa_prep.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./bt_pa_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
echo "${MYNAME}" | tst ./bt_pa_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./sound_card_install.sh | tee -a $log
tst ./airplay_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
echo "${MYNAME}" | tst ./airplay_config.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
tst ./ap_install.sh | tee -a $log
echo "--------------------------------------------" | tee -a $log
echo "${MYNAME}" | tst ./ap_config.sh | tee -a $log
# Setup AP
cat <<EOT >/etc/hostapd/hostapd.conf
interface=wlan0
driver=nl80211
ssid=$MYNAME
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$WIFIPASS
wpa_key_mgmt=WPA-PSK
#wpa_pairwise=TKIP      # You better do not use this weak encryption (only used by old client devices
rsn_pairwise=CCMP
ieee80211n=1          # 802.11n support
wmm_enabled=1         # QoS support
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
EOT
echo "Ending at @ `date`" | tee -a $log
