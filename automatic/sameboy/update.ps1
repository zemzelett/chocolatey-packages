import-module au

$releases = 'https://api.github.com/repos/LIJI32/SameBoy/releases/latest'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $json = Invoke-RestMethod -Uri $releases

    foreach ($asset in $json.assets) {
        if ($asset.name -match "winsdl") {
            $url = $asset.browser_download_url
            break
        }
    }
    
    $version = $url -Split "/" | Select-Object -Last 1 -Skip 1
    $version = $version.substring(1)

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update -ChecksumFor 32