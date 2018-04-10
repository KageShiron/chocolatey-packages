$ErrorActionPreference = 'Stop';
$packageName = 'pandoc-crossref'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/lierdakil/pandoc-crossref/releases/download/v0.4.0.0-alpha0/windows-ghc82-pandoc21.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url

    softwareName  = 'pandoc-crossref*'

    checksum      = '1cb1707bc2415a12a04f5831452889151db087b232f948bfc2c8459b15aec4fa'
    checksumType  = 'sha256'

}
Install-ChocolateyZipPackage @packageArgs
