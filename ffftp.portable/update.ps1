
$au_Force_bak =  $au_Force
$au_Force = $false
. $PSScriptRoot\..\ffftp.install\update.ps1
$au_Force = $au_Force_bak

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32zip)'"           #1
            "(?i)(^\s*checksum\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum32zip)'"      #2
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64zip)'"           #1
            "(?i)(^\s*checksum64\s*=\s*)'.*'"   = "`$1'$($Latest.Checksum64zip)'"      #2
        }
    }
}


Update-Package