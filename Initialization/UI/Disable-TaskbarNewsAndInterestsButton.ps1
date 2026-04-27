$ErrorActionPreference = 'Stop'

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10 -and $osVersion.Build -lt 22000) {
    if (-not ('WindowsNativeMethods.ShellHashUtility' -as [type])) {
        Add-Type -Namespace WindowsNativeMethods -Name ShellHashUtility -MemberDefinition @'
[DllImport("Shlwapi.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = false)]
public static extern int HashData(byte[] pbData, int cbData, byte[] pbHash, int cbHash);
'@
    }

    function EncodeShellFeedsTaskbarDisabledViewMode {
        $machineIdProperty = Get-ItemProperty -Path 'HKLM:\Software\Microsoft\SQMClient' -Name MachineId -ErrorAction SilentlyContinue
        $machineId = '{C283D224-5CAD-4502-95F0-2569E4C85074}'

        if ($machineIdProperty) {
            $machineId = $machineIdProperty.MachineId
        }

        $combined = $machineId + '_2'
        $reversed = -join $combined[$combined.Length..0]
        $dataBytes = [system.Text.Encoding]::Unicode.GetBytes($reversed)
        $dataBytes = $dataBytes + @(0, 0, 0) # Must 0x53 bytes long
        $hashBytes = [byte[]](New-Object -TypeName byte[] -ArgumentList 4)
        [WindowsNativeMethods.ShellHashUtility]::HashData($dataBytes, $dataBytes.Length, $hashBytes, $hashBytes.Count) | Out-Null

        return [System.BitConverter]::ToUInt32($hashBytes, 0)
    }

    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Windows\Windows Feeds'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Taskbar Policy : Enable news and interests on the taskbar : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Windows Feeds' -Name EnableFeeds -Value 0 -Type DWord

    Write-Host 'Taskbar : Enable news and interests on the taskbar : Disabled'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -Name ShellFeedsTaskbarViewMode -Value 2 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -Name ShellFeedsTaskbarOpenOnHover -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -Name ShellFeedsTaskbarContentUpdateMode -Value 0 -Type DWord
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds' -Name EnShellFeedsTaskbarViewMode -Value (EncodeShellFeedsTaskbarDisabledViewMode) -Type DWord

}

if ($osVersion.Major -ge 10 -and $osVersion.Build -ge 22000) {
    $policyKeys = @(
        'HKLM:\Software\Policies\Microsoft\Dsh'
    )
    $policyKeys | ForEach-Object { (Test-Path -Path $_) -or (New-Item -Path $_ -Force) } | Out-Null

    #

    Write-Host 'Taskbar Policy : Allow widgets : Disabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Dsh' -Name AllowNewsAndInterests -Value 0 -Type DWord

    Write-Host 'Taskbar Policy : Disable Widgets On Lock Screen : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Dsh' -Name DisableWidgetsOnLockScreen -Value 1 -Type DWord

    Write-Host 'Taskbar Policy : Disable Widgets Board : Enabled'
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Dsh' -Name DisableWidgetsBoard -Value 1 -Type DWord

    Write-Host 'Taskbar : Hide the Widgets button on the taskbar. : Enable'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarDa -Value 0 -Type DWord
    Invoke-CommandInDesktopPackage -AppId 'Widgets' -PackageFamilyName 'MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy' -Command reg.exe -Args 'add HKCU\Software\Microsoft\Windows\CurrentVersion\Dsh /v HoverEnabled /t REG_DWORD /d 0 /f'
    Invoke-CommandInDesktopPackage -AppId 'Widgets' -PackageFamilyName 'MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy' -Command reg.exe -Args 'add HKCU\Software\Microsoft\Windows\CurrentVersion\Dsh /v disabledFeeds /t REG_SZ /d "MicrosoftWindows.Client.WebExperience_cw5n1h2txyewy!Widgets!!com.msn.desktopfeed" /f'
}
