import-module au

$website = 'https://bgb.bircd.org/'

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
    $res = Invoke-WebRequest -Uri $website
    $version = $res.ParsedHtml.title | Select-String -Pattern '\d\.\d\.\d' | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
    $versionInFile = $version.replace('.', '')

    $url32 = $website + 'bgb' + $versionInFile + '.zip'
    $url64 = $website + 'bgb' + $versionInFile + 'w64.zip'
    
    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update