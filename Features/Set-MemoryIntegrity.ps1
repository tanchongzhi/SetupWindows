#Requires -RunAsAdministrator

param (
    [Parameter(Mandatory = $true, ParameterSetName = 'Enable')]
    [switch]
    $Enable,

    [Parameter(Mandatory = $true, ParameterSetName = 'Disable')]
    [switch]
    $Disable
)

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    throw 'The operating system must be Windows 10 or later.'
}

# See: https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=reg#how-to-turn-on-memory-integrity

if ($Enable) {
    Write-Host 'Enabling Memory Integrity without UEFI Lock'

    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'EnableVirtualizationBasedSecurity' -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'RequirePlatformSecurityFeatures' -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'Locked' -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Enabled' -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'WasEnabledBy' -Value 2 -Type DWord
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Locked' -Value 0 -Type DWord

    exit 0
}

if ($Disable) {
    $ErrorActionPreference = 'SilentlyContinue'

    Remove-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'EnableVirtualizationBasedSecurity'
    Remove-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'RequirePlatformSecurityFeatures'
    Remove-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard' -Name 'Locked'
    Remove-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Enabled'
    Remove-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'WasEnabledBy'
    Remove-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Locked'

    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Enabled' -Value 0 -Type DWord

    exit 0
}
