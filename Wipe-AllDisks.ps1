# Wipe-AllDisks.ps1
# Forces elevation, then securely wipes ALL present disks using DiskPart clean all

# --- Force Admin Elevation ---
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    
    Write-Host "Restarting script with Administrator rights..."
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Enumerate all disks ---
$disks = Get-Disk | Where-Object { $_.PartitionStyle -ne 'RAW' -or $_.Number -ge 0 }

# Build DiskPart script for all disks
$dpScript = ""
foreach ($disk in $disks) {
    $dpScript += "select disk $($disk.Number)`r`n"
    $dpScript += "clean all`r`n"
}
$dpScript += "exit`r`n"

# Save to temp file
$tempFile = [System.IO.Path]::GetTempFileName()
Set-Content -Path $tempFile -Value $dpScript

# Run DiskPart
Write-Host "Securely wiping ALL detected disks (this may take a long time)..."
Start-Process diskpart -ArgumentList "/s `"$tempFile`"" -Wait -NoNewWindow

# Cleanup
Remove-Item $tempFile -Force
Write-Host "All disks have been securely wiped with zeros."
