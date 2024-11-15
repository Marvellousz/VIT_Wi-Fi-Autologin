#!/bin/bash

# Function to display an error message and exit
function error_exit {
    echo "$1" >&2
    exit 1
}

# Function to install Python
function install_python {
    echo "Python is not installed. Installing Python..."
    sudo apt update || error_exit "Failed to update package list."
    sudo apt install -y python3 python3-pip || error_exit "Failed to install Python3 and pip."
    echo "Python and pip installed successfully."
}

# Function to install Git
function install_git {
    echo "Git is not installed. Installing Git..."
    sudo apt update || error_exit "Failed to update package list."
    sudo apt install -y git || error_exit "Failed to install Git."
    echo "Git installed successfully."
}

# Check if Python3 is installed
if ! command -v python3 &>/dev/null; then
    install_python
fi

# Check if pip is installed
if ! command -v pip3 &>/dev/null; then
    echo "pip is not installed. Installing pip..."
    python3 -m ensurepip --upgrade || error_exit "Failed to install pip."
fi

# Check if Git is installed
if ! command -v git &>/dev/null; then
    install_git
fi

# Install required dependencies
echo "Installing required dependencies..."
pip3 install python-dotenv requests cryptography || error_exit "Failed to install dependencies."

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/Marvellousz/test.git "$HOME/vit-wifi-autologin" || error_exit "Failed to clone the repository."

# Navigate to the repo directory
cd "$HOME/vit-wifi-autologin" || error_exit "Failed to navigate to the repository directory."

# Run the setup script
echo "Running the setup script..."
python3 setup.py || error_exit "Failed to run the setup script."

# Create symlink to wifi command
echo "Creating symlink for 'wifi' command..."
sudo ln -s "$HOME/vit-wifi-autologin/wifi.sh" /usr/local/bin/wifi || error_exit "Failed to create symlink for 'wifi' command."

# Final instructions
echo "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."
