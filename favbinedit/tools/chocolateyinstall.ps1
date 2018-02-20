
$ErrorActionPreference = 'Stop';


$packageName= 'favbinedit'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/69/79/3447/FavBinEdit-1-2-1.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'FavBinEdit*'

  checksum      = '4acceac4e1f65a731b4cc8d1dd062d5869a73ee3be7a5f11ccb56546bf6a5f44'
  checksumType  = 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs


















