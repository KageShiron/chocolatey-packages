$releases = 'http://firealpaca.com/'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $version = ($download_page.AllElements | ? class -eq "count-new").innerText
    return @{ 
        Version = $version;
        URL32 = "http://firealpaca.com/download/win";
        ChecksumType32 = 'sha256'
    }
}

function au_BeforeUpdate() {
    $options =
    @{
        Referer = 'http://firealpaca.com/';
      
    }
    $fn = [System.IO.Path]::GetTempFileName()

    Invoke-WebRequest -Headers $options -uri $Latest.URL32 -OutFile $fn -UseBasicParsing
    $res = Get-FileHash $fn -Algorithm sha256 | % Hash
    rm $fn -ea ignore

    $Latest.Checksum32 = $res.ToLower()
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}


update -NoCheckUrl -ChecksumFor none
