$ErrorActionPreference = 'Stop'

if (-not ('WindowsNativeMethods.SystemRestoreClient' -as [type])) {
    Add-Type -Namespace WindowsNativeMethods -Name SystemRestoreClient -MemberDefinition @'
[DllImport("Srclient.dll")]
public static extern int SRRemoveRestorePoint (int index);
'@
}

function Remove-ComputerRestorePoint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('SequenceNumber')]
        [int[]]
        $RestorePoint
    )

    process {
        $null = $RestorePoint | ForEach-Object {
            [WindowsNativeMethods.SystemRestoreClient]::SRRemoveRestorePoint($_)
        }
    }
}

Write-Host 'Windows Backup : Disabled'

$drives = [System.IO.DriveInfo]::GetDrives() |
    Where-Object { $_.IsReady -and ($_.DriveType -eq 'Fixed') } |
    ForEach-Object { $_.Name }

Disable-ComputerRestore -Drive $drives

Write-Host 'Windows Backup : Removing restore points...'
Get-ComputerRestorePoint | Remove-ComputerRestorePoint

Write-Host 'Windows Backup : Service : Windows Backup : Disabled'
Set-Service -Name SDRSVC -Status Stopped -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host 'Windows Backup : Scheduled Tasks : \Microsoft\Windows\WindowsBackup\ConfigNotification : Disabled'
$null = schtasks /Change /Disable /TN '\Microsoft\Windows\WindowsBackup\ConfigNotification'
