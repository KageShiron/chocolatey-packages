
$ErrorActionPreference = 'Stop';


$packageName= 'favbinedit'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/71/45/3447/FavBinEdit-1-2-4.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'FavBinEdit*'

  checksum      = '36bd03880578db7f266e8a803f13ad73909b3ade0bc7f3f0c8e927407f3665cd'
  checksumType  = 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs


















