Start-Transcript -Path C:\provision.log

net user vagrant /delete

Set-MpPreference -DisableRealtimeMonitoring $true

New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "1" -Force

function Get-HostToIP($hostname) {
  $result = [system.Net.Dns]::GetHostByName($hostname)
  $result.AddressList | ForEach-Object {$_.IPAddressToString }
}

Write-Host "provision.ps1"
Write-Host "HostName = $($HostName)"

$PublicIPAddress = Get-HostToIP($HostName)

Write-Host "PublicIPAddress = $($PublicIPAddress)"
Write-Host "USERPROFILE = $($env:USERPROFILE)"
Write-Host "pwd = $($pwd)"

Write-Host "Install bginfo"
[Environment]::SetEnvironmentVariable('FQDN', $HostName, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable('PUBIP', $PublicIPAddress, [EnvironmentVariableTarget]::Machine)

refreshenv
$env:PATH=$env:PATH + ';C:\Program Files\Mozilla Firefox;C:\Program Files\Microsoft VS Code;C:\Program Files\Git\bin'
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

# Atom is installed to C:\Users\training\AppData\Local\atom so we have to do it in Terraform and not Packer
choco install -y atom

# Create shortcuts
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\PowerShell.lnk")
$Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$shortcut.WorkingDirectory = "$Home"
$Shortcut.Save()

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer'
$advancedKey = "$key\Advanced"
Set-ItemProperty $advancedKey Hidden 1
Set-ItemProperty $advancedKey HideFileExt 0
Set-ItemProperty $advancedKey ShowSuperHidden 1

$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$parts = $identity.Name -split "\\"
$user = @{Domain=$parts[0];Name=$parts[1]}

try{
  try { $explorer = Get-Process -Name explorer -ErrorAction stop -IncludeUserName }
  catch {$global:error.RemoveAt(0)}

  if($explorer -ne $null) {
    $explorer | ? { $_.UserName -eq "$($user.Domain)\$($user.Name)"} | Stop-Process -Force -ErrorAction Stop | Out-Null
  }

  Start-Sleep 1

  if(!(Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
    $global:error.RemoveAt(0)
    start-Process -FilePath explorer
  }
} catch {$global:error.RemoveAt(0)}

Write-Host "Cleaning up"
Remove-Item C:\provision.ps1

Restart-Computer
