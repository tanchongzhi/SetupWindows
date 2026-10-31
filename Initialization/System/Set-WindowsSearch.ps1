$ErrorActionPreference = 'Stop'

$policyKeys = @(
    'HKLM:\Software\Policies\Microsoft\Windows\Windows Search',
    'HKCU:\Software\Policies\Microsoft\Windows\Explorer'
)
$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Windows Search Policy : Allow indexing of encrypted files : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name AllowIndexingEncryptedStoresOrItems -Value 0 -Type DWord

Write-Host 'Windows Search Policy : Allow search highlights : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name EnableDynamicContentInWSB -Value 0 -Type DWord

Write-Host 'Windows Search Policy : Do not allow web search : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name DisableWebSearch -Value 1 -Type DWord

Write-Host 'Windows Search Policy : Prevent indexing Microsoft Office Outlook : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name PreventIndexingOutlook -Value 1 -Type DWord

Write-Host 'Windows Search Policy : Prevent indexing e-mail attachments : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name PreventIndexingEmailAttachments -Value 1 -Type DWord

Write-Host 'Windows Search Policy : Turn off display of recent search entries in the Windows Explorer search box : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name DisableSearchBoxSuggestions -Value 1 -Type DWord

#

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    Write-Host 'Windows Search Policy : Allow cloud search : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name AllowCloudSearch -Value 0 -Type DWord

    Write-Host "Windows Search Policy : Don't search the web or display web results in Search : Enabled"
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name ConnectedSearchUseWeb -Value 0 -Type DWord

    Write-Host "Windows Search Policy : Don't search the web or display web results in Search over metered connections : Enabled"
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name ConnectedSearchUseWebOverMeteredConnections -Value 1 -Type DWord

    Write-Host 'Windows Search Policy : Do not allow locations on removable drives to be added to libraries : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name DisableRemovableDriveIndexing -Value 1 -Type DWord

    Write-Host 'Windows Search Policy : Turn off storage and display of search history : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' -Name DisableSearchHistory -Value 1 -Type DWord

    Write-Host 'Windows Search Policy : Allow search to use location : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name AllowSearchToUseLocation -Value 0 -Type DWord
}

# if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
#     Write-Host 'Windows Search Policy : Hide search on taskbar : Enabled'
#     Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search' -Name SearchOnTaskbarMode -Value 0 -Type DWord
# }

if ($osVersion.Major -ge 10) {
    Write-Host 'Windows Search : Hide search on taskbar : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name SearchboxTaskbarMode -Value 0 -Type DWord

    if ($osVersion.Build -lt 22000) {
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name TraySearchBoxVisible -Value 0 -Type DWord
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name TraySearchBoxVisibleOnAnyMonitor -Value 0 -Type DWord
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name OnboardSearchboxOnTaskbar -Value 0 -Type DWord
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name OnboardSBEmode -Value 1 -Type DWord
    }
}

if ($osVersion.Major -ge 10) {
    $settingKeys = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds\DSB'
    )
    $settingKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Windows Search : Bing Search : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name BingSearchEnabled -Value 0 -Type DWord

    Write-Host 'Windows Search : Safe Search : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name SafeSearchMode -Value 0 -Type DWord

    Write-Host 'Windows Search : Search my accounts : Microsoft account : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name IsMSACloudSearchEnabled -Value 0 -Type DWord

    Write-Host 'Windows Search : Search my accounts : Work or School account : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name IsAADCloudSearchEnabled -Value 0 -Type DWord

    Write-Host 'Windows Search : Search history : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name IsDeviceSearchHistoryEnabled -Value 0 -Type DWord

    Write-Host 'Windows Search : Show search highlights : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds\DSB' -Name ShowDynamicContent -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings' -Name IsDynamicSearchBoxEnabled -Value 0 -Type DWord

    Write-Host 'Windows Search : Show recent searches when hovering on the search icon in taskbar : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds\DSB' -Name OpenOnHover -Value 0 -Type DWord

    Write-Host 'Windows Search : Allow search to use location : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name AllowSearchToUseLocation -Value 0 -Type DWord
}
