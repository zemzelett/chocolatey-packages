$ErrorActionPreference = 'Stop';

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\rgbds"
$url32 = 'https://github.com/gbdev/rgbds/releases/download/v0.6.1/rgbds-0.6.1-win32.zip'
$checksum32 = 'be2c81f7155be50f4cdbf4fbfe6d2499c2bc3df72cc0545dbd63ef5888ff2816'
$url64 = 'https://github.com/gbdev/rgbds/releases/download/v0.6.1/rgbds-0.6.1-win64.zip'
$checksum64 = '3cae18202a0672152063e49b935ddb9d754f7c2146447bab8aec875be7b866cf'


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
