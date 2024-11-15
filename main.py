import os
import time
import requests
from cryptography.fernet import Fernet
from dotenv import load_dotenv
import urllib3

# Load .env file
load_dotenv(os.path.expanduser('~') + "\\vit-wifi-autologin\\.env")
print("Wi-Fi login script running...")

# Load the encryption key
with open("key.key", "rb") as key_file:
    key = key_file.read()

cipher_suite = Fernet(key)

# Decrypt credentials
userId = cipher_suite.decrypt(os.environ.get("USER_ID").encode()).decode()
password = cipher_suite.decrypt(os.environ.get("PASSWD").encode()).decode()

url = 'http://phc.prontonetworks.com/cgi-bin/authlogin'
data = {
    "userId": userId,
    "password": password,
    "serviceName": "ProntoAuthentication",
    "Submit22": "Login"
}

def main():
    logged_in = False
    retries = 0
    while not logged_in:
        try:
            response = requests.post(url, data)
        except urllib3.exceptions.NewConnectionError:
            print("No internet access\nTry again...")
            break

        logged_in = 'congratulations' in response.text.lower() or 'already' in response.text.lower()

        if logged_in:
            print(f"Logged in successfully as {userId}" if 'already' not in response.text.lower() else f"Already logged in as {userId}.")
        else:
            print("Failed to login. Trying again in 3s...")
            retries += 1
            time.sleep(3)

if __name__ == "__main__":
    main()
