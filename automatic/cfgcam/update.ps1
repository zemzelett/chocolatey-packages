import-module au

$releases = 'https://api.github.com/repos/SuslikV/cfg-cam/releases/latest'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

# I had to add this, because the exe was downloaded and remained inside the
# tools directory, being packaged and failing the validation testing online...
# https://github.com/majkinetor/au#automatic-checksums
# https://github.com/majkinetor/au#manual-checksums
function global:au_BeforeUpdate() {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url
}

function global:au_GetLatest {
    $json = Invoke-RestMethod -Uri $releases

    foreach ($asset in $json.assets) {
        if ($asset.name -match "exe") {
            $url = $asset.browser_download_url
            break
        }
    }
    
    $version = $url -Split "/" | Select-Object -Last 1 -Skip 1

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update -ChecksumFor None