$ErrorActionPreference = 'Stop';
$packageName= 'smartsystemmenu'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com//AlexanderPro/SmartSystemMenu/releases/download/v2.1.1/SmartSystemMenu_v2.1.1.zip'

$packageArgs = @{
  packageName   = $packageName
  destination   = $toolsDir
  fileType      = 'zip'
  url           = $url
  softwareName  = 'SmartSystemMenu*'
  checksum      = '28b1fb9dee8f69c45166361c31db5c58fcb3ef25b5e0826ca0e385299820cefb'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs









