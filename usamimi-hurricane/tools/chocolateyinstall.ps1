$ErrorActionPreference = 'Stop';

$packageName= 'usamimi-hurricane'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/69/12/2117/UsaMimi_v026.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'UsaMimi Hurricane*'
  checksum      = 'b1a29cb69f0a1079d1bdb70a78ef2a2d60dddb9cc8511f8f76499db49488cb13'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
