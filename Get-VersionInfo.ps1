param ($ProjectDir)
Push-Location $ProjectDir
$info = git describe --tags
$isdirty = git status --short
Pop-Location
if ($info) {
    if ($isdirty) {
	    $versionName = "$info-dev"
    } else {
	    $versionName = $info
    }
    if ($info[0] -eq "v") {
        $info = -join $info[1..999]
    }
} else {
    $info = "0.0"
}
$infoparts = $info -split "[-.]"
$versionInfo = $infoparts[0..1]
if ($infoparts.Count -lt 3) {
    $versionInfo += @(0)
} else {
    $versionInfo += $infoparts[2]
}
if ($infoparts.Count -lt 4) {
    $versionInfo += @(0)
} else {
    $versionInfo += $infoparts[3]
}
$versionInfo += $versionName
$timestamp = [System.DateTime]::UtcNow
$versionInfo += ("{0:r}" -f $timestamp) -replace ",",""
$versionInfo += ("{0:D}" -f $timestamp) -replace ",",""
$versionInfo
