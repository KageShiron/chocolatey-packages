$ErrorActionPreference = 'Stop';
$packageName = 'limechat'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://hp.vector.co.jp/authors/VA022249/files/lime240.exe'
$url64 = 'http://hp.vector.co.jp/authors/VA022249/files/lime240_x64.exe'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    fileType      = 'exe'
    url           = $url
    url64           = $url64

    softwareName  = 'LimeChat'

    checksum      = 'c625d643bae7cc82650ba3724cd74fc44f951e9f755031d13c0bc9e46e700d26'
    checksum64      = '20fd26008787153e54436ba2d18976771fda3f30ea95762c2be37e7fce2b00b1'
    checksumType  = 'sha256'
}
echo "" > (Join-Path $toolsDir "uninst.exe.ignore")
Install-ChocolateyZipPackage @packageArgs
