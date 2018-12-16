
#github API
$releases = "https://api.github.com/repos/lierdakil/pandoc-crossref/releases/latest"

function global:au_GetLatest {
    $json = (Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json);
    foreach ( $asset in $json.assets) {
        if ($asset.name -match "windows-.*?.zip") { 
            echo $asset.browser_download_url;
            return @{ 
                Version        = $json.tag_name -replace "v" , "";
                URL32          = $asset.browser_download_url;
                ChecksumType32 = 'sha256'
            }
        }
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}


Update-Package -ChecksumFor 32
