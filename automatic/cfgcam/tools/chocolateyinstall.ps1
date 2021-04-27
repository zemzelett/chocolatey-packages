$ErrorActionPreference = 'Stop';

$pkgDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = ''
$checksum = ''

Get-ChocolateyWebFile -packageName $env:ChocolateyPackageName -FileFullPath "$pkgDir\WebCameraConfig.exe" -Url $url -Checksum $checksum -checksumType 'sha256'
