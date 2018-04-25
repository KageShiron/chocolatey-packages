
$ErrorActionPreference = 'Stop';

$packageName= 'ffftp.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/sayurin/ffftp/releases/download/v3.2/ffftp-v3.2-x86.msi'
$url64      = 'https://github.com/sayurin/ffftp/releases/download/v3.2/ffftp-v3.2-x64.msi'
$ErrorActionPreference = 'Stop';


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  silentArgs     = "/quiet /norestart"
  url           = $url
  url64           = $url64
  softwareName  = 'FFFTP'
  checksum      = '7230210604e774c9056baf8506b84469b00181f039c9a48c2cb0fa29441fecaa'
  checksum64      = '64fa1e8a9c2104b05c7ed25644cef632db5f80ea3f1f37a272fc58c202d278a1'
  checksumType  = 'sha256'

}

Install-ChocolateyPackage @packageArgs
