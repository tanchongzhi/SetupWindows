$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -eq 10) {
    $settingKeys = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    )
    $settingKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host "Taskbar : Don't show People button on the taskbar : Enabled"
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name PeopleBand -Value 0 -Type DWord

    Write-Host 'Taskbar Policy : Remove the People Bar from the taskbar : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name HidePeopleBar -Value 1 -Type DWord

    Write-Host 'Removing People...'
    Get-AppxPackage 'Microsoft.People' -AllUsers | Remove-AppxPackage | Out-Null
    Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -ilike 'Microsoft.People' } | Remove-AppxProvisionedPackage -Online -AllUsers | Out-Null
}
