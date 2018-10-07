[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-Host "Downloading Jenkins package..."

$jenkinsDownloadUrl = $env:JENKINS_DOWNLOAD_URL;
$azureSas = $env:AZURE_SAS;
$downloadPath = "c:\packages"

if(!(Test-Path $downloadPath)) {
  New-Item -ItemType Directory -Path $downloadPath
}

if($jenkinsDownloadUrl -And $azureSas) {
  $fullDownloadUrl = "$jenkinsDownloadUrl$azureSas"
  (New-Object Net.WebClient).DownloadFile($fullDownloadUrl, "$downloadPath\jenkins.2.138.1.nupkg")
  Write-Host "Download complete."
} else {
  Write-Host "Unable to download Jenkins nupkg"
}

choco upgrade jenkins -y --source="'c:\packages'"

Write-Host "Stopping Jenkins service."
Stop-Service -Name jenkins

if(!(Test-Path "c:\scripts")) {
  New-Item -ItemType Directory -Path "c:\scripts"
}

Write-Host "Starting Jenkins service."
Start-Service -Name Jenkins

Write-Host "Downloading Jenkins Scripts..."

(New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/scripts/ConvertTo-ChocoObject.ps1', 'C:\scripts\ConvertTo-ChocoObject.ps1')
(New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/scripts/Update-ProdRepoFromTest.ps1', 'C:\scripts\Update-ProdRepoFromTest.ps1')
(New-Object Net.WebClient).DownloadFile('https://github.com/gep13/chocolatey-internalizer-workshop/raw/master/prepare-vms/scripts/Get-UpdatedPackage.ps1', 'C:\scripts\Get-UpdatedPackage.ps1')

Write-Host "Waiting up to 60 seconds for Jenkins to respond."
# loop either 60 times or until we get a 403 status code response (403 means we
# are unauthorised and the service is therefore up)
$status = 0
$waitSeconds = 60
for ($i = 0; $i -lt $waitSeconds -and $status -ne 403; $i++) {
  Start-Sleep -Seconds 1
  try {
    $request = $null
    $request = Invoke-WebRequest -Uri 'http://localhost:8080' -UseBasicParsing
  }
  catch {
    $request = $_.exception.response
  }
  $status = [int]$request.StatusCode
}

# check how long we waited
if ($i -ge $waitSeconds) {
    Write-Error "Timed out waiting $waitSeconds seconds for Jenkins to restart."
}
else {
    Write-Host "Waited $i seconds for Jenkins to restart."

    $pw = Get-Content "c:\program files (x86)\jenkins\secrets\initialAdminPassword"
    Set-Location "c:\program files (x86)\jenkins\jre\bin"

    Write-Host "Installing Jenkins plugins."
    "build-timeout", "workflow-aggregator", "pipeline-stage-view", "powershell" | ForEach-Object {
       # Just wait an extra 5 seconds to be sure
        Start-Sleep -Seconds 5

        .\java.exe -jar ..\..\war\web-inf\jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$pw install-plugin $_
    }

    Write-Host "Restarting Jenkins service."
    Restart-Service -Name jenkins
}
