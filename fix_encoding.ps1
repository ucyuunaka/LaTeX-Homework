$content = Get-Content -Path 'build.bat' -Raw -Encoding UTF8
[System.IO.File]::WriteAllText('build_new.bat', $content, [System.Text.Encoding]::GetEncoding(936))
Remove-Item 'build.bat'
Rename-Item 'build_new.bat' 'build.bat'
