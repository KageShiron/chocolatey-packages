$ErrorActionPreference = 'Stop';

$packageName= 'usamimi-hurricane'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://ftp.vector.co.jp/73/40/2117/UsaMimi_v034.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'UsaMimi Hurricane*'
  checksum      = 'c13633053fbd9bd9ee8adc33223c793140db299bc075b0824b65379da118eec7'
  checksumType  = 'sha256'

}

Install-ChocolateyZipPackage @packageArgs
