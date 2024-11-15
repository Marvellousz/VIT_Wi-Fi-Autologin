# Function to display an error message and exit
function Error-Exit {
    param (
        [string]$message
    )
    Write-Host "Error: $message" -ForegroundColor Red
    exit 1
}

# Check if Python3 is installed
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Error-Exit "Python3 is not installed. Please install Python3 and ensure it's added to your system's PATH."
}

# Check if pip is installed
$pip = Get-Command pip -ErrorAction SilentlyContinue
if (-not $pip) {
    Error-Exit "pip is not installed. Please install pip and ensure it's added to your system's PATH."
}

# Install required dependencies
Write-Host "Installing required dependencies..."
pip install python-dotenv requests cryptography -Force -ErrorAction Stop

# Clone the repository
Write-Host "Cloning the repository..."
git clone https://github.com/Marvellousz/test.git "$HOME\vit-wifi-autologin" -ErrorAction Stop

# Navigate to the repo directory
Set-Location -Path "$HOME\vit-wifi-autologin" -ErrorAction Stop

# Run the setup script
Write-Host "Running the setup script..."
python setup.py -ErrorAction Stop

# Final instructions
Write-Host "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."
