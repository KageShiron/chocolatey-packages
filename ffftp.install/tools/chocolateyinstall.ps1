
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/ffftp/ffftp/releases/download/v4.7/ffftp-v4.7-x86.msi'
$url64      = 'https://github.com/ffftp/ffftp/releases/download/v4.7/ffftp-v4.7-x64.msi'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  silentArgs     = "/quiet /norestart"
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = ''
  checksum64      = ''
  checksumType  = 'sha256'

}

Install-ChocolateyPackage @packageArgs
