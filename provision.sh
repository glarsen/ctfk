#!/usr/bin/env bash

echo "[*] Updating system packages..."
sudo pacman -Syu --noconfirm

echo "[*] Setting bootstrap session environment variables..."
export HDIR=/home/vagrant
export SDIR=/vagrant

## Provisioning Essentials ##
echo "[*] Installing essential packages..."
sudo pacman -S --noconfirm base-devel curl git

## Languages ##
echo "[*] Installing Python..."
sudo pacman -S --noconfirm python2-pip python-pip

echo "[*] Installing Rust..."
sudo pacman -S --noconfirm rustup rust-docs

## Build Tools ##
echo "[*] Installing compiler tools..."
sudo pacman -S --noconfirm clang llvm lld musl nasm

echo "[*] Installing meta-build tools..."
sudo pacman -S --noconfirm cmake meson

## Binary Tools ##
echo "[*] Installing capstone..."
sudo pacman -S --noconfirm capstone python2-capstone python-capstone

echo "[*] Installing keystone..."
sudo pacman -S --noconfirm keystone python2-keystone python-keystone

echo "[*] Installing unicorn..."
sudo pacman -S --noconfirm unicorn python2-unicorn python-unicorn

echo "[*] Installing radare..."
sudo pacman -S --noconfirm radare2

echo "[*] Installing ropper..."
sudo pacman -S --noconfirm ropper python2-ropper python-ropper

echo "[*] Installing QEMU..."
sudo pacman -S --noconfirm qemu-headless qemu-headless-arch-extra

## Debugging Tools ##
echo "[*] Installing debuggers..."
sudo pacman -S --noconfirm gdb lldb

echo "[*] Installing debugger extensions (GEF)..."
sudo -H pip3 install retdec-python && \
curl -sSfL https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

echo "[*] Installing tracing utilities..."
sudo pacman -S --noconfirm ltrace

## Forensic Tools ##
echo "[*] Installing forensic tools..."
sudo pacman -S --noconfirm binwalk foremost wireshark-cli

## Personalization ##
echo "[*] Installing personalized dotfiles..."
git clone --depth 1 https://github.com/glarsen/dotfiles /tmp/dotfiles && \
cd /tmp/dotfiles && \
./install.sh vagrant

echo "[*] Installing preferred editor (neovim)..."
sudo pacman -S --noconfirm neovim

# Provisioning complete
echo "[*] Provisioning completed successfully!"

