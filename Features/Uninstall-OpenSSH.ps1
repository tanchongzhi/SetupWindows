#Requires -Version 5.1
#Requires -RunAsAdministrator

[CmdletBinding(DefaultParameterSetName = 'UninstallServerAndClient')]
param (
    [Parameter(ParameterSetName = 'UninstallServerAndClient')]
    [switch]
    $Force,

    [Parameter(Mandatory = $true, ParameterSetName = 'ServerOnly')]
    [switch]
    $ServerOnly,

    [Parameter(Mandatory = $true, ParameterSetName = 'ClientOnly')]
    [switch]
    $ClientOnly
)

$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10 -or $osVersion.Build -lt 17763) {
    throw 'The operating system must be at least Windows 10 (Version 1809).'
}

function Uninstall-OpenSSHServer {
    Write-Host 'Uninstalling OpenSSH Server'
    Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Server*' -and $_.State -eq 'Installed' } | Remove-WindowsCapability -Online
}

function Uninstall-OpenSSHClient {
    Write-Host 'Disabling Windows feature: OpenSSH Client'
    Get-WindowsCapability -Online | Where-Object { $_.Name -like 'OpenSSH.Client*' -and $_.State -eq 'Installed' } | Remove-WindowsCapability -Online
}

if ($ServerOnly) {
    Uninstall-OpenSSHServer
} elseif ($ClientOnly) {
    Uninstall-OpenSSHClient
} else {
    if (-not $Force) {
        $title = 'Uninstall OpenSSH Client and Server'
        $question = 'Are you sure you want to perform this action?'
        $choices = @('&Yes', '&No')

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)

        if ($decision -ne 0) {
            return
        }
    }

    Uninstall-OpenSSHServer
    Uninstall-OpenSSHClient
}

Write-Warning 'The OpenSSH configuration files, registry keys, and firewall rules need to be deleted manually.'
