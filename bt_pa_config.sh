#!/bin/bash

#The bluetooth device can appear as a number of things.
#Change the line '+ Class = 0x200414' below to one of the following classes;
# 0x200418 - Headphones
# 0x200414 - Loudspeaker (default)
# 0x200420 - Car Audio
# 0x200434 - Car audio, Loudspeaker
# 0x200438 - Car Audio, Headphones
#
# All of the above classes show the headphone icon on iOS when connected.
# If you wish to not have that icon then use one of the following;
# 0x20041C - Headphones, Portable Audio / Portable Audio
# 0x20043C - Headphones, Portable Audio, Car audio / Portable Audio, Car audio


read -p "Bluetooth device name: " BT_NAME

#--------------------------------------------------------------------
function tst {
    echo "===> Executing: $*"
    if ! $*; then
        echo "Exiting script due to error from: $*"
        exit 1
    fi	
}
#--------------------------------------------------------------------

tst cd `dirname $0`

tst echo "PRETTY_HOSTNAME=$BT_NAME" >> /tmp/machine-info
tst cp /tmp/machine-info /etc

tst cp init.d/pulseaudio /etc/init.d
tst chmod +x /etc/init.d/pulseaudio
tst update-rc.d pulseaudio defaults

tst cp init.d/bluetooth /etc/init.d
tst chmod +x /etc/init.d/bluetooth
tst update-rc.d bluetooth defaults

tst cp init.d/bluetooth-agent /etc/init.d
tst chmod +x /etc/init.d/bluetooth-agent
tst update-rc.d bluetooth-agent defaults

tst cp usr_local_bin/bluez-udev /usr/local/bin
tst chmod 755 /usr/local/bin/bluez-udev

tst cp usr_local_bin/simple-agent.autotrust /usr/local/bin
tst chmod 755 /usr/local/bin/simple-agent.autotrust

tst cp usr_local_bin/say.sh /usr/local/bin
tst chmod 755 /usr/local/bin/say.sh

tst cp usr_local_bin/bluezutils.py /usr/local/bin

tst cp misc_setup/daemon.conf /etc/pulse

cat<< EOT >/boot/config.txt 
# For more options and information see
# http://www.raspberrypi.org/documentation/configuration/config-txt.md
# Some settings may impact device functionality. See link above for details

# uncomment if you get no picture on HDMI for a default "safe" mode
#hdmi_safe=1

# uncomment this if your display has a black border of unused pixels visible
# and your display can output without overscan
#disable_overscan=1

# uncomment the following to adjust overscan. Use positive numbers if console
# goes off screen, and negative if there is too much border
#overscan_left=16
#overscan_right=16
#overscan_top=16
#overscan_bottom=16

# uncomment to force a console size. By default it will be display's size minus
# overscan.
#framebuffer_width=1280
#framebuffer_height=720

# uncomment if hdmi display is not detected and composite is being output
#hdmi_force_hotplug=1

# uncomment to force a specific HDMI mode (this will force VGA)
#hdmi_group=1
#hdmi_mode=1

# uncomment to force a HDMI mode rather than DVI. This can make audio work in
# DMT (computer monitor) modes
#hdmi_drive=2

# uncomment to increase signal to HDMI, if you have interference, blanking, or
# no display
#config_hdmi_boost=4

# uncomment for composite PAL
#sdtv_mode=2

#uncomment to overclock the arm. 700 MHz is the default.
#arm_freq=800

# Uncomment some or all of these to enable the optional hardware interfaces
#dtparam=i2c_arm=on
#dtparam=i2s=on
#dtparam=spi=on

# Uncomment this to enable the lirc-rpi module
#dtoverlay=lirc-rpi

# Additional overlays and parameters are documented /boot/overlays/README

# Enable audio (loads snd_bcm2835)

# High Quality audio patch
audio_pwm_mode=2
dtparam=audio=on

EOT

cat << EOT > /etc/udev/rules.d/99-com.rules
SUBSYSTEM=="input", GROUP="input", MODE="0660"
KERNEL=="input[0-9]*", RUN+="/usr/local/bin/bluez-udev"
SUBSYSTEM=="i2c-dev", GROUP="i2c", MODE="0660"
SUBSYSTEM=="spidev", GROUP="spi", MODE="0660"
SUBSYSTEM=="bcm2835-gpiomem", GROUP="gpio", MODE="0660"

SUBSYSTEM=="gpio*", PROGRAM="/bin/sh -c '\
	chown -R root:gpio /sys/class/gpio && chmod -R 770 /sys/class/gpio;\
	chown -R root:gpio /sys/devices/virtual/gpio && chmod -R 770 /sys/devices/virtual/gpio;\
	chown -R root:gpio /sys$devpath && chmod -R 770 /sys$devpath\
'"

KERNEL=="ttyAMA[01]", PROGRAM="/bin/sh -c '\
	ALIASES=/proc/device-tree/aliases; \
	if cmp -s $ALIASES/uart0 $ALIASES/serial0; then \
		echo 0;\
	elif cmp -s $ALIASES/uart0 $ALIASES/serial1; then \
		echo 1; \
	else \
		exit 1; \
	fi\
'", SYMLINK+="serial%c"

KERNEL=="ttyS0", PROGRAM="/bin/sh -c '\
	ALIASES=/proc/device-tree/aliases; \
	if cmp -s $ALIASES/uart1 $ALIASES/serial0; then \
		echo 0; \
	elif cmp -s $ALIASES/uart1 $ALIASES/serial1; then \
		echo 1; \
	else \
		exit 1; \
	fi \
'", SYMLINK+="serial%c"
EOT

tst chmod 644 /etc/udev/rules.d/99-com.rules

cat << EOT >/etc/bluetooth/main.conf 
[General]

# Default adaper name
# %h - substituted for hostname
# %d - substituted for adapter id
# Defaults to 'BlueZ'
Name = ${BT_NAME}

# Default device class. Only the major and minor device class bits are
# considered. Defaults to '0x000000'.
Class = 0x200414

# How long to stay in discoverable mode before going back to non-discoverable
# The value is in seconds. Default is 180, i.e. 3 minutes.
# 0 = disable timer, i.e. stay discoverable forever
DiscoverableTimeout = 0

# How long to stay in pairable mode before going back to non-discoverable
# The value is in seconds. Default is 0.
# 0 = disable timer, i.e. stay pairable forever
#PairableTimeout = 0

# Automatic connection for bonded devices driven by platform/user events.
# If a platform plugin uses this mechanism, automatic connections will be
# enabled during the interval defined below. Initially, this feature
# intends to be used to establish connections to ATT channels. Default is 60.
#AutoConnectTimeout = 60

# Use vendor id source (assigner), vendor, product and version information for
# DID profile support. The values are separated by ":" and assigner, VID, PID
# and version.
# Possible vendor id source values: bluetooth, usb (defaults to usb)
#DeviceID = bluetooth:1234:5678:abcd

# Do reverse service discovery for previously unknown devices that connect to
# us. This option is really only needed for qualification since the BITE tester
# doesn't like us doing reverse SDP for some test cases (though there could in
# theory be other useful purposes for this too). Defaults to 'true'.
#ReverseServiceDiscovery = true

# Enable name resolving after inquiry. Set it to 'false' if you don't need
# remote devices name and want shorter discovery cycle. Defaults to 'true'.
#NameResolving = true

# Enable runtime persistency of debug link keys. Default is false which
# makes debug link keys valid only for the duration of the connection
# that they were created for.
#DebugKeys = false

#[Policy]
#
# The ReconnectUUIDs defines the set of remote services that should try
# to be reconnected to in case of a link loss (link supervision
# timeout). The policy plugin should contain a sane set of values by
# default, but this list can be overridden here. By setting the list to
# empty the reconnection feature gets disabled.
#ReconnectUUIDs=

EOT

cat << EOT >/etc/pulse/system.pa
#!/usr/bin/pulseaudio -nF
#
# This file is part of PulseAudio.
#
# PulseAudio is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# PulseAudio is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with PulseAudio; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.

# This startup script is used only if PulseAudio is started in system
# mode.

### Automatically load driver modules depending on the hardware available
.ifexists module-udev-detect.so
#load-module module-dev-detect
load-module module-udev-detect tsched=0
.else
### Use the static hardware detection module (for systems that lack udev/hal support)
load-module module-detect
.endif

### Load several protocols
.ifexists module-esound-protocol-unix.so
load-module module-esound-protocol-unix
.endif
load-module module-native-protocol-unix

### Automatically restore the volume of streams and devices
load-module module-stream-restore
load-module module-device-restore

### Automatically restore the default sink/source when changed by the user
### during runtime
### NOTE: This should be loaded as early as possible so that subsequent modules
### that look up the default sink/source get the right value
load-module module-default-device-restore

### Automatically move streams to the default sink if the sink they are
### connected to dies, similar for sources
load-module module-rescue-streams

### Make sure we always have a sink around, even if it is a null sink.
load-module module-always-sink

### Automatically suspend sinks/sources that become idle for too long
load-module module-suspend-on-idle

### Enable positioned event sounds
load-module module-position-event-sounds

### Automatically load driver modules for Bluetooth hardware
.ifexists module-bluetooth-discover.so
    load-module module-bluetooth-discover
.endif

EOT


#sudo service bluetooth start &
#sudo service pulseaudio start &
#sudo service bluetooth-agent start &

sleep 5

echo "Done! You should reboot now"
