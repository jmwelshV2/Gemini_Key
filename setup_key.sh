#!/bin/bash

# Prompt the user for their email and GitHub username
read -p "Please provide your email for SSH key generation: " user_email
read -p "Please provide your GitHub username: " github_username

# Generate SSH Key with the provided email
ssh-keygen -t rsa -b 4096 -C "$user_email"

# Change to the directory where the script is located
# This ensures that the script will find the .deb file if it's in the same directory as the script
cd "$(dirname "$0")"

# Ask the user if they want to install Barrier
read -p "Do you want to install Barrier? (y/n): " install_barrier
if [[ $install_barrier == "y" ]]; then
    # Install Barrier
    echo "Installing Barrier..."
    sudo apt update
    sudo apt install -y barrier

    # Setting up SSL for Barrier
    echo "Setting up SSL for Barrier..."
    BARRIER_SSL_DIR="$HOME/.local/share/barrier/SSL"
    mkdir -p "$BARRIER_SSL_DIR"
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$BARRIER_SSL_DIR/Barrier.pem" -out "$BARRIER_SSL_DIR/Barrier.pem" -subj "/CN=Barrier"
    if [ $? -ne 0 ]; then
        echo "Error generating SSL certificate for Barrier."
        exit 1
    fi
fi

# Ask the user if they want to install the ThinLinc client
read -p "Do you want to install the ThinLinc client? (y/n): " install_thinlinc
if [[ $install_thinlinc == "y" ]]; then
    # Install ThinLinc client from a deb file
    echo "Installing ThinLinc client..."
    sudo dpkg -i thinlinc-client*.deb
    if [ $? -ne 0 ]; then
        echo "Trying to fix broken dependencies..."
        sudo apt-get -f install
    fi
fi

# Add the key to SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Instructions to the user
echo "Please add the following SSH key to your GitHub account to access the Gemini_Cluster private repo:"
cat ~/.ssh/id_rsa.pub
read -p "Press enter once you've added the key to GitHub."

# Clone the Private Repo
cd ~
git clone git@github.com:$github_username/Gemini_Cluster.git
