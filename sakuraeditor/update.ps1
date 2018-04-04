$releases = "https://sourceforge.net/projects/sakura-editor/files/sakura2/"

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $a = ($download_page.links | where { $_.href -match "/projects/sakura-editor/files/sakura2/.*?" } | select -first 1)
    $regex = [regex]"/projects/sakura-editor/files/sakura2/(.*?)/"
    $version = $regex.Match( $a.href ).Groups[1]
    $url = "https://sourceforge.net/projects/sakura-editor/files/sakura2/${version}/sakura$($version -replace "\.","-").zip/download"

    return @{ 
        Version        = $version;
        URL32          = $url;
        ChecksumType32 = 'sha256'
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url2\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(^[$]checksum2\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}

function global:au_AfterUpdate ($Package)  {
    Set-DescriptionFromReadme $Package -SkipFirst 10
}


update