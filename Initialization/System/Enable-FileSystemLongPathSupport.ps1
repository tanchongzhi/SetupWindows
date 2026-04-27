$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    Write-Host 'FileSystem : Long Paths Support : Enabled'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\FileSystem' -Name LongPathsEnabled -Value 1 -Type DWord
}
