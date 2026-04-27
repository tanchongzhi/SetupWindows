$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10) {
    exit 0
}

if ($osVersion.Build -lt 22000) {
    $policyKeys = @(
        'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Windows AI Policy : Turn off Windows Copilot : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot' -Name TurnOffWindowsCopilot -Value 1 -Type DWord
}

if ($osVersion.Build -ge 22000) {
    $policyKeys = @(
        'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot',
        'HKLM:\Software\Policies\Microsoft\Windows\WindowsAI',
        'HKCU:\Software\Policies\Microsoft\Windows\WindowsAI',
        'HKLM:\Software\Policies\WindowsNotepad',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Paint'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Windows AI Policy : Turn off Windows Copilot : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot' -Name DisableAIDataAnalysis -Value 1 -Type DWord

    Write-Host 'Windows AI Policy : Allow Recall to be enabled : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsAI' -Name AllowRecallEnablement -Value 0 -Type DWord

    Write-Host 'Windows AI Policy : Turn off saving snapshots for use with Recall : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsAI' -Name DisableAIDataAnalysis -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\WindowsAI' -Name DisableAIDataAnalysis -Value 1 -Type DWord

    Write-Host 'Windows AI Policy : Disable Click to Do : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsAI' -Name DisableClickToDo -Value 1 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\WindowsAI' -Name DisableClickToDo -Value 1 -Type DWord

    Write-Host 'Windows AI : Show Windows Copilot button on the taskbar : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowCopilotButton -Value 0 -Type DWord

    Write-Host 'Windows AI : Service : WSAIFabricSvc : Disabled'
    Set-Service -Name WSAIFabricSvc -StartupType Disabled -ErrorAction SilentlyContinue

    Write-Host 'Notepad Policy : Disable AI features : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\WindowsNotepad' -Name DisableAIFeatures -Value 1 -Type DWord

    Write-Host 'Paint Policy : Disable Image Creator : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Paint' -Name DisableImageCreator -Value 1 -Type DWord

    Write-Host 'Paint Policy : Disable Cocreator : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Paint' -Name DisableCocreator -Value 1 -Type DWord

    Write-Host 'Paint Policy : Disable Generative Fill : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Paint' -Name DisableGenerativeFill -Value 1 -Type DWord
}
