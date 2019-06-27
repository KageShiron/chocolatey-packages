$ErrorActionPreference = 'Stop';

$packageName= 'usamimi-hurricane'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/71/76/2117/UsaMimi_v030.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'UsaMimi Hurricane*'
  checksum      = '5379c6d9536c6c1ff08d1d4955468e6bb4b6949918ac2a6d84e7550b76190f9b'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
