$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.9.0a/pandoc-crossref-Windows.7z'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url
    fileType      = 'zip'
    softwareName  = 'pandoc-crossref*'
    checksum      = 'B17CE7B5F07BA763C1739085F9B054027F2B98EA36EA5840B521C73B8BF1303F'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
