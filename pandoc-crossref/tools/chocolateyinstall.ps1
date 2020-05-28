$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.3/pandoc-crossref-Windows-2.9.2.1.7z'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '836277468b11527da159cc6d4091758e31744ca73c337243f45b67678e235e48'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
