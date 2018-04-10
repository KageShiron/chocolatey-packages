
$ErrorActionPreference = 'Stop';

$packageName= 'cubepdf'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.cube-soft.jp/cubepdf/dl.php?mode=x86'
$url64      = 'http://www.cube-soft.jp/cubepdf/dl.php?mode=x64'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdf*'

  checksum      = 'd4e17b2b3c0329f5974c8875bcf3876ddfeb4dc0c46390bf45845e95c1437dd0'
  checksumType  = 'sha256'
  checksum64    = 'cfd94f0afef98f2c76010cb05c8b98e95298566d5301c3f48e58888b2eff688d'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















