#!/bin/sh

# Active wifi channels
sudo iwlist wlan0 scan | grep -i channel -A 5 > active_wifi_channels.txt
sudo iwlist wlan0 scan | grep -i channel -A 5 > active_wifi_channels_summary.txt
