Write-Host "Installing Chocolatey Licensed..."

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$licenseDownloadUrl = $env:LICENSE_DOWNLOAD_URL;
$licenseNupkgDownloadUrl = $env:LICENSE_NUPKG_DOWNLOAD_URL
$azureSas = $env:AZURE_SAS;
$downloadPath = "c:\packages"
$licenseInstallationPath = "c:\programdata\chocolatey\license"

Write-Host "Checking to see if $licenseInstallationPath exists..."
if(!(Test-Path $licenseInstallationPath)) {
  New-Item -ItemType Directory -Path $licenseInstallationPath
  Write-Host "Directory created."
}

if($licenseDownloadUrl -And $licenseNupkgDownloadUrl -And $azureSas) {
  $fullDownloadUrlForLicense = "$licenseDownloadUrl$azureSas"
  $fullDownloadUrlForNupkg = "$licenseNupkgDownloadUrl$azureSas"

  Write-Host "Downloading nupkg..."
  (New-Object Net.WebClient).DownloadFile($fullDownloadUrlForNupkg, "$downloadPath\chocolatey.extension.1.12.12.nupkg")
  Write-Host "Nupkg downloaded."

  Write-Host "Downloading license file..."
  (New-Object Net.WebClient).DownloadFile($fullDownloadUrlForLicense, "$licenseInstallationPath\chocolatey.license.xml")
  Write-Host "File downloaded"
} else {
  Write-Host "Unable to download Chocolatey Licensed"
}

choco upgrade chocolatey.extension -y --source="'c:\packages'"
