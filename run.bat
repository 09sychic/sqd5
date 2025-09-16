@echo off
setlocal

REM === EDIT IF NEEDED ===
set "RAWURL=https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/sqd5.ps1"
set "PS1FILE=%~dp0sqd5.ps1"
set "LOGFILE=%TEMP%\sqd5_run_log.txt"

REM clear old log
> "%LOGFILE%" echo [%date% %time%] run.bat start

REM === download the ps1 (uses .NET WebClient to avoid complex quoting) ===
powershell -NoProfile -Command ^
  "Try { (New-Object Net.WebClient).DownloadFile('%RAWURL%','%PS1FILE%') ; Write-Output ('Downloaded: %RAWURL% to %PS1FILE%') } Catch { Write-Error 'DOWNLOAD_FAILED: ' + $_.Exception.Message ; exit 1 }" >> "%LOGFILE%" 2>&1

if not exist "%PS1FILE%" (
  echo [%date% %time%] Download failed or file missing. >> "%LOGFILE%"
  echo Download failed. See log: %LOGFILE%
  exit /b 1
)

REM === run the ps1 elevated with ExecutionPolicy Bypass ===
powershell -NoProfile -Command ^
  "Try { Start-Process -FilePath powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"\"%PS1FILE%\"\"' -Verb RunAs -ErrorAction Stop } Catch { Write-Error 'LAUNCH_FAILED: ' + $_.Exception.Message ; exit 1 }" >> "%LOGFILE%" 2>&1

if %ERRORLEVEL% neq 0 (
  echo [%date% %time%] Failed to launch elevated PS1. >> "%LOGFILE%"
  echo Failed to launch elevated PS1. See log: %LOGFILE%
  exit /b %ERRORLEVEL%
)

echo [%date% %time%] Started elevated PS1. >> "%LOGFILE%"
endlocal
