$ErrorActionPreference = 'Stop';

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\rgbds"
$url32 = 'https://github.com/gbdev/rgbds/releases/download/v0.5.1/rgbds-0.5.1-win32.zip'
$checksum32 = 'f50faa92ec9a2d18b12eaa12ccda4463cf8d92ee228bfb9bcbdd102887bbe391'
$url64 = 'https://github.com/gbdev/rgbds/releases/download/v0.5.1/rgbds-0.5.1-win64.zip'
$checksum64 = 'c0b35ed749abfde07a8726013357d8971c3d212b4e7232aef0b4d8364e4939b6'


$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  UnzipLocation  = $installDir
  Url            = $url32
  Checksum       = $checksum32
  Url64bit       = $url64
  Checksum64     = $checksum64
  ChecksumType   = 'sha256'
  ChecksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
