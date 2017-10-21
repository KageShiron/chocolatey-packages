
$ErrorActionPreference = 'Stop';

$packageName = 'SakuraEditor'
$url1 = 'http://sourceforge.net/projects/sakura-editor/files/sakura2-installer/2.2.0.1/sakura_install2-2-0-1.exe?big_mirror=0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$pp = Get-PackageParameters
$pp | Format-Table | Out-String

$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

if ( $null -ne $pp["tasks"]) {
    $silentArgs += " /TASKS=$($pp["tasks"])"
}

echo "SilentArgs : ${silentArgs}"

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    url            = $url1
    softwareName   = 'Sakura Editor*'
    checksum       = 'C5950B0ACAFA906200E1EDDC4E43072BBD1F04457B395287BB0135202504994B'
    checksumType   = 'sha256'
    silentArgs     = $silentArgs
    validExitCodes = @(0)
}

$url2 = 'https://sourceforge.net/projects/sakura-editor/files/sakura2/2.3.2.0/sakura2-3-2-0.zip/download'
$checksum2 = 'f767b65096c96decb1540a7b95ef07b8dc77e08732d8af12a3fdc84e4137f2b0'

$packageArgs2 = @{
    packageName   = $packageName
    url           = $url2
    softwareName  = 'sakura editor*'
    checksum      = $checksum2
    checksumType  = 'sha256'
    UnzipLocation = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs2
Install-ChocolateyPackage @packageArgs

$info = (Get-InstallRegistryKey "sakura editor*").InstallLocation
Move-Item -Force $toolsDir\*\sakura.exe $info

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { Set-Content -Value "" -Path "$_.ignore" }}
