
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/ffftp/ffftp/releases/download/v4.8/ffftp-v4.8-x86.msi'
$url64      = 'https://github.com/ffftp/ffftp/releases/download/v4.8/ffftp-v4.8-x64.msi'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  silentArgs     = "/quiet /norestart"
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = 'f575db65bd712d646a75648fbbc2713527ce59023c48749b10f0c9d1477d8941'
  checksum64      = 'cde4935a66c38cdf37cde589803317b4e1e87dc99e251ddb778b2aceba999444'
  checksumType  = 'sha256'

}

Install-ChocolateyPackage @packageArgs
