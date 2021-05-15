$pkgDir = $env:ChocolateyInstall + "\lib\" + $env:ChocolateyPackageName
$installDir = $pkgDir + "\bgb"

Copy-Item $installDir\bgb.ini -Destination $env:TEMP\bgb.ini
