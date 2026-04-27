$ErrorActionPreference = 'Stop'

Write-Host 'Taskbar : Lock the taskbar : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarSizeMove -Value 0 -Type DWord

Write-Host 'Taskbar : Automatically hide the taskbar in tablet mode : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAutoHideInTabletMode -Value 0 -Type DWord

Write-Host 'Taskbar : Use small icons in taskbar : Disabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarSmallIcons -Value 0 -Type DWord

Write-Host 'Taskbar : Combine taskbar buttons when taskbar is full'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarGlomLevel -Value 1 -Type DWord

Write-Host 'Taskbar : Use Peek to preview the desktop when you move your mouse to the Show desktop button at the end of the taskbar : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name DisablePreviewDesktop -Value 1 -Type DWord

Write-Host 'Taskbar : Show the taskbar on multiple displays : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MMTaskbarEnabled -Value 1 -Type DWord

Write-Host 'Taskbar : Show taskbar buttons on main taskbar and taskbar where window is open on multiple displays : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MMTaskbarMode -Value 1 -Type DWord

Write-Host 'Taskbar : Combine taskbar buttons when taskbar is full on multiple displays'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MMTaskbarGlomLevel -Value 1 -Type DWord

Write-Host 'Taskbar : Always show tray icons on the taskbar : Enabled'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name EnableAutoTray -Value 0 -Type DWord

#

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    Write-Host 'Taskbar : Replace Command Prompt with Windows PowerShell in the menu when I right click the start button or press Windows key+X : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name DontUsePowerShellOnWinX -Value 0 -Type DWord

    Write-Host 'Taskbar : Show badges on taskbar buttons : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarBadges -Value 1 -Type DWord

    Write-Host 'Taskbar : Show the Task View button on the taskbar : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowTaskViewButton -Value 1 -Type DWord
}

if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
    Write-Host 'Taskbar : Alignment : Left'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAl -Value 0 -Type DWord

    Write-Host 'Taskbar : Show the desktop by clicking the far corner of the taskbar : Enabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarSd -Value 1 -Type DWord
}

# StuckRects<N> Data:
#   offset 0x00, 4 bytes: Size (Windows 7/8: 40; Windows 10/11: 48)
#   offset 0x04, 4 bytes: Signature (Windows 7/8: -1 (0xffffffff); Windows 10: -2 (0xfffffffe))
#   offset 0x08, 4 bytes: Flags: TopMost ; Available: AutoHide (0x0001), TopMost (0x0002), HideClock (0x0008)
#   offset 0x0c, 4 bytes: StuckPlace: Bottom ; Available: Left (0), Top (1), Right (2), Bottom (3)
#   offset 0x10, 4 bytes: StuckWidths: cx
#   offset 0x14, 4 bytes: StuckWidths: cy
#   offset 0x18, 4 bytes: LastStuck: left
#   offset 0x1c, 4 bytes: LastStuck: top
#   offset 0x20, 4 bytes: LastStuck: right
#   offset 0x24, 4 bytes: LastStuck: bottom
#   offset 0x28, 4 bytes: Unknown, Windows 10+
#   offset 0x2c, 4 bytes: Unknown, Windows 10+
#
# Note: Modifying the Flags and position while retaining the original size data and rectangle data does not affect the actual behavior of the settings.
# Note: All explorer processes should be terminated before writing new settings, otherwise the old settings stored in explorer's memory will overwrite the new settings upon logout.
# Note: The taskbar position is locked to the bottom of the screen in Windows 11 and cannot be changed through the GUI.

$stuckRectsSettings = if ($osVersion.Major -eq 6) {
    (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects2' -Name Settings).Settings
} else {
    (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3' -Name Settings).Settings
}

Write-Host 'Taskbar : Automatically hide the taskbar in desktop mode : Disabled'
$stuckRectsSettings[0x08] = $stuckRectsSettings[0x08] -band -bnot 0x0001

Write-Host 'Taskbar : Taskbar location on screen : Bottom'
$stuckRectsSettings[0x0c] = 3

if ($osVersion.Major -eq 6) {
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects2\' -Name Settings -Value $stuckRectsSettings -Type Binary
} else {
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3\' -Name Settings -Value $stuckRectsSettings -Type Binary
}

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
    Start-Process explorer.exe
}

#

if (-not ('WindowsNativeMethods.MessageTimeout' -as [type])) {
    Add-Type -Namespace WindowsNativeMethods -Name MessageTimeout -MemberDefinition @'
[DllImport("user32.dll", CharSet = CharSet.Unicode)]
public static extern IntPtr SendMessageTimeoutW(IntPtr hWnd, uint Msg, IntPtr wParam, string lParam, uint fuFlags, uint uTimeout, IntPtr lpdwResult);
'@
}

function Send-SystemSettingChangeMessage {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Name
    )

    $HWND_BROADCAST = [IntPtr]0xFFFF
    $WM_SETTINGCHANGE = 0x001A
    $SMTO_ABORTIFHUNG = 0x0002
    $SMTO_NOTIMEOUTIFNOTHUNG = 0x0008

    $flags = $SMTO_ABORTIFHUNG -bor $SMTO_NOTIMEOUTIFNOTHUNG
    $null = [WindowsNativeMethods.MessageTimeout]::SendMessageTimeoutW($HWND_BROADCAST, $WM_SETTINGCHANGE, [IntPtr]::Zero, $Name, $flags, 5000, [IntPtr]::Zero)
}

Send-SystemSettingChangeMessage -Name TraySettings
Send-SystemSettingChangeMessage -Name SaveTaskbar
