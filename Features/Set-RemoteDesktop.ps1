param (
    [Parameter(Mandatory = $true, ParameterSetName = 'Enable')]
    [switch]
    $Enable,

    [Parameter(Mandatory = $true, ParameterSetName = 'Disable')]
    [switch]
    $Disable
)

$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -eq 6 -and $osVersion.Minor -le 1) {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name SecurityLayer -Value 1 -Type DWord
} else {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name SecurityLayer -Value 2 -Type DWord
}

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name UserAuthentication -Value 1 -Type DWord

#

if ($Enable) {
    Write-Host 'Remote Desktop : Remote Desktop Services : Enabled'
    Set-Service -Name TermService -StartupType Automatic -ErrorAction SilentlyContinue
    Start-Service -Name TermService -ErrorAction SilentlyContinue

    exit 0
}

if ($Disable) {
    Write-Host 'Remote Desktop : Allow connections to this computer : Disabled'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 1 -Type DWord

    Write-Host 'Remote Desktop : Remote Desktop Services : Disabled'
    Stop-Service -Name TermService -Force -ErrorAction SilentlyContinue
    Set-Service -Name TermService -StartupType Disabled -ErrorAction SilentlyContinue

    exit 0
}
