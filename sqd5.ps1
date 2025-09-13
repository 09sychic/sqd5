# extract-wifi.ps1
# Place in: %USERPROFILE%\Downloads
# Run as Administrator.

# check admin
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "This script must run as Administrator. Run it elevated (Right-click Run as Administrator)."
    exit 1
}

$outFile = Join-Path $env:USERPROFILE "Downloads\wlan_passwords.txt"

Try {
    "Exported on: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $outFile -Encoding UTF8 -Force
} Catch {
    Write-Error "Cannot write to $outFile. Check permissions."
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
    exit 0
}

foreach ($p in $profiles) {
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
