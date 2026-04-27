#Requires -Version 5.1
#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    throw 'The operating system must be Windows 10 or later.'
}

Write-Host 'Enabling Windows Feature: Microsoft Hyper-V'
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart

Write-Host 'Enabling Windows Feature: Windows Hypervisor Platform'
Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart

Write-Host 'Setting Windows Hypervisor Launch Type: Auto'
bcdedit /set hypervisorlaunchtype auto
