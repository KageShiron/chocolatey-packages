
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.portable'
$toolsDir   = Join-Path (Get-ToolsLocation) $packageName
$url        = 'https://github.com/sayurin/ffftp/releases/download/v3.2/ffftp-v3.2-x86.zip'
$url64      = 'https://github.com/sayurin/ffftp/releases/download/v3.2/ffftp-v3.2-x64.zip'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = 'e7260e0ab93f118a927db4492d509768f21fb0840f21da86e05c20ff8aa9ef66'
  checksum64      = 'f26e8a6c4a3f191ae567604fb33a65d244713b1938cf82180eef0e0bdec23b9b'
  checksumType  = 'sha256'


}
Install-ChocolateyZipPackage @packageArgs
$installPath = Join-Path (Get-ToolsLocation) $packageName
$installFile = Join-Path $installPath "ffftp.exe"
Install-BinFile -Name "ffftp" $installFile
