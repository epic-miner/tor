#!/bin/bash

sudo apt install nano
# Install Tor if not already installed
if ! dpkg -l tor &>/dev/null; then
    sudo apt update
    sudo apt install -y tor
fi

# Configure Tor Hidden Service
echo "HiddenServiceDir /var/lib/tor/hidden_service/" >> /etc/tor/torrc
echo "HiddenServicePort 80 127.0.0.1:8888" >> /etc/tor/torrc

# Restart Tor
sudo service tor restart

# Display the .onion address
echo "Your hidden service address:"
sudo cat /var/lib/tor/hidden_service/hostname
