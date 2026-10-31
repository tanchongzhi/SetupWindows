$ErrorActionPreference = 'Stop'

Write-Host 'Remote Desktop : Allow connections to this computer : Disabled'
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 1 -Type DWord

#

$osVersion = [System.Environment]::OSVersion.Version

$securityLayer = if ($osVersion.Major -eq 6 -and $osVersion.Minor -le 1) {
    1
} else {
    2
}

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name SecurityLayer -Value $securityLayer -Type DWord
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name UserAuthentication -Value 1 -Type DWord

#

Write-Host 'Remote Desktop : Remote Desktop Services : Disabled'
Stop-Service -Name TermService -Force -ErrorAction SilentlyContinue
Set-Service -Name TermService -StartupType Disabled -ErrorAction SilentlyContinue
