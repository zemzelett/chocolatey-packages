Uninstall-ChocolateyZipPackage 'bgb' 'bgb*.zip'

$shortcut = $env:userprofile + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BGB.lnk'
Write-Host "`nRemoving start menu shortcut..." -ForegroundColor green
Remove-Item -Force $shortcut

$shortcut2 = $env:userprofile + '\Desktop\BGB.lnk'
Write-Host "`nRemoving desktop shortcut..." -ForegroundColor green
Remove-Item -Force $shortcut2