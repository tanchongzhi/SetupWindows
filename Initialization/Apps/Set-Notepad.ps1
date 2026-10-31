$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -lt 10 -or $osVersion.Build -lt 22000) {
    exit 0
}

if (-not ('WindowsNativeMethods.ApplicationHive' -as [type])) {
    Add-Type -Namespace WindowsNativeMethods -Name ApplicationHive -MemberDefinition @'
[DllImport("advapi32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern int RegLoadAppKey(string hiveFile, out IntPtr hKey, int samDesired, int options, int reserved);

[DllImport("advapi32.dll", SetLastError = true)]
public static extern int RegCloseKey(IntPtr hKey);
'@
}

function New-ApplicationHive {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    $key = [System.IntPtr]::Zero
    $result = [WindowsNativeMethods.ApplicationHive]::RegLoadAppKey($Path, [ref]$key, 0xF003F, 0, 0)

    if ($result -ne 0) {
        throw 'Failed to create application hive.'
    }

    [WindowsNativeMethods.ApplicationHive]::RegCloseKey($key) | Out-Null
}

$timestamp = (Get-Date).ToFileTime()
$timestampBytes = [System.BitConverter]::GetBytes($timestamp)
$timestampHex = [System.BitConverter]::ToString($timestampBytes).ToLower().Replace('-', ',')

$uuid = [guid]::NewGuid()
$notepadSettingsHiveLoadKeyName = "Hive_$uuid"
$notepadSettingsRegistry = @"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\$notepadSettingsHiveLoadKeyName\LocalState]
"RecentFilesFirstLoad"=hex(5f5e10b):00,$timestampHex
"RecentFilesEnabled"=hex(5f5e10b):00,$timestampHex
"RecentFiles"=hex(5f5e10c):5b,00,5d,00,00,00,$timestampHex
"GhostFile"=hex(5f5e10b):00,$timestampHex
"@
$notepadSettingsRegistryFile = "$env:TEMP\NotepadSettings.reg"

Set-Content -Path $notepadSettingsRegistryFile -Value $notepadSettingsRegistry -Force

$notepadDataDirectoryPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsNotepad_8wekyb3d8bbwe"
$notepadSettingsHivePath = "$notepadDataDirectoryPath\Settings\settings.dat"

if (-not (Test-Path -Path $notepadDataDirectoryPath)) {
    exit 0
}

Stop-Process -Name notepad -Force -ErrorAction SilentlyContinue
Wait-Process -Name notepad -Timeout 3 -ErrorAction SilentlyContinue

New-ApplicationHive -Path $notepadSettingsHivePath

reg load "HKLM\$notepadSettingsHiveLoadKeyName" $notepadSettingsHivePath >$null

if ($?) {
    $ErrorActionPreference = 'SilentlyContinue'
    reg import $notepadSettingsRegistryFile *>$null
    $ErrorActionPreference = 'Stop'

    reg unload "HKLM\$notepadSettingsHiveLoadKeyName" >$null

    Remove-Item -Path "$notepadDataDirectoryPath\LocalState\*" -Recurse -Force -ErrorAction SilentlyContinue
}
