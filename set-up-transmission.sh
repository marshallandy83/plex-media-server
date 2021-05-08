# Install Transmission BitTorrent client
sudo apt install transmission-daemon --assume-yes

# Stop Transmission service to allow changing of configuration
sudo systemctl stop transmission-daemon

# Create torrent directories
IN_PROGRESS_PATH="/media/pi/Seagate\ Desktop\ Drive/torrent-in-progress"
COMPLETE_PATH="/media/pi/Seagate\ Desktop\ Drive/torrent-complete"
[ -d IN_PROGRESS_PATH ] && sudo mkdir IN_PROGRESS_PATH
[ -d COMPLETE_PATH ] && sudo mkdir COMPLETE_PATH

# Configure Transmission to use above directories
settings=/etc/transmission-daemon/settings.json

sudo sed -i 's|"incomplete-dir":.*|"incomplete-dir": "/media/pi/Seagate\ Desktop\ Drive/torrent-in-progress",|' $settings
sudo sed -i 's|"download-dir":.*|"download-dir": "/media/pi/Seagate\ Desktop\ Drive/torrent-complete",|' $settings
sudo sed -i 's|"incomplete-dir-enabled":.*|"incomplete-dir-enabled": "true",|' $settings

# Set username and password
sudo sed -i 's|"rpc-username":.*|"rpc-username": "pi",|' $settings

echo Choose a password. This will be used to access the web interface.
read -p 'Password: ' password
sudo sed -i "s|\"rpc-password\":.*|\"rpc-password\": \"$password\",|" $settings

echo Adding all network locations to whitelist
sudo sed -i 's|"rpc-whitelist":.*|"rpc-whitelist": "192.168.*.*",|' $settings

echo Running Transmission as pi user
sudo sed -i 's|USER=.*|USER=pi|' /etc/init.d/transmission-daemon
sudo sed -i 's|User=.*|User=pi|' /lib/systemd/system/transmission-daemon.service
sudo sed -i 's|User=.*|User=pi|' /etc/systemd/system/multi-user.target.wants/transmission-daemon.service
sudo systemctl daemon-reload
sudo chown -R pi:pi /etc/transmission-daemon

echo Creating directory where transmission-daemon will access the “setting.json” file
sudo mkdir -p /home/pi/.config/transmission-daemon/
[ -L /home/pi/.config/transmission-daemon/ ] && sudo ln -s /etc/transmission-daemon/settings.json /home/pi/.config/transmission-daemon/
sudo chown -R pi:pi /home/pi/.config/transmission-daemon/
sudo chown -R pi:pi /var/lib/transmission-daemon/

echo Restarting Transmission service
sudo systemctl start transmission-daemon