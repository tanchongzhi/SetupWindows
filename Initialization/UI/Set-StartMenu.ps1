$ErrorActionPreference = 'Stop'

$policyKeys = @(
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',
    'HKLM:\Software\Policies\Microsoft\Windows\Explorer',
    'HKCU:\Software\Policies\Microsoft\Windows\Explorer'
)

$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

$osVersion = [System.Environment]::OSVersion.Version

if (($osVersion.Major -eq 6 -and $osVersion.Minor -ge 2) -or ($osVersion.Major -ge 10)) {
    # Windows 8+
    Write-Host 'Start Menu Policy : Clear tile notifications during log on : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name ClearTilesOnExit -Value 1 -Type DWord
}

if ($osVersion.Major -eq 6 -and $osVersion.Minor -eq 1) {
    # Windows 7
    Write-Host 'Start Menu Policy : Do not allow pinning items in Jump Lists : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name NoPinningToDestinations -Value 1 -Type DWord
}

if ($osVersion.Major -ge 10) {
    Write-Host 'Start Menu Policy : Force Start to be menu size : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name ForceStartSize -Value 1 -Type DWord

    Write-Host 'Start Menu Policy : Remove "Recently added" list from Start Menu : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Explorer' -Name HideRecentlyAddedApps -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name HideRecentlyAddedApps -Value 1 -Type DWord

    Write-Host 'Start Menu : Show recently added apps : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name ShowRecentList -Value 0 -Type DWord

    Write-Host 'Start Menu : Show account-related notifications : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Start_AccountNotifications -Value 0 -Type DWord
}

if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
    Write-Host 'Start Menu Policy : Remove Recommended section from Start Menu : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Explorer' -Name HideRecommendedSection -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name HideRecommendedSection -Value 1 -Type DWord

    Write-Host 'Start Menu : Show more pins : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Start_Layout -Value 1 -Type DWord

    Write-Host 'Start Menu : Show all pins : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name ShowAllPinsList -Value 1 -Type DWord

    Write-Host 'Start Menu : Show all apps in list view : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name AllAppsViewMode -Value 2 -Type DWord
}
