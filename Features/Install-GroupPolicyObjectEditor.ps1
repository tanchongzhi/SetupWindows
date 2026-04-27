#Requires -Version 5.1
#Requires -RunAsAdministrator

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    throw 'The operating system must be Windows 10 or later.'
}

$clientPackagesPath = @(
    "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~*.mum",
    "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~*.mum"
)

$clientPackages = Get-ChildItem -Path $clientPackagesPath -Force

if (-not $clientPackages) {
    throw 'Missing Group Policy client packages.'
}

$clientPackages | ForEach-Object { Add-WindowsPackage -PackagePath $_.FullName -Online -NoRestart }
