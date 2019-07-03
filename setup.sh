#! /bin/sh

###
# 
#
# Description:  Set up Kali as a dropbox for reverse SSH access
# Requirements: C&C server with SSHd listening for connections
#               Private key for C&C
#
#
###
echo "${Yellow}If you have not edited ssh.et.service${NC}"
echo "${Yellow}Please press CTRL + C now to exit${NC}"
read -p "Press enter to continue"

# User Variables


# Script Variables
scriptDir='dirname $0'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
NC='\033[0m' # No Color

# Upgrading OS
clear
echo "${green}Upgrading OS${NC}"
apt-get update && apt-get upgrade -y
clear

# Installing packages
echo "${green}Installing Packages${NC}"
apt-get install -y xserver-xorg-video-dummy > /dev/null

# VNC Pre req
echo "${green}Dummy Xorg${NC}"
cp $scriptDir/xorg.conf /usr/share/X11/xorg.conf.d/

# Setting up reverse SSH
echo "${green}Setting up reverse SSH${NC}"
cp $scriptDir/ssh.et.service /lib/systemd/system/
chmod +x /lib/systemd/system/ssh.et.service
systemctl enable /lib/systemd/system/ssh.et.service

# Setting up Pi resolution
echo "${green}Setting Pi resolution${NC}"
echo "framebuffer_width=1280" | sudo tee -a /boot/config.txt
echo "framebuffer_width=720" | sudo tee -a /boot/config.txt

startx &

reboot
