$ErrorActionPreference = 'Stop';

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\rgbds"
$url32 = 'https://github.com/gbdev/rgbds/releases/download/v0.5.0/rgbds-0.5.0-win32.zip'
$checksum32 = '978528f2bbf23d61a5b7ba3ee574cb7884aa14a98859470000d7dfd012c1b69f'
$url64 = 'https://github.com/gbdev/rgbds/releases/download/v0.5.0/rgbds-0.5.0-win64.zip'
$checksum64 = '1726937614798e35ab18e204f13c0fdb3bc60a24652e64065eb55284fc3ce5fe'


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
