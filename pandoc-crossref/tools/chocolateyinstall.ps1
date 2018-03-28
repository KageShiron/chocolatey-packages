$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.1.0/windows-ghc82-pandoc21.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '5013ea86330f11400ee713843c65aabdb23d012bca157edf4c452a4f824fcae6'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
