import requests
import json
import pandas as pd

# Set up your CyberArk PVWA server information
PVWA_SERVER = "https://cyberark.example.com"
AUTH_URL = f"{PVWA_SERVER}/PasswordVault/API/Auth/Cyberark/Logon"
UPDATE_ACCOUNT_URL = f"{PVWA_SERVER}/PasswordVault/API/Accounts/"
USERNAME = "your_username"
PASSWORD = "your_password"

# Authenticate and obtain session token
def authenticate():
    response = requests.post(AUTH_URL, json={"username": USERNAME, "password": PASSWORD}, verify=False)
    if response.status_code == 200:
        return response.text.strip('"')  # Token is returned as a string surrounded by quotes
    else:
        raise Exception(f"Authentication failed with status code {response.status_code}: {response.text}")

# Update account name
def update_account_name(session_token, account_id, new_name):
    url = f"{UPDATE_ACCOUNT_URL}{account_id}/"
    headers = {
        "Authorization": session_token,
        "Content-Type": "application/json"
    }
    body = [
        {
            "op": "replace",
            "path": "/name",
            "value": new_name
        }
    ]
    response = requests.patch(url, headers=headers, json=body, verify=False)
    if response.status_code == 200:
        print(f"Successfully updated account {account_id} to {new_name}")
    else:
        print(f"Failed to update account {account_id}. Status code: {response.status_code}, Response: {response.text}")

# Main function to update multiple accounts
def main():
    # Load account data from Excel file
    excel_file_path = "accounts_to_update.xlsx"
    df = pd.read_excel(excel_file_path)

    try:
        # Authenticate to get session token
        session_token = authenticate()
        print("Authentication successful. Updating accounts...")

        # Iterate through accounts and update names
        for index, row in df.iterrows():
            account_id = row['account_id']
            new_name = row['new_name']
            update_account_name(session_token, account_id, new_name)
    except Exception as e:
        print(f"An error occurred: {str(e)}")

if __name__ == "__main__":
    main()
