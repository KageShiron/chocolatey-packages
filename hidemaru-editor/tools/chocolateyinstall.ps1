
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm883_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo883_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat883_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm883_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo883_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat883_x64_signed.exe'
    
    'checksum32'  = '1f4cfcde99f29758a24d05f5122674d401603f0fd3ab15a62e27debc8ea1727b'
    'checksum32e' = 'b1bf239df5d0367eab4155e01a47c7b9b98828157b47035e22f8fd2251345b3b'
    'checksum32f' = 'c2b0810f54bd6585a38550ed1685c46051918994b7169bcfe28f5c507ca5bc2f'
    'checksum64'  = '36f607037b64a28530947aac15677f24c349403e042a546c701b3775a8535b3d'
    'checksum64e' = '468d6446ce2bcb8929a6cf18386befa89c8d077eb0c3058434c3feba417c0342'
    'checksum64f' = '7018693bf7a4fc068fadd3b8b4b792ee86a0e0a0adf2394c4bafbb59961e430e'
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
