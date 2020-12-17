import-module au

function global:au_GetLatest {
    $url=""
    $rel = (Invoke-WebRequest https://api.github.com/repos/sakura-editor/sakura/releases/latest -UseBasicParsing | ConvertFrom-Json);
    Write-Host $rel.name
    foreach( $ast in $rel.assets ){
        if( $ast.name.EndsWith("-Release-Installer.zip")) { $url = $ast.browser_download_url }
    }
    return @{ 
        Version = ($rel.name -replace "v","")
        URL32 = $url;
        ChecksumType32 = 'sha256'
    }
}


function global:au_BeforeUpdate() {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
 }

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"           #1
            "(?i)(^\s*[$]checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32)'"      #2
        }
    }
}


if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor all
}

Update-Package
