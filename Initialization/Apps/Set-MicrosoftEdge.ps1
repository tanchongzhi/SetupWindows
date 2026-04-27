$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10) {
    exit 0
}

$policyKeys = @(
    'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\Main',
    'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main',
    'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\ServiceUI',
    'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\ServiceUI',
    'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader',
    'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader'
)
$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Microsoft Edge : Allow Microsoft Edge to pre-launch at Windows startup, when the system is idle, and each time Microsoft Edge is closed : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\Main' -Name AllowPrelaunch -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main' -Name AllowPrelaunch -Value 0 -Type DWord

Write-Host 'Microsoft Edge : Keep favorites in sync between Internet Explorer and Microsoft Edge : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\Main' -Name SyncFavoritesBetweenIEAndMicrosoftEdge -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main' -Name SyncFavoritesBetweenIEAndMicrosoftEdge -Value 0 -Type DWord

Write-Host 'Microsoft Edge : Prevent the First Run webpage from opening on Microsoft Edge : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\Main' -Name PreventFirstRunPage -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\Main' -Name PreventFirstRunPage -Value 1 -Type DWord

Write-Host 'Microsoft Edge : Allow web content on New Tab page : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\ServiceUI' -Name AllowWebContentOnNewTabPage -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\ServiceUI' -Name AllowWebContentOnNewTabPage -Value 0 -Type DWord

Write-Host 'Microsoft Edge : Allow Microsoft Edge to start and load the Start and New Tab page at Windows startup and each time Microsoft Edge is closed : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader' -Name AllowTabPreloading -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader' -Name AllowTabPreloading -Value 0 -Type DWord

#

$policyKeys = @(
    'HKLM:\Software\Policies\Microsoft\Edge',
    'HKCU:\Software\Policies\Microsoft\Edge'
)
$policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Microsoft Edge Policy : Show button on native PDF viewer in Microsoft Edge that allows users to sign up for Adobe Acrobat subscription : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name ShowAcrobatSubscriptionButton -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name ShowAcrobatSubscriptionButton -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Send required and optional diagnostic data about browser usage : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name DiagnosticData -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name DiagnosticData -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Send data to the Microsoft Edge service when a user tries to install a blocked extension : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeManagementExtensionsFeedbackEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeManagementExtensionsFeedbackEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Edge 3P SERP Telemetry : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name Edge3PSerpTelemetryEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name Edge3PSerpTelemetryEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Data sharing usage data for personalization for iOS and Android : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeDisableShareUsageData -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeDisableShareUsageData -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Shopping in Microsoft Edge : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeShoppingAssistantEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeShoppingAssistantEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Wallet Checkout feature : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeWalletCheckoutEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeWalletCheckoutEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Edge Wallet E-Tree : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeWalletEtreeEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeWalletEtreeEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Show content suggestions on the New Tab page : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NTPContentSuggestionsEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NTPContentSuggestionsEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Tab organization suggestions : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name TabServicesEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name TabServicesEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Allow feature recommendations and browser assistance notifications from Microsoft Edge : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name ShowRecommendationsEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name ShowRecommendationsEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Hide the First-run experience and splash screen : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name HideFirstRunExperience -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name HideFirstRunExperience -Value 1 -Type DWord

Write-Host 'Microsoft Edge Policy : Hide App Launcher on Microsoft Edge new tab page : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NewTabPageAppLauncherEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NewTabPageAppLauncherEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Hide the default top sites from the new tab page : Enabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NewTabPageHideDefaultTopSites -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NewTabPageHideDefaultTopSites -Value 1 -Type DWord

Write-Host 'Microsoft Edge Policy : Allow quick links on the new tab page : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NewTabPageQuickLinksEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NewTabPageQuickLinksEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Allow Microsoft content on the new tab page : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NewTabPageContentEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NewTabPageContentEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Allow user feedback : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name UserFeedbackAllowed -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name UserFeedbackAllowed -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Wallet Donation : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name WalletDonationEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name WalletDonationEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Set Microsoft Edge as default browser : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name DefaultBrowserSettingEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name DefaultBrowserSettingEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Default browser settings campaigns : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name DefaultBrowserSettingsCampaignEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name DefaultBrowserSettingsCampaignEnabled -Value 0 -Type DWord

Write-Host "Microsoft Edge Policy : Suggest similar pages when a webpage can't be found : Disabled"
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name AlternateErrorPagesEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name AlternateErrorPagesEnabled -Value 0 -Type DWord

Write-Host "Microsoft Edge Policy : Automatically import another browser's data and settings at first run : Disabled"
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name AutoImportAtFirstRun -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name AutoImportAtFirstRun -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Choose whether users can receive customized background images and text, suggestions, notifications, and tips for Microsoft services : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name SpotlightExperiencesAndRecommendationsEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name SpotlightExperiencesAndRecommendationsEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Show Microsoft 365 Copilot Chat in the Microsoft Edge for Business toolbar : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name Microsoft365CopilotChatIconEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name Microsoft365CopilotChatIconEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Allow sharing tenant-approved browsing history with Microsoft 365 Copilot Search : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name ShareBrowsingHistoryWithCopilotSearchAllowed -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name ShareBrowsingHistoryWithCopilotSearchAllowed -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Hide App Launcher on Microsoft Edge new tab page : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NewTabPageAppLauncherEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NewTabPageAppLauncherEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Show Hubs Sidebar : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name HubsSidebarEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name HubsSidebarEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : AI-enhanced search in History : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeHistoryAISearchEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeHistoryAISearchEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : DALL-E themes generation : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name AIGenThemesEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name AIGenThemesEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Bing chat entry-points on Microsoft Edge Enterprise new tab page : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name NewTabPageBingChatEnabled -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name NewTabPageBingChatEnabled -Value 0 -Type DWord

Write-Host 'Microsoft Edge Policy : Copilot in the Microsoft Edge sidepane can access Microsoft Edge page content : Disabled'
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name CopilotCDPPageContext -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name CopilotCDPPageContext -Value 0 -Type DWord
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name EdgeEntraCopilotPageContext -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name EdgeEntraCopilotPageContext -Value 0 -Type DWord
Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Edge' -Name CopilotPageContext -Value 0 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Edge' -Name CopilotPageContext -Value 0 -Type DWord
