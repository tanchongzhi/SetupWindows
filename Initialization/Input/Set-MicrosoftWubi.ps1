$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10) {
    exit 0
}

if (-not ((Test-Path -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS') -and (Test-Path -Path 'HKCU:\Software\Microsoft\CTF\TIP\{6A498709-E00B-4C45-A018-8F9E4081AE40}'))) {
    exit 0
}

$settingKeys = @(
    'HKCU:\Software\Microsoft\Input\TSF\Tsf3Override\{6a498709-e00b-4c45-a018-8f9e4081ae40}'
)
$settingKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

#

Write-Host 'Microsoft Wubi : Default mode : English'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'Default Mode' -Value 1 -Type DWord

Write-Host 'Microsoft Wubi : Compatibility mode : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\CTF\TIP\{6A498709-E00B-4C45-A018-8F9E4081AE40}' -Name DummyValue -Value 1 -Type DWord
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Input\TSF\Tsf3Override\{6a498709-e00b-4c45-a018-8f9e4081ae40}' -Name NoTsf3Override2 -Value 1 -Type DWord
