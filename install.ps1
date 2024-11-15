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
git clone https://github.com/Marvellousz/test.git "$env:USERPROFILE\vit-wifi-autologin" -ErrorAction Stop

# Navigate to the repo directory
Set-Location -Path "$env:USERPROFILE\vit-wifi-autologin" -ErrorAction Stop

# Run the setup script
Write-Host "Running the setup script..."
python setup.py -ErrorAction Stop

# Final instructions
Write-Host "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."

# Add a symbolic link for the 'wifi' command to be accessible globally
$wifiScriptPath = "$env:USERPROFILE\vit-wifi-autologin\wifi.py"
$wifiCommandPath = "$env:USERPROFILE\Scripts\wifi.bat"

if (-not (Test-Path -Path "$env:USERPROFILE\Scripts")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\Scripts"
}

# Create a batch file to run the script
Set-Content -Path $wifiCommandPath -Value "@echo off`npython `"$wifiScriptPath`""

Write-Host "A 'wifi' command has been created. You can now run the Wi-Fi login script from anywhere in the command line."
