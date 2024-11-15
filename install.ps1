# Function to display an error message and exit
function Error-Exit {
    param (
        [string]$message
    )
    Write-Host "Error: $message" -ForegroundColor Red
    exit 1
}

# Function to install Python
function Install-Python {
    Write-Host "Python is not installed. Installing Python..."
    $url = "https://www.python.org/ftp/python/3.10.6/python-3.10.6.exe"
    $installerPath = "$env:TEMP\python_installer.exe"
    Invoke-WebRequest -Uri $url -OutFile $installerPath
    Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    Remove-Item -Path $installerPath -Force
    Write-Host "Python installed successfully."
}

# Function to install pip
function Install-Pip {
    Write-Host "pip is not installed. Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
    Remove-Item -Path "get-pip.py" -Force
    Write-Host "pip installed successfully."
}

# Function to install Git
function Install-Git {
    Write-Host "Git is not installed. Installing Git..."
    $gitInstallerUrl = "https://git-scm.com/download/win"
    $gitInstallerPath = "$env:TEMP\git_installer.exe"
    Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath
    Start-Process -FilePath $gitInstallerPath -ArgumentList "/VERYSILENT" -Wait
    Remove-Item -Path $gitInstallerPath -Force
    Write-Host "Git installed successfully."
}

# Check if Python3 is installed
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Install-Python
}

# Check if pip is installed
$pip = Get-Command pip -ErrorAction SilentlyContinue
if (-not $pip) {
    Install-Pip
}

# Check if Git is installed
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Install-Git
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
