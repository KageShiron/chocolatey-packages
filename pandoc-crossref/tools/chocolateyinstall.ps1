$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.2.6.0/windows-ghc8-pandoc1-19.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '8ec96ff50cfe8e5461eac742461604412d577f49f6f3d6e92ad2fe24b1fe57a5'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
