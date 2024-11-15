# Install dependencies function
function Install-Dependencies {
    Write-Host "Checking for Python dependencies..."

    # Check if pip is installed
    if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
        Write-Host "pip not found. Installing pip..."
        python -m ensurepip --upgrade
    }

    # Install required Python packages
    Write-Host "Installing required dependencies..."
    pip install python-dotenv requests cryptography
}

# Create directories and download files from GitHub
Write-Host "Creating directories and downloading files from GitHub..."

# Create the vit-wifi-autologin directory
New-Item -ItemType "directory" -Path "$HOME\vit-wifi-autologin" -Force

# Download the necessary files from GitHub
Invoke-WebRequest -Uri "https://github.com/Marvellousz/test/raw/main/main.py" -Outfile "$HOME\vit-wifi-autologin\main.py"
Invoke-WebRequest -Uri "https://github.com/Marvellousz/test/raw/main/setup.py" -Outfile "$HOME\vit-wifi-autologin\setup.py"
Invoke-WebRequest -Uri "https://github.com/Marvellousz/test/raw/main/wifi.bat" -Outfile "$HOME\wifi.bat"

# Install dependencies
Install-Dependencies

# Run the setup.py script
Write-Host "Running the setup script..."
python "$HOME\vit-wifi-autologin\setup.py"

# Create symlink for `wifi` command in system PATH (make it executable globally)
Write-Host "Creating symlink for 'wifi' command..."

# Create the symlink in a directory that's part of the system's PATH (e.g., C:\Windows\System32)
$wifiBatPath = "$HOME\wifi.bat"
$destinationPath = "C:\Windows\System32\wifi.bat"

# Check if wifi.bat exists in destination path, if not create a symlink
if (Test-Path $destinationPath) {
    Write-Host "wifi.bat already exists in System32."
} else {
    New-Item -ItemType SymbolicLink -Path $destinationPath -Target $wifiBatPath
    Write-Host "Symlink created successfully!"
}

# Final Instructions
Write-Host "Installation complete! You can now run the Wi-Fi login script by typing 'wifi'."
Write-Host "Run 'wifi' from anywhere in the command line or PowerShell to log in."
