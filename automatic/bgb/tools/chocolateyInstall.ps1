$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'bgb'
    url            = 'http://bgb.bircd.org/bgb.zip'
    url64bit       = 'http://bgb.bircd.org/bgbw64.zip'
    checksum       = '62239596976206AF5CDC337C4F733616605E5D1C14CF1028F66458501A839CBC'
    checksum64     = '1016CF355C62173D8FACB0B56C54B52DF8EFCF0364732B52A9388D36FBDBB0CC'
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