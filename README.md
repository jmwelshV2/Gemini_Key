# Gemini_Key Repository

## Overview

The `Gemini_Key` repository is designed as a bootstrap mechanism to enable swift integration into the Gemini Cluster. By using this repo, users can swiftly set up new desktops to join the Gemini Cluster without the hassle of manual configurations.

## Purpose

- **Streamlined Access**: Ensures swift access to the private `Gemini_Cluster` repository by setting up the necessary prerequisites and generating the essential SSH keys.
  
- **Automation**: Through the `setup_key.sh` script, numerous tasks such as SSH key generation, ThinLinc client installation, and Barrier setup are automated, ensuring a seamless experience.

- **Future-Proofing**: While this repo maintains the latest versions of required software, the setup script is versatile and designed to be compatible with any version present in the repo.

## Usage Guide

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/Gemini_Key.git
cd Gemini_Key
```

### 2. Run the setup_key.sh Script

Make the script executable and run it:

```bash
chmod +x setup_key.sh
./setup_key.sh
```

Follow the on-screen instructions and provide the necessary inputs when prompted.

### 3. Set Up the SSH Key

Post successful execution, the script will generate an SSH key. This key needs to be added to your GitHub account or wherever the Gemini_Cluster private repo resides.

    Go to GitHub -> Settings -> SSH and GPG keys -> New SSH Key.
    Copy the content from ~/.ssh/id_rsa.pub and paste it there.

### 4. Accessing Gemini_Cluster

You should now be able to seamlessly clone and interact with the Gemini_Cluster private repository.

### 5. Additional Tools

If you've chosen Barrier or ThinLinc installations during the setup, please refer to their official documentation for advanced configurations and usage guidelines.
Caution

Always ensure the scripts and software you're running are from trusted sources, especially when administrative permissions are involved.

