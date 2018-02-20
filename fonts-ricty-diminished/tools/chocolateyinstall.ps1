
$ErrorActionPreference = 'Stop';

$packageName= 'fonts-ricty-diminished'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://www.rs.tus.ac.jp/yyusa/ricty_diminished/ricty_diminished-4.1.1.tar.gz'
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = '.tar.gz'
  url           = $url

  softwareName  = 'fonts-ricty-diminished*'

  checksum      = '09d6cf8eaf3402205dd8a0fa35469d41833b4e85bedddfac235255d78747766b'
  checksumType  = 'sha256'
}

# un gz
Install-ChocolateyZipPackage @packageArgs

# un tar
$dist =  Join-Path $toolsDir "fonts"
$tar = Join-Path $toolsDir ([System.IO.Path]::GetFileNameWithoutExtension($url))
Get-ChocolateyUnzip -FileFullPath $tar -Destination $dist

# Install fonts
powershell -f """$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Add-Font.ps1"""  $dist

Write-ChocolateySuccess "$packageName"
