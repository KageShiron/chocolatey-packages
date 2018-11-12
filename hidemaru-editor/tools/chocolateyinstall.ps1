
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm885_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo885_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat885_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm885_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo885_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat885_x64_signed.exe'
    
    'checksum32'  = '46242e5fd77f3e3067c4b68f61b213fd453c053e2f595282b974b35fd5d8b008'
    'checksum32e' = '951d61a0374a5921fc0f965e5937955444f351a0a18b97b202feb89db0f95b79'
    'checksum32f' = '914212f4fd99a712233d209a0d9a4127ee2a7336e170f90c1bee74077f8d538d'
    'checksum64'  = 'c421ea119402b944dfbcc6752dc47c74d4cc87f3ed6964afc8814c6d407b826a'
    'checksum64e' = '8808206833375919a152142402cdee07778c742e34be1d988f280d018bcef2b6'
    'checksum64f' = '3784d4a6d39b37aae559c3ad115ea6bdda32c16d7317d451cf786ad455e85b04'
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
