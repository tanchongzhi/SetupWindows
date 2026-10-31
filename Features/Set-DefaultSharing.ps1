param(
    [Parameter(Mandatory = $true, ParameterSetName = 'Enable')]
    [switch]
    $Enable,

    [Parameter(Mandatory = $true, ParameterSetName = 'Disable')]
    [switch]
    $Disable
)

$ErrorActionPreference = 'Stop'

$currentPrincipal = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()

if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    throw 'You must be running as an administrator, please restart as administrator'
}

$isEnabled = if ($Enable) {
    1
} else {
    0
}

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\services\LanmanServer\Parameters\' -Name AutoShareServer -Value $isEnabled -Type DWord
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\services\LanmanServer\Parameters\' -Name AutoShareWks -Value $isEnabled -Type DWord

Stop-Service -Name LanmanServer
Start-Service -Name LanmanServer
