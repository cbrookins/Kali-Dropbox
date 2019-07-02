#! /bin/sh

###
# 
#
# Description:  Set up Kali as a dropbox for reverse SSH access
# Requirements: Command & control server with SSHd listening for connections
#
#
###
echo -e "${Yellow}If you have not edited ssh.et.service${NC}"
echo -e "${Yellow}Please press CTRL + C now to exit${NC}"
read -p "Press enter to continue"

# User Variables


# Script Variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
NC='\033[0m' # No Color

# Upgrading OS
clear
echo -e "${green}Upgrading OS${NC}"
sudo apt-get update > /dev/null && apt-get upgrade -y > /dev/null
clear

# Setting up reverse SSH
echo -e "${green}Setting up reverse SSH${NC}"
cp ~/pentest_dropbox/ssh.et.service /lib/systemd/system/
chmod +x /lib/systemd/system/ssh.et.service
systemctl enable /lib/systemd/system/ssh.et.service

# Setting up VNC resolution
echo -e "${green}Setting VNC resolution${NC}"
echo "framebuffer_width=1280" | sudo tee -a /boot/config.txt
echo "framebuffer_width=720" | sudo tee -a /boot/config.txt

reboot
