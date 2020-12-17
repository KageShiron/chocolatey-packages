
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm895_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo888_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat895_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm895_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo888_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat895_x64_signed.exe'
    
    'checksum32'  = '2c02b7a0aa9ac9107845bc37875397d470a4f38c6bda7f191b56fd81a0fa8e50'
    'checksum32e' = 'ed0b187e6d1a337cc879a179e96783ee599304bd48f71cd3fab23a5e9f7cd232'
    'checksum32f' = '313d5ee638ab1f8f255d1b4938b2263c8dba2744c5646e2a1d400cfa65f8f8e5'
    'checksum64'  = 'a64cac6a96ce06c90b1ecba4743421d0371c1450c60a6f88043a058e052784e6'
    'checksum64e' = '7ce91f6f3aaac40b1b513dca116f33cce8e46adf87514af759e592fb9824a937'
    'checksum64f' = 'f6af2aaed87e2744b9f32c0f0965d04ab676c72e41ac66a509ff75a3c5bf9c12'
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
