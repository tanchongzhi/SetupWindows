$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Power Policy : Allow network connectivity during connected-standby (plugged in) : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9' -Name ACSettingIndex -Value 0 -Type DWord

    Write-Host 'Power Policy : Allow network connectivity during connected-standby (on battery) : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9' -Name DCSettingIndex -Value 0 -Type DWord
}
