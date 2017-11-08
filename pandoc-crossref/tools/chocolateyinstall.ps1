$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.2.7.0/windows-ghc8-pandoc1-19.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = 'd1fcbdf76f251412d53a2a328cebee211f4235b057b8268a36b5b5d3d33351c3'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
