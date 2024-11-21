import requests

# Define the CyberArk API details
cyberark_base_url = "https://<cyberark-server>/AIMWebService/api/Accounts"
app_id = "<YourAppID>"  # Application ID
safe_name = "<SafeName>"  # Name of the CyberArk safe
folder = "Root"  # Folder in the safe, usually 'Root'
object_name = "<ObjectName>"  # The object you want to access (e.g., the secret name)

def get_cyberark_secret(base_url, app_id, safe, folder, object_name):
    """
    Retrieves a secret from a CyberArk safe.
    """
    try:
        # Construct the API URL
        url = f"{base_url}?AppID={app_id}&Safe={safe}&Folder={folder}&Object={object_name}"
        
        # Make the GET request to the CyberArk API
        response = requests.get(url, verify=False)  # Set verify=True with proper SSL certificates in production
        
        # Check for successful response
        if response.status_code == 200:
            secret_data = response.json()
            return secret_data.get("Content")  # Retrieve the secret content
        else:
            print(f"Failed to retrieve secret: {response.status_code}, {response.text}")
            return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None

# Usage
if __name__ == "__main__":
    secret = get_cyberark_secret(cyberark_base_url, app_id, safe_name, folder, object_name)
    if secret:
        print(f"Retrieved secret: {secret}")
    else:
        print("Failed to retrieve the secret.")
