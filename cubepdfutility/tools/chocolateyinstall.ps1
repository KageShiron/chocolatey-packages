
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

  checksum      = 'b18a6a7e68bdecb08a9f3201138814cf7902c49f0f8342cd29bb406f4758c666'
  checksumType  = 'sha256'
  checksum64    = '940e2f47cdfd56ef8cd67efd84419b407d25022743f4d278b6570ce490ae7126'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs


















