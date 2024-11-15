#!/bin/bash

# Function to display error message and exit
function error_exit {
    echo "$1"
    exit 1
}

# Check if Python3 and pip are installed
if ! command -v python3 &> /dev/null; then
    error_exit "Error: Python3 is not installed. Please install Python3 and try again."
fi

if ! command -v pip &> /dev/null; then
    error_exit "Error: pip is not installed. Please install pip and try again."
fi

# Install required dependencies
echo "Installing required dependencies..."
pip install python-dotenv requests cryptography || error_exit "Failed to install dependencies. Please check your environment."

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/Marvellousz/test.git "$HOME/vit-wifi-autologin" || error_exit "Failed to clone the repository. Please check your network connection."

# Navigate to the repo directory
cd "$HOME/vit-wifi-autologin" || error_exit "Failed to navigate to the repository directory."

# Run the setup script
echo "Running the setup script..."
python3 setup.py || error_exit "Failed to run the setup script."

# Final instructions
echo "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."
