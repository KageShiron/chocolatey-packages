
$ErrorActionPreference = 'Stop';


$packageName= 'favbinedit'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/69/46/3447/FavBinEdit-1-2-0.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'FavBinEdit*'

  checksum      = '1fc37ea29a66aae99deb2ab63ac906866885d34b416abb0f76d3c52c2b2a58c5'
  checksumType  = 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs


















