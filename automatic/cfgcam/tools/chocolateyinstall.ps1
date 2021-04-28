$ErrorActionPreference = 'Stop';

$pkgDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/SuslikV/cfg-cam/releases/download/1.0/WebCameraConfig.exe'
$checksum = '9b86576136912e33db99e57cb5f392f7995c0397d869d400faa58a67d2359cd4'

Get-ChocolateyWebFile -packageName $env:ChocolateyPackageName -FileFullPath "$pkgDir\WebCameraConfig.exe" -Url $url -Checksum $checksum -checksumType 'sha256'
