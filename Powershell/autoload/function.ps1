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

function ESTURAN {
    Get-WinEvent -FilterHashtable @{LogName = "System"; Id = (7001, 7002); ProviderName = "Microsoft-Windows-Winlogon" } | Select-Object TimeCreated | Sort-Object TimeCreated | Group-Object { $_.TimeCreated.ToString("yyyy-MM-dd") } | Select-Object @{name = "Date"; expression = { $_.Name } }, @{name = "LogOn"; expression = { $_.Group[0].TimeCreated.ToString("HH:mm") } }, @{name = "LogOff"; expression = { $_.Group[$_.Group.Count - 1].TimeCreated.ToString("HH:mm") } }
}