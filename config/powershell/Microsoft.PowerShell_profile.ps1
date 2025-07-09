<#
.SYNOPSIS
    PowerShell Coreプロファイル設定ファイル

.DESCRIPTION
    PowerShell Coreの個人用プロファイル設定です。
    autoloadディレクトリから関数、エイリアス、winget設定を自動読み込みし、
    Starship、PSfzf、PSReadLineの設定を行います。

.NOTES
    Author: asapoka
    RequiredVersion: PowerShell Core 6.0+
    RequiredOS: Windows, macOS, Linux
    
    このファイルはPowerShell起動時に自動的に読み込まれます。
    Starship、Sheldon、PSfzfモジュールが必要です。

.FUNCTIONALITY
    - PowerShell Coreバージョンチェック
    - autoloadディレクトリからスクリプトの自動読み込み
    - PSReadLineキーバインド設定
    - PSfzf統合設定
    - Starshipプロンプト初期化

.LINK
    https://github.com/asapoka/dotfiles
#>

# PowerShell Core でなければ終了
if ( $PSVersionTable.PSEdition -ne 'Core') {
    exit
}
# 読み込みたいps1スクリプトの保存場所
if ($IsWindows) {
    $psdir = Join-Path $env:USERPROFILE dotfiles config powershell autoload
} else {
    # other os
    $psdir = Join-Path $HOME dotfiles config powershell autoload
}

# 共通スクリプトの読み込み（高速化のため直接指定）
$commonScripts = @(
    (Join-Path $psdir "alias.ps1"),
    (Join-Path $psdir "function.ps1"),
    (Join-Path $psdir "lazy.ps1")
)

# OS固有スクリプトの条件付き読み込み
if ($IsWindows) {
    $commonScripts += (Join-Path $psdir "winget.ps1")
}

# 存在するスクリプトのみを読み込み
foreach ($script in $commonScripts) {
    if (Test-Path $script) {
        . $script
    }
}

# PSReadLine設定の最適化
if (Get-Module -ListAvailable -Name PSReadLine) {
    # 重複した履歴を保存しないようにする
    Set-PSReadlineOption -HistoryNoDuplicates
    
    # Ctrl + f で入力補完を確定、次の候補を選択
    Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptSuggestion
    Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptNextSuggestionWord
}

# PSfzf設定の最適化（モジュールが利用可能な場合のみ）
if (Get-Module -ListAvailable -Name PSfzf) {
    # Ctrl + r でfzfの履歴検索
    Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
    # Ctrl + t でfzfのファイル検索
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
    # TabでPSFzf補完
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
}

# starship を有効化（コマンドが利用可能な場合のみ）
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}