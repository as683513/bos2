#Load PFX
$PfxCertPath = "C:\path\to\certificate.pfx"
$CertPassword = ConvertTo-SecureString -String "your_cert_password" -AsPlainText -Force
$Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$Cert.Import($PfxCertPath, $CertPassword, [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::DefaultKeySet)



#Connect
$BaseURI = "https://your.cyberark.instance"
$AppID = "your_app_id"

New-PASSession -BaseURI $BaseURI -Certificate $Cert -UseSharedAuthentication -AppID $AppID



#Get Accounts
$SafeName = "your_safe_name"
$Accounts = Get-PASAccount -filter "safeName eq '$SafeName'"

# Display Account Name and Account ID for the first 5 accounts
$Accounts | Select-Object -First 5 | ForEach-Object {
    Write-Output "Account Name: $($_.name), Account ID: $($_.id)"
}
