

#Virtual package uses dependency updater to get the version
$au_Force_bak =  $au_Force
$au_Force = $false
. $PSScriptRoot\..\ffftp.install\update.ps1
$au_Force = $au_Force_bak

function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
 }


update -ChecksumFor none