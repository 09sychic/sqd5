
# sqd5 - WiFi Extractor

Simple Windows tools to download and run an elevated PowerShell extractor that writes saved Wi-Fi SSIDs and passwords to your Downloads folder.

**Important:** Use only on machines and networks you own or have explicit permission to inspect. The output contains sensitive credentials.

## Files
- `run.bat`  
  Downloads `sqd5.ps1` from a GitHub raw URL and launches it elevated. Edit the RAWURL variable before use.

- `sqd5.ps1`  
  PowerShell script. Requires Administrator. Writes formatted output to:
  `C:\Users\<YourUser>\Downloads\wlan_passwords.txt`  
  Skips profiles with no saved password.

- `sqd5.bat`  
  Local launcher. Elevates then runs `sqd5.ps1` in a hidden PowerShell window if the PS1 is in the same folder.

## Quick usage
1. Place `run.bat` in Downloads and set `RAWURL` to your raw GitHub URL for `sqd5.ps1`.  
2. Double-click `run.bat`. Approve the UAC prompt.  
3. Open `C:\Users\<YourUser>\Downloads\wlan_passwords.txt` when done.  
4. Delete the output file when finished.

## Safety and notes
- One UAC prompt will appear. You must approve it to reveal passwords.  
- Inspect `sqd5.ps1` before approving UAC. Open it in Notepad.  
- Do not publish output or share it on public systems.  
- If scripts are blocked by policy, run PowerShell as Administrator and set:
