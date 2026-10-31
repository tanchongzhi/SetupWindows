$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10) {
    exit 0
}

if (-not ((Test-Path -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS') -and (Test-Path -Path 'HKCU:\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}'))) {
    exit 0
}

$settingKeys = @(
    'HKCU:\Software\Microsoft\Input\TSF\Tsf3Override\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}'
)
$settingKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Microsoft Pinyin : Default mode : English'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'Default Mode' -Value 1 -Type DWord

Write-Host 'Microsoft Pinyin : Cloud Candidate : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'Enable Cloud Candidate' -Value 0 -Type DWord

Write-Host 'Microsoft Pinyin : Live Sticker : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name EnableLiveSticker -Value 0 -Type DWord

Write-Host 'Microsoft Pinyin : Show Hot and Popular Word Search Hint : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'Enable Hot And Popular Word Search' -Value 0 -Type DWord

Write-Host 'Microsoft Pinyin : Show Hot and Popular Word in Candidate Window : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name EnableHap -Value 0 -Type DWord

Write-Host 'Microsoft Pinyin : Compatibility mode : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}' -Name DummyValue -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Input\TSF\Tsf3Override\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}' -Name NoTsf3Override2 -Value 1 -Type DWord
