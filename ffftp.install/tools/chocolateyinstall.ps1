
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/ffftp/ffftp/releases/download/v3.9/ffftp-v3.9-x86.msi'
$url64      = 'https://github.com/ffftp/ffftp/releases/download/v3.9/ffftp-v3.9-x64.msi'
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
