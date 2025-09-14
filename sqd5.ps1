# extract-wifi.ps1
# Place in: %USERPROFILE%\Downloads
# Run as Administrator.

# check admin
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must run as Administrator. Run it elevated (Right-click Run as Administrator)."
    Read-Host "Press Enter to exit"
    exit 1
}

$outFile = Join-Path $env:USERPROFILE "Downloads\wlan_passwords.txt"

Try {
    "Exported on: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $outFile -Encoding UTF8 -Force
} Catch {
    Write-Error "Cannot write to $outFile. Check permissions."
    Read-Host "Press Enter to exit"
    exit 1
}

# get profiles
Try {
    $profiles = netsh wlan show profiles 2>$null |
        Select-String "All User Profile" |
        ForEach-Object { $_.ToString().Split(':',2)[1].Trim() } | Sort-Object -Unique
} Catch {
    $profiles = @()
}

if (-not $profiles) {
    "No WLAN profiles found." | Out-File -FilePath $outFile -Append -Encoding UTF8
    Write-Host "No WLAN profiles found. Check the output file for details."
    # Open the file even if no profiles found
    Start-Process -FilePath $outFile
    Start-Sleep -Seconds 2
    exit 0
}

Write-Host "Processing $($profiles.Count) WiFi profiles..."

foreach ($p in $profiles) {
    Write-Host "Processing: $p"
    Try {
        $info = netsh wlan show profile name="$p" key=clear 2>$null
    } Catch {
        $info = $null
    }
    
    $ssidLine = "SSID: $p"
    $keyLine = $null
    
    if ($info) {
        $keyLine = ($info | Select-String "Key Content" | ForEach-Object {
            $_.ToString().Split(':',2)[1].Trim()
        }) -join ''
    }
    
    if (-not $keyLine) {
        $keyLine = "<No password saved or open network>"
    }
    
    "`n$ssidLine`nPassword: $keyLine`n------------------------" | Out-File -FilePath $outFile -Append -Encoding UTF8
}

"Done. Results saved to: $outFile" | Out-File -FilePath $outFile -Append -Encoding UTF8

Write-Host "`nWiFi passwords extracted successfully!"
Write-Host "Opening results file: $outFile"

# Function to auto-open file and close PowerShell
function Open-FileAndClose {
    param([string]$FilePath)
    
    Try {
        # Open the file with default application (usually Notepad for .txt files)
        Start-Process -FilePath $FilePath -ErrorAction Stop
        
        # Wait a moment for the file to open
        Start-Sleep -Seconds 2
        
        Write-Host "File opened successfully. Closing PowerShell in 3 seconds..."
        Start-Sleep -Seconds 3
        
        # Close any CMD windows that might be open (if script was run from CMD)
        Get-Process -Name "cmd" -ErrorAction SilentlyContinue | Where-Object {
            $_.MainWindowTitle -like "*cmd*" -or $_.MainWindowTitle -eq ""
        } | Stop-Process -Force -ErrorAction SilentlyContinue
        
        # Close PowerShell window
        Stop-Process -Id $PID -Force
        
    } Catch {
        Write-Host "Could not open file automatically. File saved to: $FilePath"
        Write-Host "Press Enter to exit..."
        Read-Host
    }
}

# Call the function to open file and close PowerShell
Open-FileAndClose -FilePath $outFile
