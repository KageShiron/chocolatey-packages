
$ErrorActionPreference = 'Stop';

$packageName= 'cubepdf'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/cube-soft/Cube.Pdf/releases/download/3.1.1/cubepdf-utility-0.6.4b.exe'
$url64      = 'https://github.com/cube-soft/Cube.Pdf/releases/download/3.1.1/cubepdf-utility-0.6.4b-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdf*'

  checksum      = '530bb0c4ac8f076cf3520af003e5a4fe158054d91c74ece5193005d9cba61f55'
  checksumType  = 'sha256'
  checksum64    = '7eb01512cafe0d802f6e9e9eefadaf6a04b19cf020d685487aaf58e8be7c94f4'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















