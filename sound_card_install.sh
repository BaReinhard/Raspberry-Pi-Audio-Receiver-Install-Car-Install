#!/bin/sh
# This file will add the proper sound card configurations to your /etc/asound.conf
# I am unsure whether or not you need pulse and pulse_connect, but will be testing if its absolutely necessary.
# If you are not using any sound card please change all the following line of "card 1" to "card 0"
# If you are using a hifiberry or any other dac, you will need to replace "snd-usb-audio" to the name of the driver you are using
sudo cat <<EOT >> /etc/modprobe.d/alsa-base.conf
options snd-usb-audio index=0
EOT
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 0
}
ctl.pulse {
    type pulse
    card 0
}

pcm.!default {
    type hw
    card 0
}
ctl.!default {
    type hw
    card 0
}
EOT

exit 0
