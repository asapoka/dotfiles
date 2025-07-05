<#
.SYNOPSIS
    PowerShellエイリアス定義

.DESCRIPTION
    PowerShell環境で使用する便利なエイリアスを定義します。
    よく使用するコマンドの短縮形や、Unix風のコマンドエイリアスを提供します。

.NOTES
    Author: asapoka
    RequiredVersion: PowerShell Core 6.0+
    RequiredOS: Windows, macOS, Linux
    
    このファイルはMicrosoft.PowerShell_profile.ps1から自動読み込みされます。

.FUNCTIONALITY
    - よく使用するコマンドの短縮エイリアス
    - Unix風コマンドエイリアス
    - 開発作業効率化エイリアス

.LINK
    https://github.com/asapoka/dotfiles
#>

Set-Alias touch New-Item
Set-Alias ls lsd