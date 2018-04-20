$releases = "http://limechat.net/"

function global:au_GetLatest {
    $html = Invoke-WebRequest $releases;
    $exe = ($html.Links | where { $_.href.startsWith("http://hp.vector.co.jp/authors/VA022249/files/") -and $_.href.contains("_x64") })[0]
    $exe.innerText -match "LimeChat\s(.*?)\s64bit"
    $url64 = ($exe.href);
    $url32 = ($exe.href -replace "_x64","");
    Write-Host $url64;
    Write-Host $url32;
    return @{ 
        Version = $matches[1];
        URL64 = $url64;
        URL32 = $url32;
        ChecksumType32 = 'sha256'
    }
}

function au_BeforeUpdate() {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64
 }

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32)'"      #2
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"           #1
            "(?i)(^\s*checksum64\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum64)'"      #2
        }
    }
}


Update-Package