$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.4.0.0-alpha2/windows-ghc84-pandoc22.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '2b2cb321573a487866fabdf0f21fc9b0a331156678c070b45fe0beffd28c028f'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
