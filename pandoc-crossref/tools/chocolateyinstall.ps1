$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.4.0.0-alpha3/windows-ghc86-pandoc24.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '16915bf6e3c088e9406047d734817dc05494e8289d9506202343a54adee3d243'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
