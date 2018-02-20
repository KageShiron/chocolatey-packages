$ErrorActionPreference = 'Stop';

$packageName= 'usamimi-hurricane'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/69/64/2117/UsaMimi_v027.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'UsaMimi Hurricane*'
  checksum      = '0223558b918e76c802d02824abad4073ece5673957b5e49fba00ff5f26420223'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
