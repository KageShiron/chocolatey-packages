$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.0.2/windows-ghc82-pandoc21.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '0ae155c464abaaa2bacae2059662c913306f2237622f1ffc4449109f6425aa03'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
