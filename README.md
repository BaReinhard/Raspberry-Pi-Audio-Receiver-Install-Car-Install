# Changes
* Use of External Soundcards
* soxr interpolation with shairport-sync, works well on Raspberry Pi Zero and Raspberry Pi 3, haven't tested on any other boards yet.
* Works great with Sabrent USB Sound Card, HifiBerry Amp+ (I would not recommend this in a car), and will shortly be testing this with a HifiBerry DAC+ Pro.
* Creates Internet-less Wireless Network (Setup as an AP) to allow users to connect to the network and use AirPlay 
* Allows for Audio Line Input, Bluetooth A2DP, and AirPlay. (Audio Line Input, needs some manual configuration as some may choose to forgo "antiquated" hardware. :smirk:

### This is a further fixed version with the addition of being able to Deploy the project in car without a Wireless Network from my original Raspberry Pi Audio Receive Install repo which was forked from adenbeckitt, with a few changes made for shairport-sync dependencies and configuration files, which is a general fix from ehsmaes' version. This now works with Raspbian Jessie.
### How about that run on sentence. TLDR; adenbeckitt created a new repo to get ehsmaes' version to work on Raspbian Jessie. I then forked the repo to add some more dependencies and features. Most of the work for this project has been done by adenbeckitt and ehsmaes.

# Known Issues

* For the time being, I have not been able to get espeak to work with a soundcard. I will be working to get this working either with espeak or another program.
* Unsure how Android will act on a wireless network without internet, iOS doesn't display the WiFi signals and will use Cellular Data for data requirements. However, iOS devices still can play local music to the Pi without any cellular data.
* Raspberry Pi Zero will need a WiFi card to use the new Access Point feature, some cards are not compatible with hostapd right out of the box and may require a forked repo of hostapd. If you are using a tp-link usb adapter you can follow the guide here to fix how the current install feature has set this up. I will post the model of the TP-Link usb adapter as soon as I get home. GUIDE: [Pi Zero hostapd Fix](https://bareinhard.github.io/2017/02/09/Setup-Car-Wifi-Raspberry-Pi-Zero-1-2-AP-No-Internet.html)

# Install
### This will install on the latest Raspbian Jessie, with just the following commands.

```
sudo apt-get install git
git clone https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install-Car-Install.git
cd Rasp*
sudo ./runall.sh
```

