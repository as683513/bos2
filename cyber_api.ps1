# Load the PFX certificate
$Cert = Get-PfxCertificate -FilePath "C:\MyCert.pfx"

# Define the base URL of the Central Credential Provider (CCP) API
$BaseUrl = "https://<IIS_Server_Ip>/AIMWebService/api/Accounts"

# Define the AppID and Safe name
$AppID = "MyApp"
$SafeName = "MySafe"

# Construct the URI with query parameters
$Uri = "$BaseUrl?AppID=$AppID&Safe=$SafeName"

# Set the security protocol to TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Make the API request
try {
    $response = Invoke-RestMethod -Method Get -Uri $Uri -Certificate $Cert

    # Check if the response contains accounts
    if ($response -and $response.Accounts) {
        # Iterate over each account and display the Name and AccountID
        foreach ($account in $response.Accounts) {
            Write-Output "Account Name: $($account.Name), Account ID: $($account.AccountID)"
        }
    } else {
        Write-Output "No accounts found in the specified safe."
    }
} catch {
    Write-Error "An error occurred: $_"
}
