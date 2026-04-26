# Wipe-AllDisks.ps1

⚠️ WARNING: EXTREMELY DESTRUCTIVE SCRIPT ⚠️

This PowerShell script will:

- Elevate privileges to Administrator
- Enumerate ALL available disks on the system
- Use DiskPart `clean all` command on each disk
- Overwrite all data with zeros

## 🚨 Important

- This will PERMANENTLY DELETE all data on all disks
- This includes:
  - Operating System
  - Personal files
  - External drives (if connected)
- Data recovery is NOT possible after execution

## 🧠 Purpose

This script is intended for:
- Educational use
- Lab environments
- Secure disk wiping scenarios

## ⚠️ Use With Extreme Caution

Do NOT run this on:
- Your main system
- Any machine with important data

## ▶️ Usage

Run the script using PowerShell as Administrator:

```powershell
.\Wipe-AllDisks.ps1