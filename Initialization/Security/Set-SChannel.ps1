$ErrorActionPreference = 'Stop'

$disabledProtocolKeys = @(
    'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client',
    'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server',
    'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client',
    'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server'
)
$disabledProtocolKeys | ForEach-Object {
    (Test-Path -Path $_) -or (New-Item -Path $_ -Force) | Out-Null

    Set-ItemProperty -Path $_ -Name DisabledByDefault -Value 1 -Type DWord
    Set-ItemProperty -Path $_ -Name Enabled -Value 0 -Type DWord
}

$enabledProtocolKeys = @(
    'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client',
    'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
)

$osVersion = [System.Environment]::OSVersion.Version

if ($osVersion.Major -ge 10) {
    $enabledProtocolKeys += @(
        'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client',
        'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server'
    )
}

$enabledProtocolKeys | ForEach-Object {
    (Test-Path -Path $_) -or (New-Item -Path $_ -Force) | Out-Null

    Set-ItemProperty -Path $_ -Name DisabledByDefault -Value 0 -Type DWord
    Set-ItemProperty -Path $_ -Name Enabled -Value 1 -Type DWord
}
