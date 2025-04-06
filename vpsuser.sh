#!/bin/bash

# Exit on any error
set -e

echo "Installing UFW (firewall)..."
sudo apt update
sudo apt install ufw -y

echo "Allowing port 3000 through UFW..."
sudo ufw allow 3000/tcp

echo "Enabling UFW..."
sudo ufw --force enable

echo "Downloading Cloudflared..."
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

echo "Installing Cloudflared..."
sudo dpkg -i cloudflared-linux-amd64.deb

echo "Checking Cloudflared version..."
cloudflared --version

echo "Starting Cloudflared tunnel to localhost:3000..."
cloudflared tunnel --url http://localhost:3000
