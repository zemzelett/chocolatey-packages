$ErrorActionPreference = 'Stop'

$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\bgb"

$url32 = 'https://bgb.bircd.org/bgb1510.zip';
$checksum32 = 'f05a7a8c526f97f43a93f65b33605277f5677bc43d1ad1f2a752c7326618365b';
$url64 = 'https://bgb.bircd.org/bgb1510w64.zip';
$checksum64 = '1d7cb896e1c3a8aa6b56227f7c43e19887035dc956e11f73e739252381eb045d';

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

if ($(Test-Path $installDir\bgb.ini) -eq $true) {
    Copy-Item $installDir\bgb.ini -Destination $env:TEMP\bgb.ini
}

Install-ChocolateyZipPackage @packageArgs

if ([System.Environment]::Is64BitOperatingSystem -and $env:chocolateyForceX86 -ne $true) {
    $exePath = $installDir + '\bgb64.exe'
    if ($(Test-Path $installDir\bgb64.exe.gui) -eq $false) {
        New-Item -Path $installDir -Name "bgb64.exe.gui" -ItemType "file"
    }
} 
else {
    $exePath = $installDir + '\bgb.exe'
    if ($(Test-Path $installDir\bgb.exe.gui) -eq $false) {
        New-Item -Path $installDir -Name "bgb.exe.gui" -ItemType "file"
    }
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
