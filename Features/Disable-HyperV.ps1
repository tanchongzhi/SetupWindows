#Requires -Version 5.1
#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    throw 'The operating system must be Windows 10 or later.'
}

Write-Host 'Disabling Windows Feature: Microsoft Hyper-V'
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart

Write-Host 'Disabling Windows Feature: Windows Hypervisor Platform'
Disable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart
