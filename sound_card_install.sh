#!/bin/sh
# This file will add the proper sound card configurations to your /etc/asound.conf
# I am unsure whether or not you need pulse and pulse_connect, but will be testing if its absolutely necessary.
# If you are not using any sound card please change all the following line of "card 1" to "card 0"
sudo cat <<EOT >> /etc/asound.conf
pcm.pulse {
    type pulse
    card 1
}
ctl.pulse {
    type pulse
    card 1
}
pcm.pulse_connect {
    type pulse
    card 1
}
ctl.pulse_connect {
    type pulse
    card 1
}
pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw
    card 1
}
EOT

exit 0