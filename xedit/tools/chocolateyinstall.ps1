$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://www002.upp.so-net.ne.jp/janus/program/xedit184.zip'

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url
    softwareName  = 'xedit*'
    checksum      = '4EA6A83F1B75005413E7E8C283969601FC663B9708C35F0765A09ED441F9720E'
    checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
