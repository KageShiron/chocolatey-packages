$installPath = Join-Path (Get-ToolsLocation) $packageName
$installFile = Join-Path $installPath "ffftp.exe"
remove-item -Recurse -Force $installPath
Uninstall-BinFile -Name "ffftp" $installFile