
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.portable'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sayurin/ffftp/releases/download/v3.0/ffftp-v3.0-x86.zip'
$url64      = 'https://github.com/sayurin/ffftp/releases/download/v3.0/ffftp-v3.0-x64.zip'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = ''
  checksum64      = ''
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
