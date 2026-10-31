$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -eq 10 -and $osVersion.Build -lt 22000) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate',
        'HKLM:\Software\Policies\Microsoft\WindowsStore',
        'HKCU:\Software\Policies\Microsoft\WindowsStore'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Windows Update Policy : Select the target Feature Update version : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name ProductVersion -Value 'Windows 10' -Type String
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name TargetReleaseVersionInfo -Value 22H2 -Type String
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name TargetReleaseVersion -Value 1 -Type DWord

    Write-Host 'Windows Store Policy : Turn off the offer to update to the latest version of Windows : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\WindowsStore' -Name DisableOSUpgrade -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\WindowsStore' -Name DisableOSUpgrade -Value 1 -Type DWord
}
