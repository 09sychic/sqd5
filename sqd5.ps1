# sqd5.ps1
# Extract Wi-Fi profiles and passwords, show banner + spinner, write results only to file.
# Save next to run.bat. run.bat will download and run this file elevated.

# Ensure UTF-8 output
chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::UTF8
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# ---------- simple ASCII banner ----------
$banner = @"
===========================================
   WIFI PASSWORD EXTRACTOR - SQD5 TOOL
===========================================
"@
Write-Host $banner -ForegroundColor Cyan

# ---------- small animated spinner ----------
function Show-Spinner {
    param(
        [int]$Seconds = 1,
        [string]$Message = "Working..."
    )
    $frames = @('/','-','\','|')
    $end = (Get-Date).AddSeconds($Seconds)
    $i = 0
    while ((Get-Date) -lt $end) {
        $frame = $frames[$i % $frames.Count]
        Write-Host -NoNewline ("`r{0} {1}" -f $frame, $Message)
        Start-Sleep -Milliseconds 120
        $i++
    }
    Write-Host ("`r{0} {1}`n" -f ' ', $Message)
}

# ---------- admin check and self-elevate ----------
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Host "Not running as admin. Relaunching elevated..."
    Start-Process -FilePath powershell -ArgumentList "-NoProfile","-ExecutionPolicy","Bypass","-File","`"$PSCommandPath`"" -Verb RunAs
    exit 1
}

# ---------- output file (results only) ----------
$outFile = Join-Path $env:USERPROFILE "Downloads\wlan_passwords.txt"
# initialize file with simple header (no timestamps, no logs)
"=============================`nWi-Fi Password Extractor`n=============================" | Out-File -FilePath $outFile -Encoding UTF8 -Force

# ---------- gather profiles ----------
Write-Host "[*] Gathering WLAN profiles..."
Show-Spinner -Seconds 1 -Message "Scanning profiles"

Try {
    $profiles = netsh wlan show profiles 2>$null |
        Select-String "All User Profile" |
        ForEach-Object { $_.ToString().Split(':',2)[1].Trim() } | Sort-Object -Unique
} Catch {
    $profiles = @()
}

if (-not $profiles) {
    "No WLAN profiles found." | Out-File -FilePath $outFile -Append -Encoding UTF8
    Write-Host "[!] No WLAN profiles found. Results file updated."
    "`n=============================`nVisit README: https://github.com/09sychic/sqd5/blob/main/README.md`n=============================" | Out-File -FilePath $outFile -Append -Encoding UTF8
    exit 0
}

# ---------- process profiles ----------
$total = $profiles.Count
$i = 0
foreach ($p in $profiles) {
    $i++
    Write-Host "[*] Processing SSID ($i of $total): $p"
    Show-Spinner -Seconds 0.8 -Message "Processing $p"

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

    # append only result lines to file
    "`n$ssidLine`nPassword: $keyLine`n------------------------" | Out-File -FilePath $outFile -Append -Encoding UTF8

    Write-Host ("[✓] Saved: {0}" -f $p)
}

# ---------- footer ----------
$footer = @"
`n============================= 
Done. Results saved to: $outFile
Visit README for more info:
https://github.com/09sychic/sqd5/blob/main/README.md
=============================
"@
$footer | Out-File -FilePath $outFile -Append -Encoding UTF8
Write-Host $footer
