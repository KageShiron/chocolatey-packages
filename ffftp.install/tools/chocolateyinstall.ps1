
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sayurin/ffftp/releases/download/v3.0/ffftp-v3.0-x86.msi'
$url64      = 'https://github.com/sayurin/ffftp/releases/download/v3.0/ffftp-v3.0-x64.msi'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  silentArgs     = "/quiet /norestart"
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = 'e792b7446be76ffbcf98db4f47a831257ff1c8f5946a3900bcce6c7cb2e2bea8'
  checksum64      = 'd7918484d1e5b5dd642e115607393d827f2d207a117dd7ccab515b656f1c577d'
  checksumType  = 'sha256'

}

Install-ChocolateyPackage @packageArgs
