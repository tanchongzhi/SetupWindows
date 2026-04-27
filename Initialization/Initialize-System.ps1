param (
    [Parameter()]
    [switch]
    $IncludeOptionalScripts,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    $ExcludeCategory,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string[]]
    $ExcludeScript
)

$ErrorActionPreference = 'Stop'

$currentPrincipal = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()

if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    throw 'You must be running as an administrator, please restart as administrator'
}

if ($PSVersiontable.PSVersion.Major -le 2) {
    $PSScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
}


$ucpdService = Get-Service -Name UCPD -ErrorAction SilentlyContinue

if ($ucpdService.Status -eq 'Running') {
    Write-Host 'Error: The User-Choices Protection Driver is enabled, some registry values cannot be modified.' -ForegroundColor Red
    Write-Host
    Write-Host 'Please call "Features\Set-UserChoiceProtectionDriver.ps1 -Disable" to temporarily disable it and then restarting the system.' -ForegroundColor Yellow
    exit 1
}

$predefinedCategories = @('Apps', 'Input', 'Network', 'Privacy', 'Security', 'System', 'UI')

$predefinedOptionalScripts = @(
    'System\Disable-ShutdownWithoutLogon.ps1',
    'System\Disable-WindowsBackup.ps1'
)

$scriptCategories = if ($ExcludeCategory) {
    $predefinedCategories | Where-Object { $ExcludeCategory -notcontains $_ }
} else {
    $predefinedCategories
}

$scriptDirectories = $scriptCategories | ForEach-Object { Join-Path -Path $PSScriptRoot -ChildPath $_ }

$failedScripts = @()

Get-ChildItem -Path $scriptDirectories -Filter '*.ps1' -Recurse -Force | ForEach-Object {
    $name = $_.FullName.Substring($PSScriptRoot.Length + 1)

    if (($predefinedOptionalScripts -icontains $name) -and -not $IncludeOptionalScripts) {
        return
    }

    if ($ExcludeScript -icontains $name) {
        return
    }

    Write-Host
    Write-Host "Executing $name"

    try {
        & $_.FullName
    } catch {
        Write-Host "Error: $_"

        $failedScripts += $name
    }
}

if (-not $IncludeOptionalScripts) {
    Write-Host
    Write-Host 'The following optional scripts were skipped:'

    $predefinedOptionalScripts | ForEach-Object { Write-Host "  - $_" }
}

if ($failedScripts.Length -gt 0) {
    Write-Host
    Write-Host 'The following scripts failed:'
    $failedScripts | ForEach-Object { Write-Host "  - $_" }
}
