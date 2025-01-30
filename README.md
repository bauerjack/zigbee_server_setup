# zigbee_server_setup
Records details of how I setup my zigbee2mqtt server on my Raspberry Pi 4 Model B

# Pre-config on Pi
- Using Raspbian PI OS Full (Bookworm + Desktop + Recommended Applications)
- Created using Raspberry Pi Imager with config for
	- Glen Easton Wifi 5ghz
	- user david 
	- enabled access via my desktop ssh key
	- mdns: zigbee2mqtt.local
- Boot to OS
- SSH in as david
- Enabled VNC using
	- sudo raspi-config
- setup ssh keys
	- cd
	- cd .ssh
	- ssh-keygen
- setup that key on github
- cd
- mkdir server
- cd server
- git clone git@github.com:bauerjack/zigbee_server_setup.git

# Base Instructions
- Link: https://www.zigbee2mqtt.io/guide/getting-started/

# Install Dependences
- Reference
	- https://forums.raspberrypi.com/viewtopic.php?t=320769
	```
	sudo apt update
	sudo apt install docker.io
	```
	- Quote: It may not be the latest version but it works.
	- Create script for dependencies	
		- `server/install_dependencies.sh`

# Setup & Test Adapter 

```bash
dmesg output after installing adapter  
  
[ 5108.869131] usb 1-1.1: new full-speed USB device number 3 using xhci_hcd  
[ 5108.976749] usb 1-1.1: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00  
[ 5108.976775] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3  
[ 5108.976788] usb 1-1.1: Product: Sonoff Zigbee 3.0 USB Dongle Plus  
[ 5108.976798] usb 1-1.1: Manufacturer: ITead  
[ 5108.976807] usb 1-1.1: SerialNumber: 78ed2c652051ef119a53388ccc32aab1  
[ 5109.110110] usbcore: registered new interface driver usbserial_generic  
[ 5109.110149] usbserial: USB Serial support registered for generic  
[ 5109.120755] usbcore: registered new interface driver cp210x  
[ 5109.120868] usbserial: USB Serial support registered for cp210x  
[ 5109.120973] cp210x 1-1.1:1.0: cp210x converter detected  
[ 5109.132823] usb 1-1.1: cp210x converter now attached to ttyUSB0  
  
david@zigbee2mqtt:~/server $ ls -la /dev/ttyUSB0  
crw-rw---- 1 root dialout 188, 0 Jan 30 21:42 /dev/ttyUSB0  
  
```

# Docker Config
- Took default config from these instructions:
	- TODO
- Minor Changes
	- Changed Timezone to Europe/Dublin
	- No need to change device as mine enumerated as /dev/ttyUSB0 too
- Rootless container
	- Followed instructions from here to make the container use my userid rather than root for security reasons:
		- https://www.zigbee2mqtt.io/guide/installation/02_docker.html#running-the-container
	- check my user id:
		```
		david@zigbee2mqtt:~/server/zigbee_server_setup $ id
		uid=1000(david) gid=1000(david) groups=1000(david),4(adm),20(dialout),24(cdrom),27(sudo),29(audio),44(video),46(plugdev),60(games),100(users),102(input),105(render),110(netdev),115(lpadmin),993(gpio),994(i2c),995(spi)
		```
	- adding user and group (dialout (group 20)) to the docker compose config

# Zigbee config
- Created `zigbee2mqtt-data/configuration.yaml` based on example from https://www.zigbee2mqtt.io/guide/getting-started/#_2-setup-and-start-zigbee2mqtt
- Confirmed my adapter "Sonoff Zigbee 3.0 USB Dongle Plus" (ZBDongle-P) uses "Z-Stack"
	- Reference: https://sonoff.tech/product/gateway-and-sensors/sonoff-zigbee-3-0-usb-dongle-plus-p/
	- Chipset: CC2652P
	- USB-Serial Chip: CP2102N
- Biggest Challenge is selecting the channel
	- Unfortunately once you pair devices on a given channel you cannot change it :-( without repairing
		- Reference: https://www.zigbee2mqtt.io/guide/faq/
	- Created `reference/wifi_channel_explorer.sh` to find what Wifi Channels I am using by scanning with the pi itself
		- Conclusion: I'm going with Zigbee Channel 14 for the moment. Wifi 2.4Ghz on 6 and 11; wifi channel 1 doesn't seem active. 
			- That would allow Zigbee channels 11-14 to work
			- I went with 14 as there was a suggestion that IKEA might default to 11 if it was free.
		- Note: Zigbee channel numbers and wifi Channel numbers are different. See picture here:
			- https://community.home-assistant.io/t/ikea-devices-only-pairing-on-channel-15-when-very-close-to-usb/544843/3
	



