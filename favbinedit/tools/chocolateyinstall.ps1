
$ErrorActionPreference = 'Stop';


$packageName= 'favbinedit'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/70/99/3447/FavBinEdit-1-2-3.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'FavBinEdit*'

  checksum      = 'a89197d58e2f327afaa8bc381d72246e2cd50e00e0a7b665dfc21d04b23caa3d'
  checksumType  = 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs


















