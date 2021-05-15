$ErrorActionPreference = 'Stop'

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\bgb"

$url32 = 'https://bgb.bircd.org/bgb159.zip';
$checksum32 = '79357345b5fccf91b632e4987c0b5aa0549a70b563085f8caad86ea8c7ceacf9';
$url64 = 'https://bgb.bircd.org/bgb159w64.zip';
$checksum64 = '8685fc9daf09ceb384330ce543d05471fcc1d427c65de0d68875a97a57532763';

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

if ([System.Environment]::Is64BitOperatingSystem -and $env:chocolateyForceX86 -ne $true) {
    $exePath = $installDir + '\bgb64.exe'
    New-Item -Path $installDir -Name "bgb64.exe.gui" -ItemType "file"
} 
else {
    $exePath = $installDir + '\bgb.exe'
    New-Item -Path $installDir -Name "bgb.exe.gui" -ItemType "file"
}

$programsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutPath = Join-Path $programsPath '\BGB.lnk'
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $exePath

# Copy existing bgb.ini
if ($(Test-Path $env:TEMP\bgb.ini) -eq $true) {
    Copy-Item $env:TEMP\bgb.ini -Destination $installDir\bgb.ini
}

# Set modify permissions on bgb.ini for builtin users group
# Source: https://superuser.com/a/1176767
$acl = Get-Acl $installDir\bgb.ini
$sid = New-Object System.Security.Principal.SecurityIdentifier([System.Security.Principal.WellKnownSidType]::BuiltinUsersSid, $null)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($sid, "Modify", "Allow")
$acl.AddAccessRule($rule)
Set-Acl $installDir\bgb.ini $acl
