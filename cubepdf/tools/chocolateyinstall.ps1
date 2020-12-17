
$ErrorActionPreference = 'Stop';

$packageName= 'cubepdf'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/cube-soft/Cube.Pdf/releases/download/3.0.0/cubepdf-1.2.0.exe'
$url64      = 'https://github.com/cube-soft/Cube.Pdf/releases/download/3.0.0/cubepdf-1.2.0-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'cubepdf*'

  checksum      = 'd536f9648955a107aa7d8b9b30e94ae361ab69db26994a4ed4c3f9af79a0341f'
  checksumType  = 'sha256'
  checksum64    = 'e5451ef053c929a1f6d2dcde4e57e649669d52afa890a775f1f2846801663b2e'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















