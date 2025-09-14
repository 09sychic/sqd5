@echo off
rem extract-wifi-elevate.bat
rem Save to: %USERPROFILE%\Downloads\extract-wifi-elevate.bat
rem This script will relaunch itself with Administrator privileges if not already elevated.

setlocal enabledelayedexpansion

:: --- self-elevate if not admin ---
net session >nul 2>&1
if errorlevel 1 (
    echo Requesting elevation...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList '' -Verb RunAs" >nul 2>&1
    if errorlevel 1 (
        echo Failed to request elevation or user cancelled.
        exit /b 1
    )
    exit /b 0
)

:: --- output file ---
set "OUTFILE=%USERPROFILE%\Downloads\wlan_passwords.txt"
if not exist "%USERPROFILE%\Downloads" mkdir "%USERPROFILE%\Downloads" 2>nul
( 
  echo Exported on: %DATE% %TIME%
) > "%OUTFILE%"

:: --- gather profiles ---
set "TMP_PROFILES=%TEMP%\wlan_profiles.tmp"
netsh wlan show profiles > "%TMP_PROFILES%" 2>nul

if not exist "%TMP_PROFILES%" (
    echo Failed to enumerate WLAN profiles. >> "%OUTFILE%"
    echo No profiles found.
    exit /b 0
)

:: Look for typical English marker "All User Profile".
findstr /c:"All User Profile" "%TMP_PROFILES%" > "%TEMP%\wlan_profiles_lines.tmp" 2>nul

if not exist "%TEMP%\wlan_profiles_lines.tmp" (
    echo No WLAN profiles found. >> "%OUTFILE%"
    del "%TMP_PROFILES%" 2>nul
    exit /b 0
)

for /f "usebackq tokens=1* delims=:" %%A in ("%TEMP%\wlan_profiles_lines.tmp") do (
    set "RAWSSID=%%B"
    if defined RAWSSID (
        for /f "tokens=* delims= " %%S in ("!RAWSSID!") do (
            set "SSID=%%S"
            rem remove surrounding quotes if any
            if "!SSID:~0,1!"=="^"" set "SSID=!SSID:~1,-1!"
            if defined SSID (
                rem query profile details
                set "TMP_INFO=%TEMP%\wlan_info.tmp"
                netsh wlan show profile name="!SSID!" key=clear > "%TMP_INFO%" 2>nul

                if exist "%TMP_INFO%" (
                    rem look for "Key Content" line
                    findstr /c:"Key Content" "%TMP_INFO%" > "%TEMP%\wlan_key_line.tmp" 2>nul
                    if exist "%TEMP%\wlan_key_line.tmp" (
                        for /f "usebackq tokens=1* delims=:" %%K in ("%TEMP%\wlan_key_line.tmp") do (
                            set "RAWKEY=%%L"
                            for /f "tokens=* delims= " %%P in ("!RAWKEY!") do set "KEY=%%P"
                            if defined KEY (
                                (
                                  echo.
                                  echo SSID: !SSID!
                                  echo Password: !KEY!
                                  echo ------------------------
                                ) >> "%OUTFILE%"
                            )
                        )
                        del "%TEMP%\wlan_key_line.tmp" 2>nul
                    )
                    del "%TMP_INFO%" 2>nul
                )
            )
        )
    )
)

del "%TMP_PROFILES%" 2>nul
del "%TEMP%\wlan_profiles_lines.tmp" 2>nul

echo Done. Results saved to: "%OUTFILE%"
exit /b 0
