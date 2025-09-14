@echo off
REM sqd5.bat
REM Place in: %USERPROFILE%\Downloads
REM Run as Administrator.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must run as Administrator. Run it elevated ^(Right-click Run as Administrator^).
    pause
    exit /b 1
)

REM Set output file
set "outFile=%USERPROFILE%\Downloads\wlan_passwords.txt"

REM Create/clear output file with timestamp
echo Exported on: %date% %time% > "%outFile%"
if %errorLevel% neq 0 (
    echo Cannot write to %outFile%. Check permissions.
    pause
    exit /b 1
)

REM Get WLAN profiles
echo.
echo Extracting WLAN profiles...
echo.

REM Create temporary file for profiles
set "tempProfiles=%temp%\wlan_profiles_temp.txt"
netsh wlan show profiles 2>nul | findstr "All User Profile" > "%tempProfiles%"

REM Check if any profiles found
if not exist "%tempProfiles%" (
    echo No WLAN profiles found. >> "%outFile%"
    echo No WLAN profiles found.
    pause
    exit /b 0
)

REM Process each profile
for /f "tokens=2 delims=:" %%i in ('type "%tempProfiles%"') do (
    call :ProcessProfile "%%i"
)

REM Clean up temp file
del "%tempProfiles%" 2>nul

echo. >> "%outFile%"
echo Done. Results saved to: %outFile% >> "%outFile%"
echo.
echo Done. Results saved to: %outFile%
pause
exit /b 0

:ProcessProfile
REM Remove leading/trailing spaces from profile name
set "profileName=%~1"
set "profileName=%profileName: =%"
if "%profileName%"=="" goto :eof

echo Processing: %profileName%

REM Get profile details with password
set "tempDetail=%temp%\wlan_detail_temp.txt"
netsh wlan show profile name="%profileName%" key=clear 2>nul > "%tempDetail%"

REM Extract password
set "password="
for /f "tokens=2 delims=:" %%j in ('findstr "Key Content" "%tempDetail%" 2^>nul') do (
    set "password=%%j"
)

REM Clean up password (remove leading space)
if defined password (
    set "password=%password:~1%"
) else (
    set "password=<No password saved or open network>"
)

REM Write to output file
echo. >> "%outFile%"
echo SSID: %profileName% >> "%outFile%"
echo Password: %password% >> "%outFile%"
echo ------------------------ >> "%outFile%"

REM Clean up temp file
del "%tempDetail%" 2>nul
goto :eof
