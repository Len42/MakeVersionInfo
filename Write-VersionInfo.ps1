param ($File)
(&"$PSScriptRoot\Get-VersionInfo.ps1" (Split-Path -Parent $File)) -join "," >$File
