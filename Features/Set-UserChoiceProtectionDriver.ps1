#Requires -Version 5.1
#Requires -RunAsAdministrator

param (
    [Parameter(Mandatory = $true, ParameterSetName = 'Enable')]
    [switch]
    $Enable,

    [Parameter(Mandatory = $true, ParameterSetName = 'Disable')]
    [switch]
    $Disable,

    [Parameter(ParameterSetName = 'Disable')]
    [switch]
    $Permanent
)

$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version.Major -lt 10) {
    exit 0
}

$ucpdService = Get-Service -Name UCPD -ErrorAction SilentlyContinue

if ($null -eq $ucpdService) {
    exit 0
}

if ($Enable) {
    Set-Service -Name UCPD -StartupType Automatic
    Enable-ScheduledTask -TaskName '\Microsoft\Windows\AppxDeploymentClient\UCPD velocity' | Out-Null
    Remove-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name EnableUCPD -ErrorAction SilentlyContinue

    Write-Host 'The UserChoice Protection Driver will be enabled after restarting the system.'

    exit 0
}

if ($Disable) {
    Set-Service -Name UCPD -StartupType Disabled
    Disable-ScheduledTask -TaskName '\Microsoft\Windows\AppxDeploymentClient\UCPD velocity' | Out-Null

    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\System' -Name EnableUCPD -Value 0 -Type DWord

    if ($Permanent) {
        Write-Host 'The UserChoice Protection Driver will be permanently disabled after restarting the system.'
        exit 0
    }

    $taskName = 'Enable-UCPD-Once'
    $taskDescription = 'EnableUcpdOnce'

    $cmdCommands = @(
        'reg delete HKLM\Software\Policies\Microsoft\Windows\System /v EnableUCPD /f 2>nul || ver >NUL',
        'sc config UCPD start=auto',
        'schtasks /Change /Enable /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity"',
        "schtasks /Delete /TN `"$taskName`" /F"
    )

    $cmdArgument = '/c ' + ($cmdCommands -join ' & ')

    $taskAction = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument $cmdArgument
    $taskTrigger = New-ScheduledTaskTrigger -AtStartup
    $taskPrinciple = New-ScheduledTaskPrincipal -UserId SYSTEM -LogonType ServiceAccount
    $taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

    Register-ScheduledTask -TaskName $taskName -Description $taskDescription -Action $taskAction -Trigger $taskTrigger -Principal $taskPrinciple -Settings $taskSettings -Force | Out-Null

    Write-Host 'The UserChoice Protection Driver will be temporarily disabled after restarting the system.'
}
