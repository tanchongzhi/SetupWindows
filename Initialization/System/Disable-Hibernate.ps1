$ErrorActionPreference = 'Stop'

Write-Host 'Hibernate : Disabled'

try {
    powercfg /hibernate off >$null 2>&1
} catch {
}

$hibernateFilePath = "$env:SystemDrive\hiberfil.sys"

if (Test-Path -Path $hibernateFilePath) {
    Write-Host 'Hibernate : Deleting Hibernate File...'
    Remove-Item -Path $hibernateFilePath -Force -ErrorAction SilentlyContinue
}
