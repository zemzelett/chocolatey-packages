$programsPath = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$sameboyPath = $programsPath + '\SameBoy'

Remove-Item -Recurse -Force $sameboyPath