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

# Configure shairplay
sudo patch /etc/shairport-sync.conf << EOT
@@ -4,7 +4,7 @@
 // General Settings
 general =
 {
-	name = "$MYNAME"; // This means "Hostname" -- see below. This is the name the service will advertise to iTunes.
+//	name = "%H"; // This means "Hostname" -- see below. This is the name the service will advertise to iTunes.
 //	The default is "Hostname" -- i.e. the machine's hostname with the first letter capitalised (ASCII only.)
 //	You can use the following substitutions:
 //	%h for the hostname,
@@ -56,7 +56,7 @@ 

 // These are parameters for the "alsa" audio back end, the only back end that supports synchronised audio.
 alsa =
 {
-  output_device = "hw:1,0"; // the name of the alsa output device. Use "alsamixer" or "aplay" to find out the names of devices, mixers, etc.
+//  output_device = "default"; // the name of the alsa output device. Use "alsamixer" or "aplay" to find out the names of devices, mixers, etc.
 //  mixer_control_name = "PCM"; // the name of the mixer to use to adjust output volume. If not specified, volume in adjusted in software.
 //  mixer_device = "default"; // the mixer_device default is whatever the output_device is. Normally you wouldn't have to use this.
 //  audio_backend_latency_offset = 0; // Set this offset to compensate for a fixed delay in the audio back end. E.g. if the output device delays by 100 ms, set this to -4410.
EOT
tst sudo useradd -g audio shairport-sync
tst sudo systemctl daemon-reload
tst sudo service shairport-sync start


