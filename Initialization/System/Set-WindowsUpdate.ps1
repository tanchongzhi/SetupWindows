$ErrorActionPreference = 'Stop'

$policyKeys = @(
    'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate',
    'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU',
    'HKCU:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU'
)
$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Windows Update Policy : No auto-restart with logged on users for scheduled automatic updates installations : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name NoAutoRebootWithLoggedOnUsers -Value 1 -Type DWord

Write-Host 'Windows Update Policy : Notify before downloading and installing any updates : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name NoAutoUpdate -Value 0 -Type DWord
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name AUOptions -Value 2 -Type DWord
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name ScheduledInstallDay -Value 1 -Type DWord
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name ScheduledInstallTime -Value 12 -Type DWord

Write-Host 'Windows Update Policy : Turn on recommended updates via Automatic Updates : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name IncludeRecommendedUpdates -Value 0 -Type DWord

#

$osVersion = [System.Environment]::OSVersion.Version

if (($osVersion.Major -eq 6) -and ($osVersion.Minor -le 1)) {
    Write-Host 'Windows Update Policy : Do not adjust default option to "Install Updates and Shut Down" in Shut Down Windows dialog box : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name NoAUAsDefaultShutdownOption -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name NoAUAsDefaultShutdownOption -Value 1 -Type DWord
}

if ($osVersion.Major -eq 6) {
    Write-Host 'Windows Update : Turn on recommended updates via Automatic Updates : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' -Name IncludeRecommendedUpdates -Value 0 -Type DWord

    Write-Host 'Windows Update : Notify before downloading and installing any updates : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' -Name NoAutoUpdate -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' -Name AUOptions -Value 2 -Type DWord
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' -Name ScheduledInstallDay -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' -Name ScheduledInstallTime -Value 12 -Type DWord
}

if ($osVersion.Major -ge 10) {
    Write-Host 'Windows Update Policy : Do not include drivers with Windows Updates : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name ExcludeWUDriversInQualityUpdate -Value 1 -Type DWord

    Write-Host 'Windows Update : Do not include drivers with Windows Updates : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name ExcludeWUDriversInQualityUpdate -Value 1 -Type DWord

    Write-Host 'Windows Update : Receive updates for other Microsoft products when you update Windows : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name AllowMUUpdateService -Value 1 -Type DWord

    Write-Host 'Windows Update : Download updates over metered connections (extra charges may apply) : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name AllowAutoWindowsUpdateDownloadOverMeteredNetwork -Value 0 -Type DWord

    Write-Host 'Windows Update : Restart this device as soon as possilble when a restart is required to install an update, Windows will display a notice before the restart, and the device must be on and plugged in : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name IsExpedited -Value 0 -Type DWord

    Write-Host 'Windows Update : Show a notifcation when your PC requires a restart to finish updating : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name RestartNotificationsAllowed2 -Value 0 -Type DWord

    Write-Host 'Windows Update : Allow pause updates up to 90 days'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name FlightSettingsMaxPauseDays -Value 30 -Type DWord

    Write-Host 'Windows Update : Pause updates for 90 days'
    $date = (Get-Date).ToUniversalTime()
    $date.AddMinutes(-$date.Minute) | Out-Null
    $date.AddSeconds(-$date.Second) | Out-Null
    $pauseUpdatesStartTime = $date.ToString('o', [cultureinfo]::InvariantCulture)
    $date.AddDays(90) | Out-Null
    $pauseUpdatesEndTime = $date.ToString('o', [cultureinfo]::InvariantCulture)
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name PauseUpdatesExpiryTime -Value $pauseUpdatesEndTime -Type String
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name PauseQualityUpdatesStartTime -Value $pauseUpdatesStartTime -Type String
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name PauseQualityUpdatesEndTime -Value $pauseUpdatesEndTime -Type String
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name PauseFeatureUpdatesStartTime -Value $pauseUpdatesStartTime -Type String
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name PauseFeatureUpdatesEndTime -Value $pauseUpdatesEndTime -Type String

    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name ActiveHoursStart -Value 8 -Type DWord
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name ActiveHoursEnd -Value 17 -Type DWord

    #

    Write-Host "Windows Update : Get the latest updates as soon as they're available : Disabled"
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings' -Name IsContinuousInnovationOptedIn -Value 0 -Type DWord
}
