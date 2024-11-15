# Install dependencies
Write-Host "Installing required dependencies..."
pip install python-dotenv requests cryptography

# Clone the repository
Write-Host "Cloning the repository..."
git clone https://github.com/Marvellousz/test.git "$HOME\vit-wifi-autologin"

# Navigate to the repo directory
Set-Location -Path "$HOME\vit-wifi-autologin"

# Run the setup script
Write-Host "Running the setup script..."
python setup.py

# Final instructions
Write-Host "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."
