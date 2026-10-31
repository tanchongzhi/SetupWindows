# SetupWindows

A highly modular, zero-dependency collection of PowerShell scripts designed to initialize, debloat, secure, customize, and manage features on your Windows installation.

Instead of a monolithic script, **SetupWindows** uses an intent-driven architecture. Every script is strictly standalone, allowing you to run a complete system initialization or surgically apply specific tweaks and features without worrying about broken dependencies.

## 💻 System Requirements
* **Minimum OS:** Windows 7
* **Supported OS:** Windows 7, 8, 8.1, 10, and 11
* **Privileges:** Administrator rights are required.
* *(Note: Scripts include "Smart Guard Clauses" that will automatically detect your OS version and safely skip incompatible tweaks without throwing errors.)*

## 📂 Project Structure

The project is divided into three main pillars:

### 1. `/Initialization` (Core Setup)
The foundational configuration scripts, organized strictly by **User Intent**:
* **`Apps/`** - Manage built-in software (e.g., Remove Bloatware/People, Configure Edge/IE).
* **`Input/`** - Configure typing and legacy language bar settings.
* **`Network/`** - OS network behaviors (e.g., Media Sharing, Modern Standby).
* **`Privacy/`** - Stop telemetry, cloud content, AI tracking, and completely remove Cortana.
* **`Security/`** - OS hardening, disabling vulnerable protocols (e.g., AutoPlay, Remote Access, Anonymous Logon).
* **`System/`** - Core OS behaviors, power states, and file system tweaks.
* **`UI/`** - Visual layouts, Start Menu, Taskbar, and hiding annoying buttons (Meet Now, Chat, Widgets).

### 2. `/Features` (Component Management)
Scripts to easily toggle, install, or configure major Windows capabilities and advanced security states.
* **Virtualization & Subsystems:** Hyper-V, WSL2
* **IT & Dev Tools:** OpenSSH, Group Policy Object Editor
* **Advanced Security:** Memory Integrity (Core Isolation), UserChoice Protection Driver, Remote Desktop

### 3. `/Helpers` (Quality-of-Life Utilities)
Standalone utility scripts designed for specific, on-demand administrative tasks:
* `Set-AutoAdminLogon` - Configure automatic Windows logon.
* `Update-Environment*` - Dynamically refresh system environment variables without rebooting.
* `Update-Shell*` - Customize right-click context menus (SendTo, New submenu).

## 🚀 Usage

You can run any individual script directly from its folder, or use the main entry script for a complete fresh-install setup.

**For a full system initialization:**
1. Open PowerShell as **Administrator**.
2. Temporarily bypass the execution policy and run the main entry script:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Initialization\Initialize-System.ps1
# (Or simply run Initialization\Initialize-System.bat)
```

**For on-demand features or helpers:**
Simply execute the desired script directly:
```powershell
.\Features\Install-WSL2.ps1
.\Helpers\Update-EnvironmentPath.ps1
```

## ⚠️ Disclaimer
Always review the scripts before running them on a production machine. Modifying system registries, group policies, and core features can affect system behavior. Use at your own risk.
