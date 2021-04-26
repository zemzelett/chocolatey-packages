import-module au

$releases = 'https://api.github.com/repos/gbdev/rgbds/releases/latest'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $json = Invoke-RestMethod -Uri $releases

    foreach ($asset in $json.assets) {
        if ($asset.name -match "win32") {
            $url32 = $asset.browser_download_url
        }
        if ($asset.name -match "win64") {
            $url64 = $asset.browser_download_url
        }
    }
    
    $version = $url32 -Split "/" | Select-Object -Last 1 -Skip 1
    $version = $version.substring(1)

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update