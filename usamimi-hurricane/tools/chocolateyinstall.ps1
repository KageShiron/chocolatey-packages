$ErrorActionPreference = 'Stop';

$packageName= 'usamimi-hurricane'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ftp.vector.co.jp/70/35/2117/UsaMimi_v028.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'UsaMimi Hurricane*'
  checksum      = 'b0335a3959753b6411ff998f36ccf39cfef60c9b189b581c49051ead979ad9d6'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
