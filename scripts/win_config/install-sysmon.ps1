$sysmonDir = "C:\ProgramData\Sysmon"
$sysmonPath = "C:\Tools\Sysinternals\Sysmon64.exe"

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Sysmon64.exe..."
Try { 
  (New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/Sysmon64.exe', $sysmonPath)
} Catch { 
  Write-Host "HTTPS connection failed. Switching to HTTP :("
  (New-Object System.Net.WebClient).DownloadFile('http://live.sysinternals.com/Sysmon64.exe', $sysmonPath)
}
Copy-Item $sysmonPath $sysmonDir

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Olaf Hartong's Sysmon config..."
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/olafhartong/sysmon-modular/master/sysmonconfig.xml', "$sysmonConfigPath")

# Start Sysmon
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Starting Sysmon..."
Start-Process -FilePath "$sysmonDir\Sysmon64.exe" -ArgumentList "-accepteula -i $sysmonConfigPath"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Waiting 5 seconds to give the service time to install..."
Start-Sleep 5
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Verifying that the Sysmon service is running..."

# Poll the sysmon service every 5 seconds to see if it has started (up to 25 seconds)
$tries = 1
While ($tries -lt 6) {
  If ((Get-Service -name Sysmon64).Status -ne "Running") {
    Write-Host "Waiting for the Sysmon service to start... (Attempt $tries of 5)"
    Start-Sleep 5
    $tries += 1
  } Else {
    Write-Host "The Sysmon service has started successfully!"
    break
  }
}

If ((Get-Service -name Sysmon64).Status -ne "Running")
{
  throw "The Sysmon service failed to start successfully"
}

# Make the event log channel readable. For some reason this doesn't work in the GPO and only works when run manually.
wevtutil sl Microsoft-Windows-Sysmon/Operational "/ca:O:BAG:SYD:(A;;0x5;;;BA)(A;;0x1;;;S-1-5-20)(A;;0x1;;;S-1-5-32-573)"