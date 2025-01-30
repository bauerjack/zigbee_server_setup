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
server/install_dependencies.sh

# Setup & Test Adapter 
`
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

`
# Docker Config?




