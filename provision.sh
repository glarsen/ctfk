#!/usr/bin/env bash

# Prevent grub updates to allow for initial automated update
echo "[*] Temporarily holding back grub package updates..."
sudo apt-mark hold grub2-common
sudo apt-mark hold grub-pc
sudo apt-mark hold grub-common

# Upgrade the System Packages
echo "[*] Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

# Set environment variables
echo "[*] Setting bootstrap session environment variables..."
export HDIR=/home/vagrant
export SDIR=/vagrant

# Install essentials
echo "[*] Installing essential packages..."
sudo apt-get install -y git

# Kickstart
echo "[*] Kickstarting..."
git clone --depth 1 https://github.com/glarsen/kickstart.git /tmp/kickstart && \
cd /tmp/kickstart && \
./kick.sh ubuntu-xenial build forensics python re x86-c

# Dotfiles
echo "[*] Installing personalized dotfiles..."
git clone --depth 1 https://github.com/glarsen/dotfiles /tmp/dotfiles && \
cd /tmp/dotfiles && \
./install.sh vagrant

# Customize
echo "[*] Installing pwntools..."
sudo -H pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git

echo "[*] Installing Keystone engine..."
cd /tmp && \
git clone --depth=1 https://github.com/keystone-engine/keystone.git && \
mkdir keystone/build && \
cd keystone/build && \
../make-share.sh && \
sudo make install && \
sudo ldconfig

echo "[*] Installing Unicorn engine..."
cd /tmp && \
git clone --depth=1 https://github.com/unicorn-engine/unicorn.git && \
cd unicorn && \
./make.sh && \
sudo ./make.sh install

echo "[*] Installing GEF dependencies..."
sudo apt-get install -y python-capstone
sudo -H pip3 install capstone unicorn keystone-engine ropper retdec-python

echo "[*] Installing GEF..."
curl https://github.com/hugsy/gef/raw/master/gef.sh -sSfL | sh

echo "[*] Installing misc utilities..."
sudo apt-get install -y xtrace

# Remove the holds on Grub
echo "[*] Removing hold on grub packages..."
sudo apt-mark unhold grub-pc grub-common grub2-common

# Provisioning complete
echo "[*] Provisioning completed successfully!"

