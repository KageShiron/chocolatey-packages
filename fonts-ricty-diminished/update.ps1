$releases = "http://www.rs.tus.ac.jp/yyusa/ricty_diminished.html"

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $releases
     $regex   = '.tar.gz$'
     $verregex= [regex]'ricty_diminished/ricty_diminished-(.*?)\.tar.gz'
     $url     = "http://www.yusa.lab.uec.ac.jp/~yusa/" + ($download_page.links | ? href -match $regex | select -First 1 -expand href)
     $version = $verregex.Match( $url ).Groups[1]
     return @{ 
        Version = $version;
        URL32 = $url;
        ChecksumType32 = 'sha256'
     }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}


update -ChecksumFor 32
