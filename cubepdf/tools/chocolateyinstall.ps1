
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

  checksum      = '88511de4b7300c712acba9cb95a0e44adfe6b2b390fcb90290b7b15d3cb94305'
  checksumType  = 'sha256'
  checksum64    = 'e49e813ddcad2d0c61a836c3cc30571e97c71a7eab74a99986055719278b9e90'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















