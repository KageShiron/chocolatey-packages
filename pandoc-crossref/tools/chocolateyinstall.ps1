$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.0/windows-ghc86-pandoc24.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '61bf286ca2ef09dd19e8825303e4230f883c09c53032123be5de37039eb13ec5'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
