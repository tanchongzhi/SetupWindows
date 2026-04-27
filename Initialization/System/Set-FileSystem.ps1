$ErrorActionPreference = 'Stop'

Write-Host 'FileSystem : Encrypt paging file : Enabled'
fsutil behavior set EncryptPagingFile 1 >$null 2>&1

Write-Host 'FileSystem : Last Access Time feature : Enabled'
fsutil behavior set disableLastAccess 1 >$null 2>&1
