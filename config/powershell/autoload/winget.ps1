<#
.SYNOPSIS
    winget パッケージマネージャー関連関数

.DESCRIPTION
    Windowsのwingetパッケージマネージャーを便利に使用するための関数群です。
    パッケージの検索、インストール、更新を効率化します。

.NOTES
    Author: asapoka
    RequiredVersion: PowerShell Core 6.0+
    RequiredOS: Windows
    
    このファイルはMicrosoft.PowerShell_profile.ps1から自動読み込みされます。
    wingetコマンドが利用可能である必要があります。

.FUNCTIONALITY
    - winget検索関数
    - wingetインストール関数
    - winget更新関数
    - winget情報表示関数

.LINK
    https://github.com/asapoka/dotfiles
#>

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}