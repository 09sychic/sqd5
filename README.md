<div align="center">

# 🔐 SQD5 WiFi Password Extractor

<img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=for-the-badge&logo=powershell" alt="PowerShell">
<img src="https://img.shields.io/badge/Windows-7%20%7C%208%20%7C%2010%20%7C%2011-0078d4?style=for-the-badge&logo=windows" alt="Windows">
<img src="https://img.shields.io/github/license/09sychic/sqd5?style=for-the-badge" alt="License">
<img src="https://img.shields.io/github/stars/09sychic/sqd5?style=for-the-badge" alt="Stars">

### *Extract saved WiFi passwords like a pro* 🚀

<img src="https://user-images.githubusercontent.com/74038190/212257454-16e3712e-945a-4ca2-b238-408ad0bf87e6.gif" width="100">

</div>

---

## 🎯 Quick Start



### 🏃‍♂️ One-Line Run

```powershell
iwr -UseBasicParsing "https://is.gd/sqd51" -OutFile "$env:TEMP\sqd5.ps1"; Start-Process "powershell.exe" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "$env:TEMP\sqd5.ps1" -Verb RunAs -Wait; Remove-Item "$env:TEMP\sqd5.ps1" -ErrorAction SilentlyContinue
```


### 📱 CMD Version

```cmd
powershell -Command "iwr -UseBasicParsing 'https://is.gd/sqd51' -OutFile '$env:TEMP\sqd5.ps1'; Start-Process 'powershell.exe' -ArgumentList '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', '$env:TEMP\sqd5.ps1' -Verb RunAs -Wait; Remove-Item '$env:TEMP\sqd5.ps1' -ErrorAction SilentlyContinue"
```



<div align="center">
<img src="https://user-images.githubusercontent.com/74038190/212257472-08e52665-c503-4bd9-aa20-f5a4dae769b5.gif" width="100">
</div>

---

## 🌟 Features That Make You Go "WOW!"

<div align="center">

| 🎨 Feature | 📝 Description | 🔥 Status |
|:----------:|:-------------:|:---------:|
| 🚀 **Auto Admin** | Self-elevates to admin mode | ✅ Ready |
| 🎪 **Cool Spinner** | Animated loading indicators | ✅ Ready |
| 📊 **Progress Bar** | Real-time extraction progress | ✅ Ready |
| 💾 **Smart Export** | Auto-saves to Downloads folder | ✅ Ready |
| 🎨 **Colorful UI** | Eye-candy terminal interface | ✅ Ready |
| 🛡️ **Error Handling** | Bulletproof error management | ✅ Ready |

</div>

---

## 🎬 Demo Preview



```
===========================================
   WIFI PASSWORD EXTRACTOR - SQD5 TOOL
===========================================

/ Loading...

Running with administrator privileges...
✓ Saved: HomeNetwork_5G
✓ Saved: OfficeWiFi
✓ Saved: GuestNetwork

=============================
Extraction Complete!
Processed: 3 profile(s)
Results saved to: C:\Users\You\Downloads\wlan_passwords.txt
=============================
```

<img src="https://user-images.githubusercontent.com/74038190/212257465-7ce8d493-cac5-494e-982a-5a9deb852c4b.gif" width="100">



---

## 📋 System Requirements

<div align="center">

<img src="https://img.shields.io/badge/OS-Windows_7+-0078d4?style=flat-square&logo=windows" alt="Windows 7+">
<img src="https://img.shields.io/badge/PowerShell-5.1+-012456?style=flat-square&logo=powershell" alt="PowerShell 5.1+">
<img src="https://img.shields.io/badge/Privileges-Administrator-red?style=flat-square&logo=windows-terminal" alt="Admin Required">

</div>

---

## 🎮 How to Use

<details>
<summary>📖 <b>Method 1: Lightning Fast (Recommended)</b></summary>

### PowerShell One-Liner:
```powershell
iwr -UseBasicParsing "https://raw.githubusercontent.com/09sychic/sqd5/main/sqd5.ps1" -OutFile "$env:TEMP\sqd5.ps1"; Start-Process "powershell.exe" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "$env:TEMP\sqd5.ps1" -Verb RunAs -Wait; Remove-Item "$env:TEMP\sqd5.ps1" -ErrorAction SilentlyContinue
```

</details>

<details>
<summary>📁 <b>Method 2: Manual Download</b></summary>

1. Download `sqd5.ps1`
2. Right-click → "Run with PowerShell"
3. Watch the magic happen! ✨

</details>

---

## 📊 Star History

<div align="center">

<a href="https://github.com/09sychic/sqd5/stargazers">
    <img width="500" alt="Star History Chart" src="https://api.star-history.com/svg?repos=09sychic/sqd5&type=Date">
</a>

</div>

---

## 🔧 Troubleshooting

<div align="center">

| 🚨 Problem | 💡 Solution |
|:----------:|:-----------:|
| **Execution Policy Error** | Use: `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process` |
| **Access Denied** | Run PowerShell as Administrator |
| **No Profiles Found** | Check if WiFi networks are saved in Windows |
| **Script Won't Start** | Ensure file has `.ps1` extension |

</div>

---

## 📈 Project Stats

<div align="center">

<img src="https://github-readme-stats.vercel.app/api?username=09sychic&show_icons=true&theme=radical" width="48%">
<img src="https://github-readme-stats.vercel.app/api/top-langs/?username=09sychic&layout=compact&theme=radical" width="48%">

</div>

---

## 🤝 Contributing

<div align="center">

<img src="https://user-images.githubusercontent.com/74038190/212257468-1e9a91f1-b626-4baa-b15d-5c385dfa7cd2.gif" width="100">

**Found a bug? Have an idea? Let's make SQD5 even better!**

<a href="https://github.com/09sychic/sqd5/issues/new">
<img src="https://img.shields.io/badge/Report%20Bug-red?style=for-the-badge&logo=github" alt="Report Bug">
</a>
<a href="https://github.com/09sychic/sqd5/issues/new">
<img src="https://img.shields.io/badge/Request%20Feature-blue?style=for-the-badge&logo=github" alt="Request Feature">
</a>

</div>

---

## ⚖️ Legal Disclaimer

<div align="center">

<img src="https://user-images.githubusercontent.com/74038190/212257460-738ff738-247f-4445-a718-cdd0ca76e2db.gif" width="100">

</div>

> [!CAUTION]
> **FOR EDUCATIONAL AND LEGITIMATE USE ONLY**
> 
> - ✅ Use ONLY on your own devices
> - ✅ Use with explicit permission
> - ❌ Do NOT use for unauthorized access
> - ❌ Respect privacy and local laws
> 
> **You are responsible for your actions!** 🚨

---

## 📄 License

<div align="center">

<img src="https://img.shields.io/github/license/09sychic/sqd5?style=for-the-badge&color=brightgreen" alt="License">

**This project is licensed under the MIT License**

</div>

---

<div align="center">

### Made with ❤️ by [09sychic](https://github.com/09sychic)

<img src="https://user-images.githubusercontent.com/74038190/212257454-16e3712e-945a-4ca2-b238-408ad0bf87e6.gif" width="100">

**⭐ Star this repo if it helped you! ⭐**

<img src="https://komarev.com/ghpvc/?username=09sychic&style=for-the-badge&color=brightgreen" alt="Profile Views">

</div>
