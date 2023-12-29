# New-Item -Type SymbolicLink $PROFILE -Value Microsoft.PowerShell_profile.ps1
Set-Alias touch New-Item
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/hul10.omp.json' | Invoke-Expression
# Ctrl + f で入力補完を確定、次の候補を選択
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptNextSuggestionWord

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