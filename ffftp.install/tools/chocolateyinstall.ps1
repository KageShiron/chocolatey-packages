
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sayurin/ffftp/releases/download/v3.5/ffftp-v3.5-x86.msi'
$url64      = 'https://github.com/sayurin/ffftp/releases/download/v3.5/ffftp-v3.5-x64.msi'
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
