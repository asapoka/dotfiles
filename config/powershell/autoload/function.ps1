<#
.SYNOPSIS
    PowerShell カスタム関数定義

.DESCRIPTION
    PowerShell環境で使用するカスタム関数を定義します。
    開発作業やシステム管理を効率化する便利な関数を提供します。

.NOTES
    Author: asapoka
    RequiredVersion: PowerShell Core 6.0+
    RequiredOS: Windows, macOS, Linux
    
    このファイルはMicrosoft.PowerShell_profile.ps1から自動読み込みされます。

.FUNCTIONALITY
    - ファイル操作関数
    - ディレクトリナビゲーション関数
    - 開発作業支援関数
    - システム情報取得関数

.LINK
    https://github.com/asapoka/dotfiles
#>

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

function ll {
    lsd -l
}  
function la {
    lsd -la
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
# PowerShellプロファイル読み込み時間を測定
function Measure-ProfileLoad {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    . $PROFILE
    $stopwatch.Stop()
    Write-Host "Profile loaded in $($stopwatch.ElapsedMilliseconds)ms" -ForegroundColor Green
}

