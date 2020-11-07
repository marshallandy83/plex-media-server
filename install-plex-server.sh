# Update OS
sudo apt-get update --assume-yes
sudo apt-get upgrade --assume-yes

# Install HTTPS transport package
sudo apt-get install apt-transport-https --assume-yes

# Add Plex key to package manager
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

# Add Plex repository
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

# Refresh package list
sudo apt-get update --assume-yes

# Install Plex
sudo apt install plexmediaserver --assume-yes
