$ErrorActionPreference = 'Stop'

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\bgb"

$url32 = '';
$checksum32 = '';
$url64 = '';
$checksum64 = '';

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

if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne $true) {
    $exePath = $installDir + '\bgb.exe'
    New-Item -Path $installDir -Name "bgb.exe.gui" -ItemType "file"
} 
else {
    $exePath = $installDir + '\bgb64.exe'
    New-Item -Path $installDir -Name "bgb64.exe.gui" -ItemType "file"
}

$programsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutPath = $programsPath + '\BGB.lnk'
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $exePath
