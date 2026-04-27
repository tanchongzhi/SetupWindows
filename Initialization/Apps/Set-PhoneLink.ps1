$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    Write-Host 'Mobile Devices : Show me suggestions for using my mobile device with Windows : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Mobility' -Name OptedIn -Value 0 -Type DWord
}
