import pyodbc
import pandas as pd
import requests
import json

# Step 1: Query Azure SQL Server
def fetch_data_from_sql():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=your-server.database.windows.net;'
        'DATABASE=your-database;'
        'UID=your-username;'
        'PWD=your-password'
    )
    query = "SELECT * FROM your_table WHERE some_condition"
    df = pd.read_sql(query, conn)
    conn.close()

    # Save data to a CSV file
    output_file = "updated_data.csv"
    df.to_csv(output_file, index=False)
    print(f"Data exported to {output_file}")
    return output_file

# Step 2: Authenticate with Microsoft Graph API
def authenticate_graph_api(tenant_id, client_id, client_secret):
    token_url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token"
    token_data = {
        'grant_type': 'client_credentials',
        'client_id': client_id,
        'client_secret': client_secret,
        'scope': 'https://graph.microsoft.com/.default'
    }
    response = requests.post(token_url, data=token_data)
    response.raise_for_status()
    access_token = response.json().get('access_token')
    return access_token

# Step 3: Upload File to SharePoint
def upload_to_sharepoint(access_token, sharepoint_site, library_name, file_path):
    headers = {
        'Authorization': f'Bearer {access_token}',
        'Content-Type': 'application/json'
    }
    file_name = file_path.split('/')[-1]
    upload_url = f"https://graph.microsoft.com/v1.0/sites/{sharepoint_site}/drive/root:/{library_name}/{file_name}:/content"
    
    with open(file_path, 'rb') as file_data:
        response = requests.put(upload_url, headers=headers, data=file_data)
        response.raise_for_status()
        print(f"File uploaded successfully to SharePoint: {response.json()['webUrl']}")

# Step 4: Main Execution
if __name__ == "__main__":
    # Azure SQL credentials
    tenant_id = "your-tenant-id"
    client_id = "your-client-id"
    client_secret = "your-client-secret"
    sharepoint_site = "your-sharepoint-site-id"
    library_name = "Documents"  # Change to your folder name in SharePoint

    # Fetch data and save it locally
    file_path = fetch_data_from_sql()

    # Authenticate and upload to SharePoint
    access_token = authenticate_graph_api(tenant_id, client_id, client_secret)
    upload_to_sharepoint(access_token, sharepoint_site, library_name, file_path)
