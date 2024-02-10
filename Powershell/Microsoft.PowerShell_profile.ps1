# New-Item -Type SymbolicLink $PROFILE -Value Microsoft.PowerShell_profile.ps1
Set-Alias touch New-Item
Set-Alias ls eza
# Ctrl + f で入力補完を確定、次の候補を選択
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptNextSuggestionWord

# 重複した履歴を保存しないようにする
Set-PSReadlineOption -HistoryNoDuplicates

# 環境変数を表示
function env {
    Get-ChildItem env:    
}

# $PROFILEを編集
function pro {
    . $PROFILE
    code $PROFILE
}

function source {
    . $PROFILE
}

function dot {
    code $env:USERPROFILE/dotfiles
}

function ls {
    eza --icons --git
}  
function ll {
    eza --icons --git -l
}  
function la {
    eza --icons --git -la
}  

function .. {
    Set-Location ..
}

function ... {
    Set-Location ../..
}

function .... {
    Set-Location ../../..
}
# Ctrl + r でfzfの履歴検索
Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    $command = (Get-Content (Get-PSReadlineOption).HistorySavePath)[(Get-Content (Get-PSReadlineOption).HistorySavePath).length..0] | Select-Object -Unique |  Invoke-Fzf -NoSort -Exact
    # プロンプトを表示する
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    # コマンドが空っぽのときは何もしない
    if (!$command) {
        return
    }
    # 結果をプロンプトへ挿入する
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
}

Invoke-Expression (&starship init powershell)