# New-Item -Type SymbolicLink $PROFILE -Value Microsoft.PowerShell_profile.ps1
Set-Alias touch New-Item
Set-Alias ls eza
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

Invoke-Expression (&starship init powershell)
function ls {
    eza --icons --git
}  
function ll {
    eza --icons --git -l
}  
function lt {
    eza -T -L 3 -a -I "node_modules|.git|.cache" --icons
}
function ltl {
    eza -T -L 3 -a -I "node_modules|.git|.cache" -l --icons
}
    