# vit wi-fi autologin

This is a Python script designed to automatically log you into the VIT Hostel Wi-Fi network. Once installed, you can quickly log in by typing `wifi` in your terminal (Windows) or command line (Unix-based systems). This script uses encrypted credentials for enhanced security.

## Features
- **Automated Login**: Logs in to the VIT Wi-Fi using your credentials.
- **Encrypted Credentials**: User credentials are encrypted before being saved.
- **Automated Setup**: Easy installation via scripts for both Windows and Unix-based systems.
- **Secure**: Uses the `cryptography` library for encrypting passwords and user IDs.

## Installation

### **Prerequisites**
Before installing, make sure you have `git`, `pip`, and `Python 3.x` installed on your system.

- For **Windows** users: Install `git` and ensure that `python` and `pip` are in your system path.
- For **Unix-based** users: Make sure `git` and `python3` are installed.

### **Automated Installation** (Recommended)

You can set up the script quickly with an automated installation process.

#### **For Windows:**
1. Open **PowerShell** and run the following command:
   ```powershell
   New-Item -ItemType "directory" -Path "$HOME\vit-wifi-autologin"; Invoke-WebRequest -Uri "https://github.com/Marvellousz/test/raw/main/main.py" -Outfile "$HOME\vit-wifi-autologin\main.py"; Invoke-WebRequest -Uri "https://github.com/Marvellousz/test/raw/main/setup.py" -Outfile "$HOME\vit-wifi-autologin\setup.py"; Invoke-WebRequest -Uri "https://github.com/Marvellousz/test/raw/main/wifi.bat" -Outfile "$HOME\wifi.bat"; python "$HOME\vit-wifi-autologin\setup.py"; rm "$HOME\vit-wifi-autologin\setup.py"
   ```

#### **For Unix-based systems (Linux/MacOS):**
1. Clone the repository:
   ```bash
   git clone https://github.com/Marvellousz/test.git
   cd test
   ```

2. Run the installation script:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

This will:
- Clone the repository to your home directory.
- Install the required dependencies.
- Run the setup script to configure your credentials.
- Inform you once the installation is complete.

---

### **Manual Installation** (Advanced)

If you prefer to install manually, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Marvellousz/test.git
   cd test
   ```

2. **Install dependencies**:
   - For **Windows**:
     Open the command prompt and run:
     ```powershell
     pip install python-dotenv requests cryptography
     ```
   - For **Unix-based** systems (Linux/MacOS):
     ```bash
     pip3 install python-dotenv requests cryptography
     ```

3. **Run the `setup.py` script**:
   ```bash
   python setup.py
   ```

4. **Run the script**:
   After installation, you can run the script with:
   - For **Windows**:
     Press `Win + R`, type `wifi`, and hit `Enter`.
   - For **Unix-based systems**:
     Run `wifi` from your terminal.

---

## How It Works

### **Setup Process:**

1. **User Credentials**: 
   When you run `setup.py`, it will prompt you to enter your VIT registration number and password. The password will be encrypted using the `cryptography` library before being saved in the `.env` file.

2. **Encryption**:
   The credentials are saved in an encrypted form using `Fernet` encryption, and the key is stored in a `key.key` file in your home directory. This ensures that your credentials are protected from unauthorized access.

3. **Login**:
   The `main.py` script reads the encrypted credentials, decrypts them using the key from `key.key`, and sends them in an HTTP request to the VIT Wi-Fi login page.

### **Decryption**:
The login script (`main.py`) decrypts the user credentials stored in `.env` before sending the login request.

### **Batch Script (Windows)**:
A batch file (`wifi.bat`) is provided for Windows users to quickly execute the script by typing `wifi` in the run prompt (`Win + R`).

---

## Files and Directories

- **`main.py`**: The main Python script that logs you into the Wi-Fi using your credentials.
- **`setup.py`**: A Python script for setting up your credentials securely (encrypted).
- **`wifi.bat`**: A batch script for Windows to run the login process easily.
- **`install.sh`**: A shell script for automated installation on Unix-based systems (Linux/MacOS).
- **`install.ps1`**: A PowerShell script for Windows to automate the installation.
- **`.env`**: Stores encrypted credentials (User ID and password).
- **`key.key`**: Stores the encryption key used to encrypt/decrypt the credentials.

---

## Security

This script uses encryption to protect your VIT Wi-Fi credentials. The credentials are stored in an encrypted format in the `.env` file, and the encryption key is stored separately in `key.key`. This ensures that your credentials are not stored in plain text.

**Important:** Ensure that both `.env` and `key.key` are added to `.gitignore` to prevent accidental sharing of sensitive information.

---

## Contact

If you have any questions or issues, feel free to open an issue in the repository or contact me via GitHub.

---

### **Thank you for using VIT Wi-Fi Autologin!**

This script was created with the goal of making your life easier by automating the Wi-Fi login process at VIT. If you have any feature requests or improvements, feel free to contribute to the repository.

