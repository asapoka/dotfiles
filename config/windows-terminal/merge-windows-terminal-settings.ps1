# パス定義
$src = Join-Path $PSScriptRoot 'settings.json'
$dest = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
$backup = "$dest.bak_$(Get-Date -Format yyyyMMddHHmmss)"
$tmp = "$dest.tmp"
Copy-Item $dest $backup -Force

jq -e '.' "$src";
jq -e '.' "$dest";

jq -s '.[0] * .[1]' "$dest" "$src" > $tmp
Move-Item $tmp $dest -Force