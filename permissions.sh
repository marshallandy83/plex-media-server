# Create user group to control access to external drive
groupname="exdrive"
sudo groupadd -f $groupname

# Add required users
sudo usermod -a -G $groupname pi
sudo usermod -a -G $groupname plex

# Change external drive group
sudo chgrp -R $groupname /media
sudo chmod -R 777 /media

# Not sure if any of the above is actually needed. Try just this instead:
# This does somthing with the ACL

sudo setfacl -m g:plex:rwx /media/pi

# Look into using /boot/setup.sh
# Seems that scripts copied to here will run when Pi is first turned on?