
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

$pp | Format-Table | Out-String

$hmtype = $pp["type"]

if ($null -eq $hmtype) {
    $hmtype = "32"
}

$types = @{
    'url32'       = 'http://hide.maruo.co.jp/software/bin3/hm886_signed.exe'
    'url32e'      = 'http://hide.maruo.co.jp/software/bin3/maruo886_signed.exe'
    'url32f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat886_signed.exe'
    'url64'       = 'http://hide.maruo.co.jp/software/bin3/hm886_x64_signed.exe'
    'url64e'      = 'http://hide.maruo.co.jp/software/bin3/maruo886_x64_signed.exe'
    'url64f'      = 'http://hide.maruo.co.jp/software/bin3/hmfloat886_x64_signed.exe'
    
    'checksum32'  = 'be169df7df365113a781d1889afa9d4919c5ec0f92d7022aa04e4143ad3bdd82'
    'checksum32e' = '3288e7343092b2f11d41ac791e8cca0d0719eca00f5903ef9de6ce4d18096fd4'
    'checksum32f' = 'a102c6d2cf57eb7add9fb231c0be64cff3ac70051eb558e662082e07e8ebabb9'
    'checksum64'  = '0367593dc56f5abf532cd76e877c92a8cd4f516c096b2909fc7f37b41992b63f'
    'checksum64e' = '5a2505e562506abc658da9f40fb7b9d9a7106ede281308a32f15f5d12e38f8cb'
    'checksum64f' = '3ba193e1e2098af48931d2114c09011ed4aa7d4861c275abb897748b3e410a31'
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
