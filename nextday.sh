#!/bin/bash

# Exit if any command fails
set -e

echo "Navigating to rl-swarm directory..."
cd rl-swarm

echo "Creating Python virtual environment..."
python3 -m venv .venv

echo "Activating virtual environment..."
source .venv/bin/activate

echo "Running rl-swarm script..."
./run_rl_swarm.sh
