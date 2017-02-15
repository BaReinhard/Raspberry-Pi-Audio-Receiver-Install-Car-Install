#Changes
* Use of External Soundcards
* soxr interpolation with shairport-sync, works well on Raspberry Pi Zero and Raspberry Pi 3, haven't tested on any other boards yet.
* Works great with Sabrent USB Sound Card, HifiBerry Amp+, and will shortly be testing this with a HifiBerry DAC+ Pro.

###This is a further fixed version from adenbeckitt, with a few changes made for shairport-sync dependencies and configuration files, which is a general fix from ehsmaes' version. This now works with Raspbian Jessie.


For the time being, I have not been able to get espeak to work with a soundcard. I will be working to get this working either with espeak or another program.

#Install

```
sudo apt-get install git
git clone 
cd Rasp*
sudo ./runall.sh
```

