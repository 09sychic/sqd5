# SQD5 - WiFi Password Extractor

A PowerShell-based tool for extracting saved WiFi passwords on Windows systems. This tool displays a professional interface with progress indicators and saves all results to a text file.

## 🚀 Features

- **Admin Privilege Detection**: Automatically elevates to administrator if needed
- **Animated Progress Indicators**: Professional spinner and progress bar
- **Comprehensive Logging**: Timestamped output with detailed logging
- **Clean Interface**: ASCII banner and color-coded output
- **Safe Execution**: Handles errors gracefully and provides user feedback
- **Export Results**: Saves all WiFi credentials to a text file in Downloads folder

## 📋 Requirements

- Windows Operating System
- PowerShell (built into Windows)
- Administrator privileges (script will auto-elevate)

## 🔧 Installation & Usage

### Method 1: Direct Download & Run (One-liner)

**PowerShell:**
```powershell
iwr -UseBasicParsing "https://raw.githubusercontent.com/09sychic/sqd5/main/sqd5.ps1" -OutFile "$env:TEMP\sqd5.ps1"; Start-Process "powershell.exe" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "$env:TEMP\sqd5.ps1" -Verb RunAs -Wait; Remove-Item "$env:TEMP\sqd5.ps1" -ErrorAction SilentlyContinue
```

**Command Prompt:**
```cmd
powershell -Command "iwr -UseBasicParsing 'https://raw.githubusercontent.com/09sychic/sqd5/main/sqd5.ps1' -OutFile '$env:TEMP\sqd5.ps1'; Start-Process 'powershell.exe' -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', '$env:TEMP\sqd5.ps1' -Verb RunAs -Wait; Remove-Item '$env:TEMP\sqd5.ps1' -ErrorAction SilentlyContinue"
```

**Short URL (Alternative):**
```powershell
iwr -UseBasicParsing "https://is.gd/sqd51" -OutFile "$env:TEMP\sqd5.ps1"; Start-Process "powershell.exe" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "$env:TEMP\sqd5.ps1" -Verb RunAs -Wait; Remove-Item "$env:TEMP\sqd5.ps1" -ErrorAction SilentlyContinue
```

### Method 2: Manual Download

1. Download `sqd5.ps1` from this repository
2. Right-click the file and select "Run with PowerShell"
3. Or open PowerShell as Administrator and run: `.\sqd5.ps1`

## 📖 How It Works

1. **Initialization**: Displays banner and animated spinner
2. **Privilege Check**: Automatically requests administrator privileges if needed
3. **Profile Scanning**: Uses `netsh wlan show profiles` to discover saved networks
4. **Password Extraction**: Retrieves stored passwords using `netsh wlan show profile key=clear`
5. **Results Export**: Saves all findings to `Downloads\wlan_passwords.txt`
6. **User Interface**: Shows real-time progress with colored output

## 📁 Output

The tool creates a file named `wlan_passwords.txt` in your Downloads folder containing:

```
=============================
Wi-Fi Password Extractor
Run Date: 2025-09-16 20:30:45
=============================

SSID: HomeNetwork
Password: mypassword123
------------------------

SSID: OfficeWiFi
Password: <No password saved or open network>
------------------------
```

## ⚠️ Important Notes

### Legal & Ethical Use
- **Only use on your own devices or with explicit permission**
- This tool is for legitimate password recovery purposes
- Unauthorized access to networks is illegal and unethical
- Users are responsible for compliance with local laws

### Technical Requirements
- Requires Administrator privileges to access saved passwords
- Only works with Windows built-in WiFi profiles
- Cannot retrieve passwords from third-party WiFi managers
- Works on Windows 7, 8, 8.1, 10, and 11

## 🛡️ Security Considerations

- The script uses standard Windows `netsh` commands
- No network traffic is generated during execution
- All operations are performed locally on your machine
- Output file is saved to your user Downloads folder
- Script auto-deletes when using the one-liner method

## 🔍 Troubleshooting

### Common Issues

**"Execution Policy" Error:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

**"Access Denied" Error:**
- Ensure you're running as Administrator
- The script will attempt to auto-elevate privileges

**"No profiles found":**
- Check if your device has saved WiFi networks
- Verify Windows WiFi service is running

**Script won't run:**
- Make sure the file has `.ps1` extension
- Try running with: `powershell -ExecutionPolicy Bypass -File sqd5.ps1`

## 📞 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Ensure you have Administrator privileges
3. Verify your Windows version is supported
4. Open an issue on this repository with details

## 📄 License

This project is provided "as-is" for educational and legitimate recovery purposes. Users are responsible for ensuring compliance with applicable laws and regulations.

## ⭐ Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](../../issues).

## 🔗 Useful Links

- [Microsoft netsh Documentation](https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh)
- [PowerShell Execution Policies](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)

---

**⚠️ Disclaimer: This tool is intended for legitimate password recovery on your own devices. Always respect privacy and follow applicable laws.**
