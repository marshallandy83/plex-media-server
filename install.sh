# Update OS
sudo apt update --assume-yes
sudo apt upgrade --assume-yes

# Install HTTPS transport package
sudo apt install apt-transport-https --assume-yes

# Add Plex key to package manager
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

# Add Plex repository
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# Refresh package list
sudo apt update --assume-yes

# Install Plex
sudo apt install plexmediaserver --assume-yes

# To do: set up Plex libraries via API?

# Set static IP address to current address
# by appending current IP address to boot parameters
# CHANGE THIS! What if it's already there?
echo "ip="$(hostname -I) | sudo tee -a /boot/cmdline.txt

# Set file permissions for external drive
# This does somthing with the ACL
sudo setfacl -m g:plex:rwx /media/pi

# Enable SSH
# Could potentially do with raspi sudo-config nonint do_ssh 1
# https://raspberrypi.stackexchange.com/questions/28907/how-could-one-automate-the-raspbian-raspi-config-setup
sudo touch /boot/ssh

# Enable VNC
sudo raspi-config nonint do_vnc 1

# Install VNC server
sudo apt install realvnc-vnc-server realvnc-vnc-viewer --assume-yes

# To do: set screen resolution for VNC

echo "Installation complete"

# Reboot
sudo reboot

