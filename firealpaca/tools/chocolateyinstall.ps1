
$ErrorActionPreference = 'Stop';

$packageName= 'firealpaca'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://firealpaca.com/download/win'

$packageArgs = @{
  packageName   = $packageName;
  unzipLocation = $toolsDir;
  fileType      = 'exe';
  url           = $url;
  validExitCodes= @(0, 1116);

  checksum      = 'f9a75e0d3fdd388c2433a3aaf9edb7a6798d1617e5fc7855dc138f400d7dbbd4';
  checksumType  = 'sha256';

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}
$options =
@{
  Headers = @{
    Referer = 'http://firealpaca.com/';
  }
}

Install-ChocolateyPackage @packageArgs -options $options