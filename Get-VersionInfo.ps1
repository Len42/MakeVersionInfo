param ($ProjectDir)
Push-Location $ProjectDir
$info = git describe --tags
Pop-Location
$versionName = $info
if ($info[0] -eq "v") {
    $info = -join $info[1..999]
}
$infoparts = $info -split "[-.]"
$versionInfo = $infoparts[0..2]
if ($infoparts.Count -lt 4) {
    $versionInfo += @(0)
} else {
    $versionInfo += $infoparts[3]
}
$versionInfo += $versionName
$versionInfo += [System.DateTime]::UtcNow
$versionInfo