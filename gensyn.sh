#!/bin/bash

# Exit on error
set -e

# Update system and install dependencies
sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update && sudo apt install -y nodejs

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
sudo apt update && sudo apt install -y yarn

# Clone the repo
git clone https://github.com/gensyn-ai/rl-swarm.git
cd rl-swarm || exit

# Start screen session and run the rest inside it
screen -S gensyn -dm bash -c '
  python3 -m venv .venv
  source .venv/bin/activate
  cd modal-login
  yarn install
  yarn upgrade
  yarn add next@latest
  yarn add viem@latest
  cd ..
  ./run_rl_swarm.sh
'

echo "✅ Setup complete. To attach to the screen session, run: screen -r gensyn"
