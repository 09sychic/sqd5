@echo off
REM run-extract-silent.bat
REM - Saves SSIDs and saved passwords to %USERPROFILE%\Downloads\wlan_passwords.txt
REM - Skips profiles with no saved password
REM - Elevates (UAC prompt). After elevation, extraction runs hidden.
REM - No console output unless an error occurs.

:: Self-elevate if not running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList 'elev' -Verb RunAs"
    exit /b
)

:: If launched elevated, run hidden PowerShell to do the actual work
if /I "%1"=="elev" (
    set "TMPPS1=%TEMP%\_extract_wifi_hidden.ps1"

    > "%TMPPS1%" echo # temporary PS1 created by run-extract-silent.bat
    >> "%TMPPS1%" echo $outFile = Join-Path $env:USERPROFILE 'Downloads\wlan_passwords.txt'
    >> "%TMPPS1%" echo "Exported on: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" ^| Out-File -FilePath $outFile -Encoding UTF8 -Force
    >> "%TMPPS1%" echo '' ^| Out-File -FilePath $outFile -Append -Encoding UTF8
    >> "%TMPPS1%" echo $profiles = netsh wlan show profiles 2^>^$null ^| Select-String 'All User Profile' ^| ForEach-Object { $_.ToString().Split(':',2)[1].Trim() } ^| Sort-Object -Unique
    >> "%TMPPS1%" echo if (-not $profiles) { 'No WLAN profiles found.' ^| Out-File -FilePath $outFile -Append -Encoding UTF8; exit 0 }
    >> "%TMPPS1%" echo foreach ($p in $profiles) {
    >> "%TMPPS1%" echo     $info = netsh wlan show profile name="^$p" key=clear 2^>^$null
    >> "%TMPPS1%" echo     $key = $info ^| Select-String 'Key Content' ^| ForEach-Object { $_.ToString().Split(':',2)[1].Trim() } ^| ForEach-Object { $_ } -join ''
    >> "%TMPPS1%" echo     if ($key -and $key.Trim().Length -gt 0) {
    >> "%TMPPS1%" echo         "WLAN: ^$p" ^| Out-File -FilePath $outFile -Append -Encoding UTF8
    >> "%TMPPS1%" echo         "PASSWORD: ^$key" ^| Out-File -FilePath $outFile -Append -Encoding UTF8
    >> "%TMPPS1%" echo         '' ^| Out-File -FilePath $outFile -Append -Encoding UTF8
    >> "%TMPPS1%" echo         '----------------------------------------' ^| Out-File -FilePath $outFile -Append -Encoding UTF8
    >> "%TMPPS1%" echo         '' ^| Out-File -FilePath $outFile -Append -Encoding UTF8
    >> "%TMPPS1%" echo     }
    >> "%TMPPS1%" echo }
    >> "%TMPPS1%" echo # done

    powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%TMPPS1%"

    if exist "%TMPPS1%" del /f /q "%TMPPS1%" >nul 2>&1

    exit /b 0
)

:: If reached here, script is running elevated but not with the 'elev' arg.
:: Relaunch self with 'elev' to run hidden PowerShell (this branch should not normally run).
powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList 'elev' -Verb RunAs"
exit /b
