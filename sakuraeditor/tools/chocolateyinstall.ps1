$ErrorActionPreference = 'Stop';

$packageName= 'SakuraEditor'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/sakura-editor/sakura/releases/download/v2.4.1/sakura-tag-v2.4.1-build2849-ee8234f-Win32-Release-Installer.zip'
$checksum = '3fcc813bbb2a7c51d4b95bd081643c0dc7dedc632cdb396e6ea56e82ebb5315f'

$pp = Get-PackageParameters
$pp | Format-Table | Out-String

$packageArgsZip = @{
    packageName   = $packageName
    url           = $url
    checksum      = $checksum
    checksumType  = 'sha256'
    UnzipLocation = $toolsDir
}

$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
Install-ChocolateyZipPackage @packageArgsZip

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    url            = $url1
    softwareName   = 'Sakura Editor*'
    silentArgs     = $silentArgs
    validExitCodes = @(0)
}
$file = [String](Resolve-Path( Join-Path $toolsDir "*.exe"))
Install-ChocolateyInstallPackage -PackageName $packageName -File $file -SilentArgs $silentArgs





Write-ChocolateySuccess "$packageName"
