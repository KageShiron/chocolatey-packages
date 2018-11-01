$ErrorActionPreference = 'Stop';

$packageName= 'usamimi-hurricane'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/70/90/2117/UsaMimi_v029.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'UsaMimi Hurricane*'
  checksum      = '4df541d4ce3b1152f24e92548a01f6d372f539f71ccb791c5b8749d73a5286ce'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
