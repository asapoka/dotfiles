# PowerShel Core でなければ終了
if ( $PSVersionTable.PSEdition -ne 'Core') {
    exit
}
# 読み込みたいps1スクリプトの保存場所
# TODO 固定パスなのをどうにかしたい
#Windows
if ($IsWindows) {
    $psdir = Join-Path $env:USERPROFILE dotfiles PowerShell autoload
} else {
    # other os
    $psdir = Join-Path $HOME dotfiles Powershell autoload
}
# 保存場所にある全てのps1スクリプトを読み込む
Get-ChildItem "${psdir}\*.ps1" | ForEach-Object { .$_ }

# Ctrl + f で入力補完を確定、次の候補を選択
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptNextSuggestionWord

# 重複した履歴を保存しないようにする
Set-PSReadlineOption -HistoryNoDuplicates

# fzf の設定
# Ctrl + r でfzfの履歴検索
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
# Ctrl + t でfzfのファイル検索
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'


# starship を有効化
Invoke-Expression (&starship init powershell)