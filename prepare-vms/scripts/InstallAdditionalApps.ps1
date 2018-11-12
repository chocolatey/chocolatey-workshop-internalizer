if ($null -eq (Get-Command -Name 'choco.exe' -ErrorAction SilentlyContinue)) {
  Write-Warning "Chocolatey not installed. Cannot install standard packages."
}
else {
  @( 'vscode', 'git', 'googlechrome', 'firefox', 'pester' ) | ForEach-Object {
      choco upgrade $_ -y --no-progress
  }
}
