$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\bgb"
$programsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutPath = $programsPath + '\BGB.lnk'

Remove-Item -Force $shortcutPath
# Necessary as ini files would stay on disk otherwise!
Remove-Item -Recurse -Force $installDir

if ($(Test-Path $env:TEMP\bgb.ini) -eq $true) {
    Remove-Item $env:TEMP\bgb.ini
}
