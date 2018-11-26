
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm887_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo887_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat887_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm887_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo887_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat887_x64_signed.exe'
    
    'checksum32'  = '9ecbda1d85fc5b35554d906d3bc7362b1deacb7dca3eda69aa580d27be8e5a8b'
    'checksum32e' = 'a5a422e89a35c7151d430729efd60612c5d801cab5f87fbe79a5d844942c031b'
    'checksum32f' = '4a09847c5a443fdcd5194e1b41da0e33a7caef4227722af234d717bed4d2d665'
    'checksum64'  = '6fcd8673b1609ca497af88ea729a06119be87b377ae0b885ff105aac0b5857b9'
    'checksum64e' = 'd9b36b3f13703c60c54b6323346446500677fae233822f34e01a75f5fdcecc38'
    'checksum64f' = '8f9c8438d813d24ca4a020f537ef0116a153d27b15364c0b14e2a7be1984a416'
}

$url = $types["url" + $hmtype]
$checksum = $types["checksum" + $hmtype]

echo $url

$packageName = "hidemaru-editor"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName  = $packageName
    url          = $url
    checksum     = $checksum
    checksumType = 'sha256'
    FileFullPath = "$toolsDir\signed.exe"
}

Get-ChocolateyWebFile @packageArgs
Get-ChocolateyUnzip "$toolsDir\signed.exe" -Destination $toolsDir

$files = get-childitem $toolsDir -include *.exe -recurse

foreach ($file in $files) {
    New-Item "$file.ignore" -type file -force | Out-Null
}

$param = "/h "
$pdir = $pp["dir"]
$poutput = $pp["output"]
$pkey = $pp["key"]
$pname = $pp["name"]
$pexit = $pp["exit"]

if ($null -ne $pdir) {$param += "/dir $pdir "}
if ($null -ne $poutput) {$param += "/output $poutput "}
if ($null -ne $pkey) {$param += "/key $pkey "}
if ($null -ne $pname) {$param += "/name $pname "}
if ($null -ne $pexit) {$param += "/exit"}

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    file           = "$toolsDir/hmsetup.exe"
    softwareName   = 'Hidemaru Editor'
    silentArgs     = $param
    validExitCodes = @(1)
}

Install-ChocolateyInstallPackage @packageArgs
