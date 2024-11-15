#!/bin/bash

# Install dependencies
echo "Installing required dependencies..."
pip install python-dotenv requests cryptography

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/Marvellousz/test.git "$HOME/vit-wifi-autologin"

# Navigate to the repo directory
cd "$HOME/vit-wifi-autologin" || exit

# Run the setup script
echo "Running the setup script..."
python3 setup.py

# Final instructions
echo "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."
