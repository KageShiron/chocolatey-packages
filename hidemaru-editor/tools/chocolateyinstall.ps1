
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm879_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo879_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat879_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm879_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo879_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat879_x64_signed.exe'
    
    'checksum32'  = 'aa651c218591dfbb0b8987ac7ad255e1da1a0185addb7fa4366d1ccf93052c31'
    'checksum32e' = '1fe8af629d9c0aa6a4a3a7c69359c60844aede9144aac89ffbdecc689cd90ff8'
    'checksum32f' = 'c0bdd223c104488943dedfe26d7bcacb78e690017ceb92196668bb32a277ab35'
    'checksum64'  = 'b5aff2ff834f1a0a249caba6e5a9b999f2dd4aaa50298dfacab6d6637b17abcd'
    'checksum64e' = '2cce132929d798cf22db48fa7bae93992e17e34790d29300b638a1d0a702ee09'
    'checksum64f' = '0d2d7038376c00991d8264bfa45ff363d1c027276bfd8440396cd0a0f3f8ffba'
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
