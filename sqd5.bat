@echo off
rem extract-wifi-elevate-fixed.bat
rem Drops results to %USERPROFILE%\Downloads\wlan_passwords.txt
rem Works on Windows 7/8/10/11 (tries to handle common localizations)

setlocal enabledelayedexpansion

:: ---- Self-elevate ----
net session >nul 2>&1
if errorlevel 1 (
    echo Requesting elevation...
    powershell -NoProfile -WindowStyle Hidden -Command "Start-Process -FilePath '%~f0' -ArgumentList '' -Verb RunAs" >nul 2>&1
    if errorlevel 1 (
        echo Elevation failed or was cancelled.
        exit /b 1
    )
    exit /b 0
)

:: ---- files ----
set "OUTDIR=%USERPROFILE%\Downloads"
if not exist "%OUTDIR%" mkdir "%OUTDIR%" 2>nul
set "OUTFILE=%OUTDIR%\wlan_passwords.txt"
set "TMP_PROFILES=%TEMP%\wlan_profiles.tmp"
set "TMP_LINES=%TEMP%\wlan_profiles_lines.tmp"
set "TMP_INFO=%TEMP%\wlan_info.tmp"
set "TMP_KEY=%TEMP%\wlan_key_line.tmp"

:: ---- header ----
(
  echo Exported on: %DATE% %TIME%
  echo.
) > "%OUTFILE%"

:: ---- enumerate profiles ----
netsh wlan show profiles > "%TMP_PROFILES%" 2>nul
if not exist "%TMP_PROFILES%" (
    echo Failed to run netsh or no WLAN component present. >> "%OUTFILE%"
    echo No profiles found.
    goto :cleanup
)

:: Try multiple common markers for localization
findstr /i /c:"All User Profile" /c:"All User Profiles" /c:"Perfil de todos los usuarios" /c:"Perfil" /c:"Perfil de usuario" /c:"Profil" /c:"Профиль" /c:"所有用户配置文件" "%TMP_PROFILES%" > "%TMP_LINES%" 2>nul

:: If still empty, attempt fallback: lines containing ":" and "Profile"/"Perfil"/"Profil"
if not exist "%TMP_LINES%" (
    type "%TMP_PROFILES%" | findstr /R ":" > "%TMP_LINES%" 2>nul
)

if not exist "%TMP_LINES%" (
    echo No WLAN profiles found. >> "%OUTFILE%"
    echo No profiles found.
    goto :cleanup
)

:: ---- parse each candidate line for SSID ----
for /f "usebackq delims=" %%L in ("%TMP_LINES%") do (
    rem attempt to split on colon and take right side
    for /f "tokens=1* delims=:" %%A in ("%%L") do (
        set "PART=%%B"
        if defined PART (
            rem trim leading spaces
            for /f "tokens=* delims= " %%S in ("!PART!") do set "SSID=%%S"
            if defined SSID (
                rem remove all double quotes
                set "SSID=!SSID:"=!"
                rem skip empty or header-like lines
                if not "!SSID!"=="" (
                    rem query profile details quietly
                    netsh wlan show profile name="!SSID!" key=clear > "%TMP_INFO%" 2>nul
                    if exist "%TMP_INFO%" (
                        rem look for key content using several common markers
                        findstr /i /c:"Key Content" /c:"Contenido de la clave" /c:"Conteúdo da chave" /c:"Contenu de la clé" /c:"Ключевой" /c:"키 콘텐츠" /c:"密钥内容" "%TMP_INFO%" > "%TMP_KEY%" 2>nul
                        if exist "%TMP_KEY%" (
                            for /f "usebackq tokens=1* delims=:" %%K in ("%TMP_KEY%") do (
                                set "RAWKEY=%%L"
                                for /f "tokens=* delims= " %%P in ("!RAWKEY!") do set "KEY=%%P"
                                if defined KEY (
                                    (
                                      echo SSID: !SSID!
                                      echo Password: !KEY!
                                      echo ------------------------
                                    ) >> "%OUTFILE%"
                                )
                            )
                            del "%TMP_KEY%" 2>nul
                        )
                        del "%TMP_INFO%" 2>nul
                    )
                )
            )
        )
    )
)

echo Done. Results saved to: "%OUTFILE%"
type "%OUTFILE%"

:cleanup
del "%TMP_PROFILES%" 2>nul
del "%TMP_LINES%" 2>nul
del "%TMP_INFO%" 2>nul
del "%TMP_KEY%" 2>nul
endlocal
exit /b 0
