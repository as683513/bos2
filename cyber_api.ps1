# Define variables for PFX certificate path, password, App ID, Safe name, and base URL
$PfxCertPath = "C:\path\to\certificate.pfx"
$CertPassword = "your_cert_password"
$AppId = "your_app_id"
$SafeName = "your_safe_name"
$BaseURL = "https://your.cyberark.instance/api/accounts"

# Load PFX certificate into a variable
Write-Output "Loading the PFX certificate..."
$SecurePassword = ConvertTo-SecureString -String $CertPassword -Force -AsPlainText
$Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($PfxCertPath, $SecurePassword)

# Create headers for the API request
Write-Output "Creating headers for the API request..."
$headers = @{
    "Authorization" = "AppId $AppId"
}

# Set up the body for the Invoke-RestMethod
$body = @{
    Safe = $SafeName
}

# Use Invoke-RestMethod to make the GET request to the CyberArk API
Write-Output "Sending request to the CyberArk API..."
try {
    $result = Invoke-RestMethod -Uri "$BaseURL?Safe=$SafeName" -Method Get -Headers $headers -Certificate $Cert

    # Display Account Name and Account ID for the first 5 accounts
    Write-Output "Displaying the first 5 accounts:"
    $count = 0
    foreach ($account in $result) {
        if ($count -ge 5) { break }
        Write-Output "Account Name: $($account.name), Account ID: $($account.id)"
        $count++
    }
} catch {
    Write-Error "Failed to retrieve accounts: $_"
}

Write-Output "Script execution completed."
