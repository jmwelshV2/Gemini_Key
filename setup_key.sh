#!/bin/bash

# Prompt the user for their email
read -p "Please provide your email for SSH key generation: " user_email

# Generate SSH Key with provided email
ssh-keygen -t rsa -b 4096 -C "$user_email"

# Change to the directory where the script is located
# This ensures that the script will find the .deb file if it's in the same directory as the script
cd "$(dirname "$0")"

# Install Barrier
echo "Installing Barrier..."
sudo apt update
sudo apt install -y barrier

# Setting up SSL for Barrier
echo "Setting up SSL for Barrier..."

# Make the necessary directories
BARRIER_SSL_DIR="$HOME/.local/share/barrier/SSL"
mkdir -p "$BARRIER_SSL_DIR"

# Generate the SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$BARRIER_SSL_DIR/Barrier.pem" \
    -out "$BARRIER_SSL_DIR/Barrier.pem" \
    -subj "/C=US/ST=Default/L=Default/O=Default/OU=Default/CN=Barrier"

# Check if certificate generation was successful
if [ $? -eq 0 ]; then
    echo "SSL certificate for Barrier generated successfully."
else
    echo "Error generating SSL certificate for Barrier."
    exit 1
fi

# Install ThinLinc client from a deb file
echo "Installing ThinLinc client..."
sudo dpkg -i thinlinc-client*.deb
if [ $? -ne 0 ]; then
    echo "Trying to fix broken dependencies..."
    sudo apt-get -f install
fi

# Add the key to SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Instructions to user
echo "Please add the following SSH key to your GitHub account to access the Gemini_Cluster private repo:"
cat ~/.ssh/id_rsa.pub

read -p "Press enter once you've added the key to GitHub."

# Clone the Private Repo
git clone git@github.com:your_username/Gemini_Cluster.git
