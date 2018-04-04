
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
  checksum      = 'c92949e0919b0c8a56d89b3ce9918ff21b35ec836a1a685811a4a9735bbf91dd'
  checksum64      = 'e7b53b7edb12ac00c4432a1a38ee2a5d9f8310475b137a4786a0df41e46c10b4'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
