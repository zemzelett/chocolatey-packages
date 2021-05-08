$ErrorActionPreference = 'Stop'

$url32 = '';
$checksum32 = '';
$url64 = '';
$checksum64 = '';

$packageArgs = @{
    packageName    = 'bgb'
    url            = $url32
    checksum       = $checksum32
    url64bit       = $url64
    checksum64     = $checksum64
    checksumType   = 'sha256'
    checksumType64 = 'sha256'
    dest           = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + '\bgb'
}
Install-ChocolateyZipPackage @packageArgs

if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne $true) {
    $shortcutpath = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + "\bgb\bgb64.exe"
    $targetpath = $env:userprofile + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BGB.lnk'
    Install-ChocolateyShortcut -ShortcutFilePath $targetpath -TargetPath $shortcutpath
    $targetpath2 = $env:userprofile + '\Desktop\BGB.lnk'
    Install-ChocolateyShortcut -ShortcutFilePath $targetpath2 -TargetPath $shortcutpath
} 
else {
    $shortcutpath = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + "\bgb\bgb.exe"
    $targetpath = $env:userprofile + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BGB.lnk'
    Install-ChocolateyShortcut -ShortcutFilePath $targetpath -TargetPath $shortcutpath
    $targetpath2 = $env:userprofile + '\Desktop\BGB.lnk'
    Install-ChocolateyShortcut -ShortcutFilePath $targetpath2 -TargetPath $shortcutpath
}