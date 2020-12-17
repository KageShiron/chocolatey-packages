import-module au

function global:au_GetLatest {
    $x86 = "";
    $x64 = "";
    $rels = (Invoke-WebRequest https://api.github.com/repos/cube-soft/Cube.Pdf/releases -UseBasicParsing | ConvertFrom-Json);
    foreach( $rel in $rels){
        if( $rel.name -notmatch "^CubePDF Utility \d") {continue}
        foreach( $ast in $rel.assets ){
            if( $ast.name.EndsWith("-x64.exe")) { $x64 = $ast.browser_download_url }
            elseif( $ast.name.EndsWith(".exe")) { $x86 = $ast.browser_download_url }
        }
        return @{ 
            Version = ($rel.name -replace "CubePDF Utility ","" -replace " beta","")
            URL32 = $x86;
            URL64 = $x64;
            ChecksumType32 = 'sha256'
        }
    }

}

function global:au_BeforeUpdate() {
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


if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor all
}

Update-Package
