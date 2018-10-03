if ($null -eq (Get-Command -Name 'choco.exe' -ErrorAction SilentlyContinue)) {
  Write-Warning "Chocolatey not installed. Cannot install BGInfo."
}
else {
  choco upgrade bginfo -y --source="'c:\packages'"

  if (!(Test-Path 'c:\Program Files\sysinternals\bginfo.bgi')) {
    (New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/azure/packer/bginfo.bgi', 'C:\programdata\chocolatey\lib\sysinternals\tools\bginfo.bgi')
  }
  if (!(Test-Path 'c:\Program Files\sysinternals\background.jpg')) {
    (New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/azure/packer/background.jpg', 'C:\programdata\chocolatey\lib\sysinternals\tools\background.jpg')
  }
}
