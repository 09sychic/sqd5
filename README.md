# README — Run `sqd5.ps1` via `iwr | iex`

## Purpose
`sqd5.ps1` extracts saved Wi-Fi SSIDs and passwords from a Windows machine.  
- Only profiles with stored passwords are listed.  
- Open networks are skipped.  
- Output goes to `%USERPROFILE%\Downloads\wlan_passwords.txt`.  

## Security Warning
- The output contains plaintext Wi-Fi passwords.  
- Run only on machines you own or have permission to access.  
- Treat the output as sensitive and delete/encrypt after use.  

## Quick Run (Direct `iwr | iex`)
1. Open **Windows PowerShell** (normal or elevated).  
2. Paste the following command:

```powershell
iex (iwr -UseBasicParsing "https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/sqd5.ps1").Content
