:: run-extract-from-github.bat
@echo off
REM Edit RAWURL to your raw GitHub URL (raw.githubusercontent.com/...)
set "RAWURL=https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/sqd5.ps1"

REM Download the raw PS1 into the same folder as this .bat
powershell -NoProfile -Command "Try { Invoke-WebRequest -Uri '%RAWURL%' -OutFile '%~dp0sqd5.ps1' -UseBasicParsing -ErrorAction Stop } Catch { Write-Error 'Download failed'; Exit 1 }"

REM Optional: open the file for quick manual review before running
REM notepad "%~dp0extract-wifi.ps1"

REM Run the downloaded PS1 elevated with execution policy bypass (prompts UAC)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0sqd5.ps1\"' -Verb RunAs"
