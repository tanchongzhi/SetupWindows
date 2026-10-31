$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
    Write-Host "Taskbar : Don't show Chat button on the taskbar : Enabled"
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarMn -Value 0 -Type DWord
}
