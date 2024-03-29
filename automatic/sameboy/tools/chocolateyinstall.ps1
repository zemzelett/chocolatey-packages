﻿$ErrorActionPreference = 'Stop';

$sameboyPkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$sameboyInstallDir = $sameboyPkgDir + "\sameboy"
$url = 'https://github.com/LIJI32/SameBoy/releases/download/v0.15.8/sameboy_winsdl_v0.15.8.zip'
$checksum = ''

# $sameboyDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + "\sameboy"
$SameboyExePath = $sameboyInstallDir + '\sameboy.exe'
$SameboyDebuggerExePath = $sameboyInstallDir + '\sameboy_debugger.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $sameboyInstallDir
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# If we didn't want those auto-generated shims
# New-Item -Path $sameboyInstallDir -Name "sameboy.exe.ignore" -ItemType "file"
# New-Item -Path $sameboyInstallDir -Name "sameboy_debugger.exe.ignore" -ItemType "file"

# GUI shims (https://community.chocolatey.org/courses/creating-chocolatey-packages/shims)
New-Item -Path $sameboyInstallDir -Name "sameboy.exe.gui" -ItemType "file"
New-Item -Path $sameboyInstallDir -Name "sameboy_debugger.exe.gui" -ItemType "file"

$programsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$sameboyShortcutsPath = $programsPath + '\SameBoy'

New-Item -Force -Path $sameboyShortcutsPath -Type Directory

$sameboyShortcutPath = Join-Path $sameboyShortcutsPath "SameBoy.lnk"
$sameboyDebuggerShortcutPath = Join-Path $sameboyShortcutsPath "SameBoy Debugger.lnk"
Install-ChocolateyShortcut -shortcutFilePath $sameboyShortcutPath -targetPath $SameboyExePath
Install-ChocolateyShortcut -shortcutFilePath $sameboyDebuggerShortcutPath -targetPath $SameboyDebuggerExePath
