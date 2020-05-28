$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.3/pandoc-crossref-Windows-2.9.2.1.7z'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = 'aee00b0eb376032c8b09ecf5384e194f61b078eb4840281ead34baa8d1206feb'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
