# Define variables
$updateFileUrl = "http://192.168.2.245:2040/NewLook/Wdmgr/Updates/nlupdate.txt"
$localUpdateFile = "$env:TEMP\nlupdate.txt"
$smartClientPath = "C:\newlook 8.0 windows\smartclient.exe"
$options = "-iwdmgr\wdmgrwn.ini -cWoodManager"
$license = "smartclient"

# Download the update file
try {
    Invoke-WebRequest -Uri $updateFileUrl -OutFile $localUpdateFile -UseBasicParsing
    Write-Host "Update file downloaded successfully."
} catch {
    Write-Warning "Failed to download update file: $_"
}

# Launch SmartClient
try {
    Start-Process -FilePath $smartClientPath -ArgumentList "$options" -WindowStyle Hidden
    Write-Host "SmartClient launched."
} catch {
    Write-Error "Failed to launch SmartClient: $_"
}

# Optional: Auto-close PowerShell window after 1 second
Start-Sleep -Seconds 1
exit
