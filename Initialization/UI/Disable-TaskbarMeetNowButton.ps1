$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10 -and $osVersion.Build -lt 22000) {
    $policyKeys = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Taskbar : Remove the Meet Now icon : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name HideSCAMeetNow -Value 0 -Type DWord
}
