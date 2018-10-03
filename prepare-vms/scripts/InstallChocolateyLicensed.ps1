Write-Output 'Installing Chocolatey Licensed...'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$licenseDownloadUrl = $env:LICENSE_DOWNLOAD_URL;
$licenseNupkgDownloadUrl = $env:LICENSE_NUPKG_DOWNLOAD_URL
$azureSas = $env:AZURE_SAS;
$downloadPath = "c:\packages"
$licenseInstallationPath = "c:\programdata\chocolatey\license"
New-Item -ItemType Directory -Path $licenseInstallationPath

if($licenseDownloadUrl -And $licenseNupkgDownloadUrl -And $azureSas) {
    $fullDownloadUrlForLicense = "$licenseDownloadUrl$azureSas"
    $fullDownloadUrlForNupkg = "$licenseNupkgDownloadUrl$azureSas"
    (New-Object Net.WebClient).DownloadFile($fullDownloadUrlForNupkg, "$downloadPath\chocolatey.extension.1.12.12.nupkg")
    (New-Object New.WebClient).DownloadFile($fullDownloadUrlForLicense, "$licenseInstallationPath\chocolatey.license.xml")
} else {
    Write-Host "Unable to download Chocolatey Licensed"
}

choco upgrade chocolatey.extension -y --source="'c:\packages'"
