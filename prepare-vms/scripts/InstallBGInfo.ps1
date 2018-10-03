if ($null -eq (Get-Command -Name 'choco.exe' -ErrorAction SilentlyContinue)) {
  Write-Warning "Chocolatey not installed. Cannot install BGInfo."
}
else {
  choco upgrade bginfo -y

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

  Write-Host "Downloading bginfo files..."
  if (!(Test-Path 'C:\ProgramData\chocolatey\lib\bginfo\tools\bginfo.bgi')) {
    (New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/azure/packer/bginfo.bgi', 'C:\ProgramData\chocolatey\lib\bginfo\tools\bginfo.bgi')
  }
  if (!(Test-Path 'c:\programdata\chocolatey\lib\sysinternals\tools\background.jpg')) {
    (New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/azure/packer/background.jpg', 'C:\ProgramData\chocolatey\lib\bginfo\tools\background.jpg')
  }
  Write-Host "Download complete."
}
