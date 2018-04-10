
$ErrorActionPreference = 'Stop';

$packageName= 'cubepdf'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.cube-soft.jp/cubepdfutility/dl.php?mode=x86'
$url64      = 'http://www.cube-soft.jp/cubepdfutility/dl.php?mode=x64'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdf*'

  checksum      = '576019119ed89e34852c069623deafe3b7a4cba652ce160c1acdcf0552396ca0'
  checksumType  = 'sha256'
  checksum64    = '4b6685e4c567b6436331083f734837f3d31049d5f754071c2276a1d72c646832'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















