$releases = "http://hide.maruo.co.jp/software/hidemaru.html"

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $sjis = (New-Object IO.StreamReader($download_page.RawContentStream, [System.Text.Encoding]::GetEncoding("Shift_JIS"))).ReadToEnd()
    
    $verregex = [regex]'<TD align="center" nowrap>Ver(.*?)</TD>'
    
    $version = ($verregex.Match( $sjis ).Groups[1]).ToString()
    $filever = $version.Replace(".", "")
    
    return @{ 
        Version         = $version;
        URL32           = "http://hide.maruo.co.jp/software/bin3/hm${filever}_signed.exe"
        URL32E          = "http://hide.maruo.co.jp/software/bin3/maruo${filever}_signed.exe"
        URL32F          = "http://hide.maruo.co.jp/software/bin3/hmfloat${filever}_signed.exe"
        URL64           = "http://hide.maruo.co.jp/software/bin3/hm${filever}_x64_signed.exe"
        URL64E          = "http://hide.maruo.co.jp/software/bin3/maruo${filever}_x64_signed.exe"
        URL64F          = "http://hide.maruo.co.jp/software/bin3/hmfloat${filever}_x64_signed.exe"
        ChecksumType32  = 'sha256'
        ChecksumType32E = 'sha256'
        ChecksumType32F = 'sha256'
        ChecksumType64  = 'sha256'
        ChecksumType64E = 'sha256'
        ChecksumType64F = 'sha256'
    }
    
}

function global:au_BeforeUpdate() {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
    $Latest.checksum32E = Get-RemoteChecksum $Latest.URL32E
    $Latest.Checksum32F = Get-RemoteChecksum $Latest.URL32F
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
    $Latest.Checksum64E = Get-RemoteChecksum $Latest.URL64E
    $Latest.Checksum64F = Get-RemoteChecksum $Latest.URL64F
}


function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^\s*'url32'\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"           #1
            "(^\s*'checksum32'\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"      #2
            "(^\s*'url32e'\s*=\s*)('.*')"      = "`$1'$($Latest.URL32E)'"           #1
            "(^\s*'checksum32e'\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32E)'"      #2
            "(^\s*'url32f'\s*=\s*)('.*')"      = "`$1'$($Latest.URL32F)'"           #1
            "(^\s*'checksum32f'\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32F)'"      #2
            "(^\s*'url64'\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"           #1
            "(^\s*'checksum64'\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"      #2
            "(^\s*'url64e'\s*=\s*)('.*')"      = "`$1'$($Latest.URL64E)'"           #1
            "(^\s*'checksum64e'\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64E)'"      #2
            "(^\s*'url64f'\s*=\s*)('.*')"      = "`$1'$($Latest.URL64F)'"           #1
            "(^\s*'checksum64f'\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64F)'"      #2
        }
    }
}


update -ChecksumFor none