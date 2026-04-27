$ErrorActionPreference = 'Stop'

$policyKeys = @(
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
)
$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Start Menu Policy : Turn off user tracking : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name NoInstrumentation -Value 1 -Type DWord

Write-Host 'Start Menu Policy : Do not keep history of recently opened documents : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name NoRecentDocsHistory -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name NoRecentDocsHistory -Value 1 -Type DWord

Write-Host 'Start Menu Policy : Remove Recent Items menu from the Start Menu : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name NoRecentDocsMenu -Value 1 -Type DWord

Write-Host 'Start Menu Policy : Clear history of recently opened documents on exit : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name ClearRecentDocsOnExit -Value 1 -Type DWord

Write-Host 'Start Menu Policy : Clear the recent programs list for new users : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name ClearRecentProgForNewUserInStartMenu -Value 1 -Type DWord

Write-Host 'Start Menu Policy : Remove frequent programs list from the Start Menu : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name NoStartMenuMFUprogramsList -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name NoStartMenuMFUprogramsList -Value 1 -Type DWord

Write-Host 'Start Menu : Show recommended files in Start, recent files in File Explorer, and items in Jump Lists: Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Start_TrackDocs -Value 0 -Type DWord

Write-Host 'Start Menu : Let Windows improve Start and search results by tracking app launches : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Start_TrackProgs -Value 0 -Type DWord

#

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    $policyKeys = @(
        'HKCU:\Software\Policies\Microsoft\Windows\Explorer',
        'HKLM:\Software\Policies\Microsoft\Windows\Explorer'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Start Menu Policy : Hide "Most used" list from Start Menu : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Explorer' -Name ShowOrHideMostUsedApps -Value 2 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name ShowOrHideMostUsedApps -Value 2 -Type DWord
}

if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
    Write-Host 'Start Menu : Show most used apps : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name ShowFrequentList -Value 0 -Type DWord
}

#

if ($osVersion.Major -ge 10) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Windows\CloudContent',
        'HKCU:\Software\Policies\Microsoft\Windows\CloudContent'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Cloud Content Policy : Do not show Windows Tips : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableSoftLanding -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off cloud optimized content : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableCloudOptimizedContent -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off Microsoft consumer experiences : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableWindowsConsumerFeatures -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off cloud consumer account state content : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableConsumerAccountStateContent -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Configure Windows spotlight on lock screen : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name ConfigureWindowsSpotlight -Value 2 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name IncludeEnterpriseSpotlight -Value 0 -Type DWord

    Write-Host 'Cloud Content Policy : Do not use diagnostic data for tailored experiences : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableTailoredExperiencesWithDiagnosticData -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Do not suggest third-party content in Windows spotlight : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableThirdPartySuggestions -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off all Windows spotlight features : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableWindowsSpotlightFeatures -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off Spotlight collection on Desktop : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableSpotlightCollectionOnDesktop -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off the Windows Welcome Experience : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableWindowsSpotlightWindowsWelcomeExperience -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off Windows Spotlight on Action Center : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableWindowsSpotlightOnActionCenter -Value 1 -Type DWord

    Write-Host 'Cloud Content Policy : Turn off Windows Spotlight on Settings : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableWindowsSpotlightOnSettings -Value 1 -Type DWord

    Write-Host 'Cloud Content : Do not show Windows Tips : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name SoftLandingEnabled -Value 0 -Type DWord

    Write-Host 'Cloud Content : Get fun facts, tips, and more from Windows and Cortana on your lock screen : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name SubscribedContent-338387Enabled -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name RotatingLockScreenOverlayEnabled -Value 0 -Type DWord

    Write-Host 'Windows Store : Automatic Installation of Suggested Apps : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name SilentInstalledAppsEnabled -Value 0 -Type DWord

    Write-Host 'System : Multitasking : Show suggestions in Timeline : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353698Enabled' -Value 0 -Type DWord

    Write-Host 'Start Menu : Show suggestions occasionally in Start : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338388Enabled' -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name SystemPaneSuggestionsEnabled -Value 0 -Type DWord
}

if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
    Write-Host 'Start Menu : Show recommendations for tips, shortcuts, new apps and more : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Start_IrisRecommendations -Value 0 -Type DWord
}

#

$policyKeys = @(
    'HKCU:\Software\Policies\Microsoft\Assistance\Client\1.0',
    'HKLM:\Software\Policies\Microsoft\SQMClient\Windows'
)
$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Privacy Policy : Turn off Help Experience Improvement Program : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Assistance\Client\1.0' -Name NoExplicitFeedback -Value 1 -Type DWord

Write-Host 'Privacy Policy : Turn off Windows Customer Experience Improvement Program : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\SQMClient\Windows' -Name CEIPEnable -Value 0 -Type DWord

Write-Host 'Privacy : Turn off Windows Customer Experience Improvement Program : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\SQMClient\Windows' -Name CEIPEnable -Value 0 -Type DWord

Write-Host 'Privacy : Scheduled Tasks : \Microsoft\Windows\Maintenance\WinSAT : Disabled'
$null = schtasks /Change /Disable /TN '\Microsoft\Windows\Maintenance\WinSAT'

#

if ($osVersion.Major -ge 10) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\AppV\CEIP',
        'HKLM:\Software\Policies\Microsoft\InputPersonalization',
        'HKLM:\Software\Policies\Microsoft\Windows\DataCollection',
        'HKCU:\Software\Policies\Microsoft\Windows\DataCollection',
        'HKCU:\Software\Policies\Microsoft\Windows\CloudContent',
        'HKLM:\Software\Policies\Microsoft\Windows\System',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Privacy Policy : App-V : Microsoft Customer Experience Improvement Program (CEIP) : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\AppV\CEIP' -Name CEIPEnable -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Online Speech Recognition : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\InputPersonalization' -Name AllowInputPersonalization -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Diagnostic & feedback : Send only required diagnostic data to Microsoft : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection' -Name AllowTelemetry -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\DataCollection' -Name AllowTelemetry -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Diagnostic & feedback : View diagnostic data : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection' -Name DisableDiagnosticDataViewer -Value 1 -Type DWord

    Write-Host 'Privacy Policy : Diagnostic & feedback : Improve inking and typing recognition : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput' -Name AllowLinguisticDataCollection -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Diagnostic & feedback : Tailored experiences with diagnostic data : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' -Name DisableTailoredExperiencesWithDiagnosticData -Value 1 -Type DWord

    Write-Host 'Privacy Policy : Allow publishing of User Activities : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name PublishUserActivities -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Allow upload of User Activities : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name UploadUserActivities -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Allow Clipboard synchronization across devices : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name AllowCrossDeviceClipboard -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Allow Clipboard History : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name AllowClipboardHistory -Value 0 -Type DWord

    Write-Host 'Privacy Policy : Block user from showing account details on sign-in : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name BlockUserFromShowingAccountDetailsOnSignin -Value 1 -Type DWord

    Write-Host 'Privacy Policy : Sign-in and lock last interactive user automatically after a restart : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name DisableAutomaticRestartSignOn -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name AutomaticRestartSignOnConfig -Value 1 -Type DWord

    #

    $settingKeys = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo',
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager',
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey',
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy',
        'HKCU:\Software\Microsoft\Internet Explorer\International',
        'HKCU:\Software\Microsoft\Input\TIPC',
        'HKCU:\Software\Microsoft\InputPersonalization',
        'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore',
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language',
        'HKCU:\Software\Microsoft\Personalization\Settings',
        'HKCU:\Software\Microsoft\Siuf\Rules',
        'HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy'
    )
    $settingKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Privacy : Let apps show me personalized ads by using my advertising ID : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name Enabled -Value 0 -Type DWord
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name Id -ErrorAction SilentlyContinue

    Write-Host 'Privacy : Let websites show me locally relevant content by accessing my language list : Disabled'
    Set-ItemProperty -Path 'HKCU:\Control Panel\International\User Profile' -Name HttpAcceptLanguageOptOut -Value 1 -Type DWord
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\International' -Name AcceptLanguage -ErrorAction SilentlyContinue

    Write-Host 'Privacy : Let Windows improve Start and search results by tracking app launches : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Start_TrackProgs -Value 0 -Type DWord

    Write-Host 'Privacy : Show me suggested content in the Settings app : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338393Enabled' -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353694Enabled' -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353696Enabled' -Value 0 -Type DWord

    Write-Host 'Privacy : Online Speech Recognition : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy' -Name HasAccepted -Value 0 -Type DWord

    Write-Host 'Privacy : Inking & Typing Personalization : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization' -Name RestrictImplicitInkCollection -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization' -Name RestrictImplicitTextCollection -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' -Name HarvestContacts -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language' -Name Enabled -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Personalization\Settings' -Name AcceptedPrivacyPolicy -Value 0 -Type DWord

    Write-Host 'Privacy : Diagnostic & feedback : Send optional diagnostic data : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack' -Name ShowedToastAtLevel -Value 1 -Type DWord

    Write-Host 'Privacy : Diagnostic & feedback : View diagnostic data : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey' -Name EnableEventTranscript -Value 0 -Type DWord

    Write-Host 'Privacy : Diagnostic & feedback : Improve inking and typing : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Input\TIPC' -Name Enabled -Value 0 -Type DWord

    Write-Host 'Privacy : Diagnostic & feedback : Tailored experiences : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy' -Name TailoredExperiencesWithDiagnosticDataEnabled -Value 0 -Type DWord

    Write-Host 'Privacy : Diagnostic & feedback : Feedback Frequency : Never'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Siuf\Rules' -Name NumberOfSIUFInPeriod -Value 0 -Type DWord
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Siuf\Rules' -Name PeriodInNanoSeconds -ErrorAction SilentlyContinue

    Write-Host 'Privacy : Scheduled Tasks : \Microsoft\Windows\Feedback\Siuf\* : Disabled'
    $null = Get-ScheduledTask -TaskPath '\Microsoft\Windows\Feedback\Siuf\' | Disable-ScheduledTask

    Write-Host 'Privacy : Scheduled Tasks : \Microsoft\Windows\Customer Experience Improvement Program\* : Disabled'
    $null = Get-ScheduledTask -TaskPath '\Microsoft\Windows\Customer Experience Improvement Program\' | Disable-ScheduledTask
}

if ($osVersion.Major -ge 10 -and $osVersion.Build -lt 22000) {
    Write-Host 'Privacy : Service : Microsoft (R) DiagnosticsHub Standard Collector Service : Disabled'
    Set-Service -Name 'diagnosticshub.standardcollector.service' -StartupType Disabled -Status Stopped
}

if ($osVersion.Major -ge 10) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Windows\LocationAndSensor',
        'HKCU:\Software\Policies\Microsoft\Windows\LocationAndSensor',
        'HKLM:\Software\Policies\Microsoft\FindMyDevice'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Location Policy : Turn off location : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\LocationAndSensor' -Name DisableLocation -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\LocationAndSensor' -Name DisableLocation -Value 1 -Type DWord

    Write-Host 'Find My Device Policy : Turn off Find My Device : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\FindMyDevice' -Name AllowFindMyDevice -Value 0 -Type DWord
}

if ($osVersion.Major -ge 10) {
    $settingKeys = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement'
    )
    $settingKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host "System : Notifications : Show the Windows welcome experience after updates and when signed in to show what's new and suggested: Disabled"
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-310093Enabled' -Value 0 -Type DWord

    Write-Host 'System : Notifications : Suggest ways to get the most out of Windows and finish setting up this device: Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement' -Name ScoobeSystemSettingEnabled -Value 0 -Type DWord

    Write-Host 'System : Notifications : Get tips and suggestions when using Windows: Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338389Enabled' -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name SoftLandingEnabled -Value 0 -Type DWord
}

#

$scheduledTasks = schtasks /Query /FO LIST

Write-Host 'Privacy : Scheduled Tasks : \Microsoft\Windows\Customer Experience Improvement Program\* : Disabled'
$null = $scheduledTasks |
    Select-String -Pattern '\Microsoft\Windows\Customer Experience Improvement Program\' -SimpleMatch |
    ForEach-Object { schtasks /Change /Disable /TN "$($_.Line.Split(':', 2)[1].Trim())" }

Write-Host 'Privacy : Scheduled Tasks : \Microsoft\Windows\Application Experience\* : Disabled'
$null = $scheduledTasks |
    Select-String -Pattern '\Microsoft\Windows\Application Experience\' -SimpleMatch |
    ForEach-Object { schtasks /Change /Disable /TN "$($_.Line.Split(':', 2)[1].Trim())" }

Write-Host 'Privacy : Scheduled Tasks : \Microsoft\Windows\DiskDiagnostic\* : Disabled'
$null = $scheduledTasks |
    Select-String -Pattern '\Microsoft\Windows\DiskDiagnostic\' -SimpleMatch |
    ForEach-Object { schtasks /Change /Disable /TN "$($_.Line.Split(':', 2)[1].Trim())" }

Write-Host 'Privacy : Service : Diagnostics Tracking Service (or "Connected User Experiences and Telemetry") : Disabled'
Stop-Service -Name DiagTrack -Force -ErrorAction SilentlyContinue
Set-Service -Name DiagTrack -Status Stopped -StartupType Disabled -ErrorAction SilentlyContinue
