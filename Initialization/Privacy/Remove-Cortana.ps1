$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Windows\Windows Search'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Windows Search Policy : Allow Cortana : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name AllowCortana -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name AllowCortanaAboveLock -Value 0 -Type DWord

    Write-Host 'Windows Search Policy : Allow Cortana to use location : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name AllowSearchToUseLocation -Value 0 -Type DWord

    Write-Host 'Windows Search : Allow Cortana : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name CortanaEnabled -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name CortanaConsent -Value 0 -Type DWord

    Write-Host 'Windows Search : Allow Cortana to use location : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name AllowSearchToUseLocation -Value 0 -Type DWord

    Write-Host "Taskbar : Don't show Cortana button on the taskbar : Enabled"
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowCortanaButton -Value 0 -Type DWord

    Write-Host 'Removing Cortana...'
    Get-AppxPackage 'Microsoft.549981C3F5F10' -AllUsers | Remove-AppxPackage | Out-Null
    Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -ilike 'Microsoft.549981C3F5F10' } | Remove-AppxProvisionedPackage -Online -AllUsers | Out-Null
}
