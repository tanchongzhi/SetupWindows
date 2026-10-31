$ErrorActionPreference = 'SilentlyContinue'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10) {
    exit 0
}

$preinstalledPackages = @(
    @{ Title = 'Get Help'; PackageFamilyName = 'Microsoft.GetHelp' },
    @{ Title = 'Get started'; PackageFamilyName = 'Microsoft.Getstarted' },
    @{ Title = 'Feedback Hub'; PackageFamilyName = 'Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe' },
    @{ Title = '3D Viewer'; PackageFamilyName = 'Microsoft.Microsoft3DViewer' },
    @{ Title = 'Paint 3D'; PackageFamilyName = 'Microsoft.MSPaint' },
    @{ Title = 'Mixed Reality Portal'; PackageFamilyName = 'Microsoft.MixedReality.Portal' },
    @{ Title = 'Sticky Notes'; PackageFamilyName = 'Microsoft.MicrosoftStickyNotes' },
    @{ Title = 'Windows Maps'; PackageFamilyName = 'Microsoft.WindowsMaps' },
    @{ Title = 'Cortana'; PackageFamilyName = 'Microsoft.549981C3F5F10' },
    @{ Title = 'People'; PackageFamilyName = 'Microsoft.People' },
    @{ Title = 'Windows Communications Apps (People, Mail, and Calendar)'; PackageFamilyName = 'microsoft.windowscommunicationsapps' },
    @{ Title = 'Wallet'; PackageFamilyName = 'Microsoft.Wallet' },
    @{ Title = 'Groove Music'; PackageFamilyName = 'Microsoft.ZuneMusic' },
    @{ Title = 'Films & TV'; PackageFamilyName = 'Microsoft.ZuneVideo' },
    @{ Title = 'Solitaire Collection'; PackageFamilyName = 'Microsoft.MicrosoftSolitaireCollection' },
    @{ Title = 'Skype'; PackageFamilyName = 'Microsoft.SkypeApp' },
    @{ Title = 'News'; PackageFamilyName = 'Microsoft.BingNews_8wekyb3d8bbwe' },
    @{ Title = 'Microsoft Bing'; PackageFamilyName = 'Microsoft.BingSearch_8wekyb3d8bbwe' },
    @{ Title = 'Microsoft ToDo'; PackageFamilyName = 'Microsoft.Todos_8wekyb3d8bbwe' },
    @{ Title = 'Microsoft Clipchamp'; PackageFamilyName = 'Clipchamp.Clipchamp_yxz26nhyzhsrt' },
    @{ Title = 'Microsoft PC Manager'; PackageFamilyName = 'Microsoft.MicrosoftPCManager' },
    @{ Title = 'Microsoft 365 Copilot'; PackageFamilyName = 'Microsoft.Copilot' },
    @{ Title = 'Office Hub'; PackageFamilyName = 'Microsoft.MicrosoftOfficeHub' },
    @{ Title = 'OneNote'; PackageFamilyName = 'Microsoft.Office.OneNote' }
)

$preinstalledPackages | ForEach-Object {
    Write-Host "Removing $($_.Title)..."
    Get-AppxPackage $_.PackageFamilyName -AllUsers | Remove-AppxPackage | Out-Null
    Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -ilike $_.PackageFamilyName } | Remove-AppxProvisionedPackage -Online -AllUsers | Out-Null
}
