param (
	[Parameter(ValueFromPipeline=$True)]
	[String[]]$Template,
	$VersionFile
)
begin {
	$OutputEncoding = [System.Text.Encoding]::UTF8
	$ver = Import-Csv $VersionFile -Header "Major","Minor","Revision","Build","Tag","Timestamp"
}
process {
	$t = $Template
	$t = $t -replace "%major%", $ver.Major
	$t = $t -replace "%minor%", $ver.Minor
	$t = $t -replace "%revision%", $ver.Revision
	$t = $t -replace "%build%", $ver.Build
	$t = $t -replace "%tag%", $ver.tag
	$t = $t -replace "%timestamp%", $ver.Timestamp
	Write-Output $t
}
