
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
  checksum      = 'e3ca425df720f281560bae941c9ed6af1104b872ba8be60ac42daa2e0ddf1107'
  checksum64      = '527dbbca6725c337b9f9c32100669fe05967dc8a31861248651c12d18f50aa43'
  checksumType  = 'sha256'

}

Install-ChocolateyPackage @packageArgs
