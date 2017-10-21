
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm875_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo875_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat875_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm875_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo875_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat875_x64_signed.exe'
    
    'checksum32'  = 'bed25bc14f231159933cdbc060da40618f284fb57633f256891e340077d7080d'
    'checksum32e' = 'eb81f28a7bff77ceaf147bc8855d7399ba7ac9b5f33010322064bddb6a0bc8f4'
    'checksum32f' = '649507219f573599d79f4370f0b2f647dd6176fd6f8d03578df4c7e8c22effcf'
    'checksum64'  = 'ca7fa8d387a5bd445d31c6f1396db0f66f536a0c8c9854458f03bdb174f8356fd'
    'checksum64e' = '62f8e16d62d13435a07cae88b1cddc5492001811aa4b84cb960603dec860d32e'
    'checksum64f' = '8aecb7c4e9622487dadb49c59f10246f159122a9727e776ab7b0656d1ed6913e'
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
