# Raspberry Pi Audio Receiver Install - Car Deployment Version

###### If you are wanting a Home Version Use the following Repo and follow the install instructions in the README.md
[HOME VERSION](https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install)

This project has combined several different projects into one, culminating into a plug-and-play Audio Receiver project. It incorporates A2DP, AirPlay, and Auxillary line input as possible ways to stream music to your Raspberry Pi. When paired with a sound card or HiFi audio DAC, with the exception of Aux Line Input, you get high quality stereo audio. The main difference between [Raspberry Pi Audio Receiver](https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install) and [Raspberry Pi Audio Receiver Car Install](https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install-Car-Install) is the addition of an Internet-less Wireless Network which allows for the Car Install to generate its own Wireless Network allowing users to connect to the network and stream audio via AirPlay. While this project will work without the use of a soundcard (with some minor configuration), it is suggested to use a sound card for easier install and better audio experience.
## Changes
* Use of External Soundcards
* soxr interpolation with shairport-sync, works well on Raspberry Pi Zero and Raspberry Pi 3, haven't tested on any other boards yet.
* Works great with Sabrent USB Sound Card, HifiBerry Amp+ (I would not recommend this in a car), and will shortly be testing this with a HifiBerry DAC+ Pro.
* Creates Internet-less Wireless Network (Setup as an AP) to allow users to connect to the network and use AirPlay 
* Allows for Audio Line Input, Bluetooth A2DP, and AirPlay. (Audio Line Input, needs some manual configuration as some may choose to forgo "antiquated" hardware. :smirk:

#### This is a further fixed version with the addition of being able to Deploy the project in car without a Wireless Network from my original Raspberry Pi Audio Receive Install repo which was forked from adenbeckitt, with a few changes made for shairport-sync dependencies and configuration files, which is a general fix from ehsmaes' version. This now works with Raspbian Jessie.
#### How about that run on sentence. TLDR; adenbeckitt created a new repo to get ehsmaes' version to work on Raspbian Jessie. I then forked the repo to add some more dependencies and features. Most of the work for this project has been done by adenbeckitt and ehsmaes.

## Known Issues

* For the time being, I have not been able to get espeak to work with a soundcard. I will be working to get this working either with espeak or another program.
* Unsure how Android will act on a wireless network without internet, iOS doesn't display the WiFi signals and will use Cellular Data for data requirements. However, iOS devices still can play local music to the Pi without any cellular data.
* Raspberry Pi Zero will need a WiFi card to use the new Access Point feature, some cards are not compatible with hostapd right out of the box and may require a forked repo of hostapd. If you are using a tp-link usb adapter you can follow the guide here to fix how the current install feature has set this up. I will post the model of the TP-Link usb adapter as soon as I get home. GUIDE: [Pi Zero hostapd Fix](https://bareinhard.github.io/2017/02/15/Fix-hostapd-Raspberry-Pi-Zero.html)

## Install
#### This will install on the latest Raspbian Jessie, with just the following commands.

```
pi@raspberrypi:~/ $ sudo apt-get install git
pi@raspberrypi:~/ $ git clone https://github.com/BaReinhard/Raspberry-Pi-Audio-Receiver-Install-Car-Install.git
pi@raspberrypi:~/ $ cd Raspberry-Pi-Audio-Receiver-Install-Car-Install
pi@raspberrypi:~/Raspberry-Pi-Audio-Receiver-Install-Car-Install $ sudo ./runall.sh
Device name: Choose Device Name
Device WiFi Password: Choose Password Name
```

