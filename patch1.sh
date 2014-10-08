# Patch for the msfconsole install on the USB keys
# Nils, SUTD, 2014
#!/bin/bash

# Instructions:
# Run as normal user, requires internet access
# I assume that we have the info.tar.gz in our current folder
# I also assume the msf_install is in this folder

# First, we need to fix broken uninstaller for postgre
sudo tar xvzf info.tar.gz -C /var/lib/dpkg/info/
# TODO: check if +x has to be set for some of these

# Now, we should be able to remove postgre and ruby
sudo apt-get remove postgresql-client-9.3 postgresql-9.3 postgresql-common postgresql-client-common libpq-dev libpq5 pgadmin3 pgagent postgresql-9.3 postgresql libruby1.9.1 libruby1.9.1-dbg

# lets clean up the gems and other garbage
sudo rm -rf /var/lib/gems /usr/bin/pg_config.libpq-dev /usr/lib/ruby /etc/postgresql-common/user_clusters

# Start the install process again
bash msf_install.sh

# Now, re-run the bundle install as normal user
cd /usr/local/share/metasploit-framework-git/
sudo rm msfconsole
sudo git pull
bundle install
sudo rm -rf /home/student/.msf4

# last but not least, we need to reboot for some reason to get pgsql to work
sudo reboot
