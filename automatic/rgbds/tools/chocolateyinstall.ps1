$ErrorActionPreference = 'Stop';

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\rgbds"
$url32 = 'https://github.com/gbdev/rgbds/releases/download/v0.5.2/rgbds-0.5.2-win32.zip'
$checksum32 = '00233a80fe8269fa0be99504a5f2ef308b38f8094bd28dab7232e76ed306500d'
$url64 = 'https://github.com/gbdev/rgbds/releases/download/v0.5.2/rgbds-0.5.2-win64.zip'
$checksum64 = '36907be26993876b1cacf320d6db18436eabe045ae731a09a183183a9f9591c8'


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
