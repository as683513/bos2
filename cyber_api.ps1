$PfxCertPath = "C:\path\to\certificate.pfx"
$CertPassword = "your_cert_password"
$AppId = "your_app_id"
$SafeName = "your_safe_name"
$BaseURL = "https://your.cyberark.instance/api/accounts"



# Load PFX certificate
$SecurePassword = ConvertTo-SecureString -String $CertPassword -Force -AsPlainText
$Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($PfxCertPath, $SecurePassword)

# Create Web Request headers and include the client certificate
$headers = @{
    "Authorization" = "AppId $AppId"
}

# Create the web request
$webRequest = [System.Net.HttpWebRequest]::Create("$BaseURL?Safe=$SafeName")
$webRequest.Method = "GET"
$webRequest.ClientCertificates.Add($Cert)
$webRequest.Headers.Add("Authorization", $headers["Authorization"])

try {
    # Get the response from the API
    $response = $webRequest.GetResponse()
    $streamReader = New-Object System.IO.StreamReader($response.GetResponseStream())
    $result = $streamReader.ReadToEnd() | ConvertFrom-Json

    # Display Account Name and Account ID for the first 5 accounts
    $count = 0
    foreach ($account in $result) {
        if ($count -ge 5) { break }
        Write-Output "Account Name: $($account.name), Account ID: $($account.id)"
        $count++
    }
} catch {
    Write-Error "Failed to retrieve accounts: $_"
}
