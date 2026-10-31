#Requires -RunAsAdministrator

param (
    [Parameter(Mandatory = $true, ParameterSetName = 'Auto')]
    [switch]
    $Auto,

    [Parameter(Mandatory = $true, ParameterSetName = 'Off')]
    [switch]
    $Off
)

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    throw 'The operating system must be Windows 10 or later.'
}

$launchType = if ($Auto) {
    'auto'
} elseif ($Off) {
    'off'
}

Write-Host "Setting Windows Hypervisor Launch Type: $launchType"
bcdedit /set hypervisorlaunchtype $launchType
