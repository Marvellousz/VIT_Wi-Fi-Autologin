import re
import os
from cryptography.fernet import Fernet
from dotenv import load_dotenv, set_key

print("This setup script will only run once. Store your credentials in a .env file for the login script to access, then delete itself.")

print(f"If you want to change your credentials, you will need to modify the .env file manually located at ~/vit-wifi-autologin/.env.\n")

# Function to generate and save a key (only needed once)
def generate_key():
    key = Fernet.generate_key()
    with open("key.key", "wb") as key_file:
        key_file.write(key)

# Load or generate the key
if not os.path.exists("key.key"):
    generate_key()

with open("key.key", "rb") as key_file:
    key = key_file.read()

cipher_suite = Fernet(key)

userId = input("Enter registration number: ")
while not re.match(r'[0-9]{2}[A-Z]{3}[0-9]*', userId):
    userId = input("Enter a valid registration number: ")

passwd = input("\nEnter your password: ")
repasswd = input("Reenter your password: ")
while not passwd == repasswd or passwd == "":
    print("Passwords do not match. Try again.")
    passwd = input("\nEnter your password: ")
    repasswd = input("Reenter your password: ")

# Encrypt the password and userId
encrypted_user_id = cipher_suite.encrypt(userId.encode())
encrypted_passwd = cipher_suite.encrypt(passwd.encode())

# Save encrypted credentials to .env
env_path = os.path.expanduser('~') + "\\vit-wifi-autologin\\.env"
with open(env_path, 'w') as file:
    file.write(f"USER_ID={encrypted_user_id.decode()}\nPASSWD={encrypted_passwd.decode()}\n")

print(r"Credentials saved. You can now login instantly with Win+R and then typing 'wifi'")
