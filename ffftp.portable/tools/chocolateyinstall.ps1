
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.portable'
$toolsDir   = Join-Path (Get-ToolsLocation) $packageName
$url        = 'https://github.com/sayurin/ffftp/releases/download/v3.5/ffftp-v3.5-x86.zip'
$url64      = 'https://github.com/sayurin/ffftp/releases/download/v3.5/ffftp-v3.5-x64.zip'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = 'f6e7a5cd331b665d19ff403c4dd5cc3cb337a3278c5f20916faabe1a33070cd3'
  checksum64      = '8ad46904e4c05305e5be780b51fe01c6d62953b16ce3b4794b60df2bedd5ce3d'
  checksumType  = 'sha256'


}
Install-ChocolateyZipPackage @packageArgs
$installPath = Join-Path (Get-ToolsLocation) $packageName
$installFile = Join-Path $installPath "ffftp.exe"
Install-BinFile -Name "ffftp" $installFile
