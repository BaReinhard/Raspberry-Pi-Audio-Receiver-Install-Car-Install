#!/bin/bash
read -p "Airplay device name: " MYNAME
#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------


# setup the config files
tst cat <<EOT >/etc/network/interfaces
source-directory /etc/network/interfaces.d
auto lo
iface lo inet loopback
iface eth0 inet dhcp

allow-hotplug wlan0

iface wlan0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
#allow-hotplug wlan0
#iface wlan0 inet manual
# wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
EOT

patch /etc/dhcpcd.conf <<EOT
@@ -39,3 +39,4 @@
 # A hook script is provided to lookup the hostname if not set by the DHCP
 # server, but it should not be run by default
 nohook lookup-hostname
+denyinterfaces wlan0
EOT

# Setup AP
tst cat <<EOT >/etc/hostapd/hostapd.conf
interface=wlan0
driver=nl80211
ssid=$MYNAME
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=changethis
wpa_key_mgmt=WPA-PSK
#wpa_pairwise=TKIP      # You better do not use this weak encryption (only used by old client devices
rsn_pairwise=CCMP
ieee80211n=1          # 802.11n support
wmm_enabled=1         # QoS support
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
EOT

# Add patch for /etc/default/hostapd 

# Setup dhcp server

tst cat <<EOT >>/etc/dhcp/dhcpd.conf
ddns-update-style none;
ignore client-updates;
authoritative;
option local-wpad code 252 = text;
 
subnet
10.0.0.0 netmask 255.255.255.0 {
# --- default gateway
option routers
10.0.0.1;
# --- Netmask
option subnet-mask
255.255.255.0;
# --- Broadcast Address
option broadcast-address
10.0.0.255;
# --- Domain name servers, tells the clients which DNS servers to use.
option domain-name-servers
10.0.0.1, 8.8.8.8, 8.8.4.4;
option time-offset
0;
range 10.0.0.3 10.0.0.13;
default-lease-time 1209600;
max-lease-time 1814400;
}
EOT

# Add Patch for /etc/default/isc-dhcp-server




