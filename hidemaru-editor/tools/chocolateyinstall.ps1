
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm889_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo889_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat889_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm889_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo889_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat889_x64_signed.exe'
    
    'checksum32'  = 'bd230bd68786e63a9725b719aec4e504239843d69a82f4ca43a4a14dbe0be73b'
    'checksum32e' = '2c7c1442e93d569ebdef3443aa9ae36b26e161251c9ec2ad8429557a682dd036'
    'checksum32f' = 'b46b5afbe1f1d393b7aa8f7e42675fa90e358f24bd55c403c7e54d26d68d5f58'
    'checksum64'  = 'a2fc03d2fd92696320f4aaa4f8b27db70c07a05e288d2a998a996bf78cdd22fc'
    'checksum64e' = '07446a0d3b308f008dcc80fee7ab928c9112d28a15d8503762e90b89135d2dee'
    'checksum64f' = '8696b72b655d6241ccd490b751d14f45034817a0af2901455860a2250f5dd305'
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
