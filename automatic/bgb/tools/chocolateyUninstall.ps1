$programsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutPath = $programsPath + '\BGB.lnk'

Remove-Item -Force $shortcutPath
