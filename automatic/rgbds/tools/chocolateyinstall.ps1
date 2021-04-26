$ErrorActionPreference = 'Stop';

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\rgbds"
$url32 = ''
$checksum32 = ''
$url64 = ''
$checksum64 = ''


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  Url           = $url32
  checksum32    = $checksum32
  Url64bit      = $url64
  Checksum64    = $checksum64
}

Install-ChocolateyZipPackage @packageArgs
