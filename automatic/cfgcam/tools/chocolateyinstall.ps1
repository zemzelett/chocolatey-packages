$ErrorActionPreference = 'Stop';

$pkgDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = ''
$checksum = ''


# $packageArgs = @{
#   PackageName  = $env:ChocolateyPackageName
#   FileFullPath = "$pkgDir\WebCameraConfig.exe"
#   Url          = $url
#   Checksum     = $checksum
#   ChecksumType = 'sha256'
# }

#Get-ChocolateyWebFile $packageArgs -FileFullPath $packageArgs.FileFullPath
Get-ChocolateyWebFile -packageName $env:ChocolateyPackageName -FileFullPath "$pkgDir\WebCameraConfig.exe" -Url $url -Checksum $checksum
