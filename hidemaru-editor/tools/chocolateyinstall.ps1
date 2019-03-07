
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm888_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo888_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat888_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm888_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo888_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat888_x64_signed.exe'
    
    'checksum32'  = '623426c3ed1903c2275c4bae02df56ccd39841102246b748b58b884405304dc7'
    'checksum32e' = 'ed0b187e6d1a337cc879a179e96783ee599304bd48f71cd3fab23a5e9f7cd232'
    'checksum32f' = 'aac361ee5e5f059cd8eefd28238467bc071e1f1cefce710a1bcd48b7a7b3f828'
    'checksum64'  = '4ffd86aef684f1a799dee489db4c92938a720909d400db53f10dd397e1ac93af'
    'checksum64e' = '7ce91f6f3aaac40b1b513dca116f33cce8e46adf87514af759e592fb9824a937'
    'checksum64f' = '2607f144c74d22c5d4886dbb645afe37a523466b749bb2512281cf6983316292'
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
