$ErrorActionPreference = 'Stop'

Write-Output 'Set Windows Updates to manual'
Cscript $env:WinDir\System32\SCregEdit.wsf /AU 1
Net stop wuauserv
Net start wuauserv

Write-Output 'Disable Windows Defender'
Set-MpPreference -DisableRealtimeMonitoring $true

Write-Output 'Do not open Server Manager at logon'
New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "1" -Force

Write-Output 'Install bginfo'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (!(Test-Path 'c:\Program Files\sysinternals')) {
  New-Item -Path 'c:\Program Files\sysinternals' -type directory -Force -ErrorAction SilentlyContinue
}
if (!(Test-Path 'c:\Program Files\sysinternals\bginfo.exe')) {
  (New-Object Net.WebClient).DownloadFile('http://live.sysinternals.com/bginfo.exe', 'c:\Program Files\sysinternals\bginfo.exe')
}
if (!(Test-Path 'c:\Program Files\sysinternals\bginfo.bgi')) {
  (New-Object Net.WebClient).DownloadFile('https://github.com/StefanScherer/windows-docker-workshop/raw/master/prepare-vms/azure/packer/bginfo.bgi', 'c:\Program Files\sysinternals\bginfo.bgi')
}
if (!(Test-Path 'c:\Program Files\sysinternals\background.jpg')) {
  (New-Object Net.WebClient).DownloadFile('https://github.com/StefanScherer/windows-docker-workshop/raw/master/prepare-vms/azure/packer/background.jpg', 'c:\Program Files\sysinternals\background.jpg')
}
$vbsScript = @'
WScript.Sleep 2000
Dim objShell
Set objShell = WScript.CreateObject( "WScript.Shell" )
objShell.Run("""c:\Program Files\sysinternals\bginfo.exe"" /accepteula ""c:\Program Files\sysinternals\bginfo.bgi"" /silent /timer:0")
'@
$vbsScript | Out-File 'c:\Program Files\sysinternals\bginfo.vbs'
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name bginfo -Value 'wscript "c:\Program Files\sysinternals\bginfo.vbs"'
wscript "c:\Program Files\sysinternals\bginfo.vbs"

Write-Output 'Install Chocolatey'
Invoke-WebRequest 'https://chocolatey.org/install.ps1' -UseBasicParsing | Invoke-Expression

Write-Output 'Install editors'
choco install -y vscode

Write-Output 'Install Git'
choco install -y git

Write-Output 'Install browsers'
choco install -y googlechrome
choco install -y firefox

Write-Output 'Install Chocolatey.Server'
$siteName = 'ChocolateyServer'
$appPoolName = 'ChocolateyServerAppPool'
$sitePath = 'c:\tools\chocolatey.server'

function Add-Acl {
    [CmdletBinding()]
    Param (
        [string]$Path,
        [System.Security.AccessControl.FileSystemAccessRule]$AceObject
    )

    Write-Verbose "Retrieving existing ACL from $Path"
    $objACL = Get-ACL -Path $Path
    $objACL.AddAccessRule($AceObject)
    Write-Verbose "Setting ACL on $Path"
    Set-ACL -Path $Path -AclObject $objACL
}

function New-AclObject {
    [CmdletBinding()]
    Param (
        [string]$SamAccountName,
        [System.Security.AccessControl.FileSystemRights]$Permission,
        [System.Security.AccessControl.AccessControlType]$AccessControl = 'Allow',
        [System.Security.AccessControl.InheritanceFlags]$Inheritance = 'None',
        [System.Security.AccessControl.PropagationFlags]$Propagation = 'None'
    )

    New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule($SamAccountName, $Permission, $Inheritance, $Propagation, $AccessControl)
}

if ($null -eq (Get-Command -Name 'choco.exe' -ErrorAction SilentlyContinue)) {
    Write-Warning "Chocolatey not installed. Cannot install standard packages."
    Exit 1
}
# Install Chocolatey.Server prereqs
choco install IIS-WebServer --source windowsfeatures
choco install IIS-ASPNET45 --source windowsfeatures

# Install Chocolatey.Server
choco upgrade chocolatey.server -y

# Step by step instructions here https://chocolatey.org/docs/how-to-set-up-chocolatey-server#setup-normally
# Import the right modules
Import-Module WebAdministration
# Disable or remove the Default website
Get-Website -Name 'Default Web Site' | Stop-Website
Set-ItemProperty "IIS:\Sites\Default Web Site" serverAutoStart False    # disables website

# Set up an app pool for Chocolatey.Server. Ensure 32-bit is enabled and the managed runtime version is v4.0 (or some version of 4). Ensure it is "Integrated" and not "Classic".
New-WebAppPool -Name $appPoolName -Force
Set-ItemProperty IIS:\AppPools\$appPoolName enable32BitAppOnWin64 True       # Ensure 32-bit is enabled
Set-ItemProperty IIS:\AppPools\$appPoolName managedRuntimeVersion v4.0       # managed runtime version is v4.0
Set-ItemProperty IIS:\AppPools\$appPoolName managedPipelineMode Integrated   # Ensure it is "Integrated" and not "Classic"
Restart-WebAppPool -Name $appPoolName   # likely not needed ... but just in case

# Set up an IIS website pointed to the install location and set it to use the app pool.
New-Website -Name $siteName -ApplicationPool $appPoolName -PhysicalPath $sitePath

# Add permissions to c:\tools\chocolatey.server:
'IIS_IUSRS', 'IUSR', "IIS APPPOOL\$appPoolName" | ForEach-Object {
    $obj = New-AclObject -SamAccountName $_ -Permission 'ReadAndExecute' -Inheritance 'ContainerInherit','ObjectInherit'
    Add-Acl -Path $sitePath -AceObject $obj
}

# Add the permissions to the App_Data subfolder:
$appdataPath = Join-Path -Path $sitePath -ChildPath 'App_Data'
'IIS_IUSRS', "IIS APPPOOL\$appPoolName" | ForEach-Object {
    $obj = New-AclObject -SamAccountName $_ -Permission 'Modify' -Inheritance 'ContainerInherit', 'ObjectInherit'
    Add-Acl -Path $appdataPath -AceObject $obj
}

Write-Output 'Install Jenkins'
choco install -y jenkins

Write-Output 'Disable autologon'
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon -PropertyType DWORD -Value "0" -Force

Write-Output 'Install all Windows Updates'
Get-Content C:\windows\system32\en-us\WUA_SearchDownloadInstall.vbs | ForEach-Object {
  $_ -replace 'confirm = msgbox.*$', 'confirm = vbNo'
} | Out-File $env:TEMP\WUA_SearchDownloadInstall.vbs
"a`na`na`na" | cscript $env:TEMP\WUA_SearchDownloadInstall.vbs
