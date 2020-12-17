$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.8.4/pandoc-crossref-Windows.7z'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = 'DB6E0FE5B26C545E01D99ED891B0833397BB9895E35943913BBAFA74F5DE6F89'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
