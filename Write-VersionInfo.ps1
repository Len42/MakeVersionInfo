param ($File)
(&"$PSScriptRoot\Get-VersionInfo.ps1") -join "," >$File
