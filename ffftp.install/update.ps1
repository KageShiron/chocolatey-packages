
function global:au_GetLatest {
    $rel = (Invoke-WebRequest https://api.github.com/repos/sayurin/ffftp/releases -UseBasicParsing | ConvertFrom-Json);
    $x86zip = "";
    $x64zip = "";
    $x86msi = "";
    $x64msi = "";
    foreach( $ast in $rel.assets ){
        if( $ast.name.EndsWith("x86.zip")) { $x86zip = $ast.browser_download_url }
        if( $ast.name.EndsWith("x64.zip")) { $x64zip = $ast.browser_download_url }
        if( $ast.name.EndsWith("x86.msi")) { $x86msi = $ast.browser_download_url }
        if( $ast.name.EndsWith("x64.msi")) { $x64msi = $ast.browser_download_url }
    }

    return @{ 
        Version = ($rel[0].tag_name -replace "v","")
        URL32zip = $x86zip;
        URL64zip = $x64zip;
        URL32msi = $x86msi;
        URL64msi = $x64msi;
        ChecksumType32 = 'sha256'
    }
}

function au_BeforeUpdate() {
    $Latest.Checksum32zip = Get-RemoteChecksum $Latest.Url32zip
    $Latest.Checksum64zip = Get-RemoteChecksum $Latest.Url64zip
    $Latest.Checksum32msi = Get-RemoteChecksum $Latest.Url32msi
    $Latest.Checksum64msi = Get-RemoteChecksum $Latest.Url64msi
 }

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32msi)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32msi)'"      #2
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64msi)'"           #1
            "(?i)(^\s*checksum64\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum64msi)'"      #2
        }
    }
}


if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}