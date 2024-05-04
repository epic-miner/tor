#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Install Tor if not already installed
if ! dpkg -l tor &>/dev/null; then
    apt update
    apt install -y tor
fi

# Configure Tor Hidden Service
echo "HiddenServiceDir /var/lib/tor/hidden_service/" >> /etc/tor/torrc
echo "HiddenServicePort 80 127.0.0.1:8888" >> /etc/tor/torrc

# Restart Tor
systemctl restart tor

# Display the .onion address
echo "Your hidden service address:"
cat /var/lib/tor/hidden_service/hostname
