
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm877_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo877_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat877_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm877_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo877_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat877_x64_signed.exe'
    
    'checksum32'  = '8700bc0e0ba7745a98ca35c7a816a1daa13e6ed0c6022c03ff6be10cb1ec1a48'
    'checksum32e' = 'fc5a823b9cbfb79d5adaad1f9099e2f668f10ac4146c14997500a998c421ed2f'
    'checksum32f' = '1390e8e99cb587ebc69793df6f044062fea7b1f3b3cb320bdd8344fc6864db46'
    'checksum64'  = '393b4674aa7a06dda21ceb809a09e7598d05e5fa783d9191bc3554e138151b17'
    'checksum64e' = 'b5474f9e68a2be26fc2625bfe67ff2fe464e2cab017d7052ebd0266a7f837df5'
    'checksum64f' = 'a133cd7735ef83c9cf8512b10df6ab6e99406badb4987ec5a63951bdece76e98'
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
