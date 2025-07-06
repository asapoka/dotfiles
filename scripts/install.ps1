<#
.SYNOPSIS
    dotfiles PowerShell環境の自動セットアップスクリプト

.DESCRIPTION
    Windows/macOS/Linux用のPowerShell開発環境を自動的にセットアップします。
    dotfilesリポジトリのクローン、PowerShellプロファイルの設定、
    必要なコマンドラインツールのインストールを行います。

.PARAMETER None
    このスクリプトはパラメータを受け取りません。

.EXAMPLE
    .\install.ps1
    ローカルファイルとして実行

.EXAMPLE
    iwr "https://raw.githubusercontent.com/asapoka/dotfiles/refs/heads/master/scripts/install.ps1" | iex
    リモートから直接実行

.NOTES
    Author: asapoka
    Created: 2024
    RequiredVersion: PowerShell Core 6.0+
    RequiredOS: Windows, macOS, Linux
    
    Windows環境では管理者権限が必要です。
    gitコマンドが利用可能である必要があります。

.FUNCTIONALITY
    - dotfilesリポジトリの自動クローン
    - PowerShellプロファイルのシンボリックリンク作成
    - Starshipプロンプトの設定
    - 必要なコマンドラインツールの自動インストール（fzf, lsd, starship, ripgrep）
    - PowerShellモジュールの自動インストール（PSfzf）

.LINK
    https://github.com/asapoka/dotfiles
#>

# PowerShellプロファイルのシンボリックリンクを作成する関数
function install_profile {
    param (
        $path
    )
    # CI環境での DOT_DIR の設定
    if ($env:DOT_DIR) {
        $DOT_DIR = $env:DOT_DIR
    } elseif ($IsWindows) {
        $DOT_DIR = Join-Path $env:USERPROFILE dotfiles
    } elseif ($IsMacOS -or $IsLinux) {
        $DOT_DIR = Join-Path ~ dotfiles
    }
    New-Item -Path $path -ItemType SymbolicLink -Value (Get-Item (Join-Path $DOT_DIR config powershell "Microsoft.PowerShell_profile.ps1")).FullName -Force
}
# コマンドがインストールされていない場合はwingetでインストールする関数
function check_command {
    param (
        $command , $id
    )
    Get-Command $command -ea SilentlyContinue | Out-Null
    if ($? -eq $false) {
        Write-Host Installing... $command
        winget install --id $id --accept-package-agreements
    } 
}
# PowerShellモジュールがインストールされていない場合はインストールする関数
function check_installedModule {
    param (
        $name
    )
    Get-InstalledModule $name | Out-Null
    if ($? -eq $false) {
        Write-Host Installing... $name
        Install-Module $name
    } 
}
# PowerShell Core でない場合は終了
if ( $PSVersionTable.PSEdition -ne 'Core') {
    exit
}

# メインのインストール処理
# Windows環境の場合
if ($IsWindows) {
    # 管理者権限でない場合は管理者権限に昇格する（CI環境では無効）
    if (-not $env:CI -and !([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { 
        Start-Process pwsh.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit 
    }

    # CI環境での DOT_DIR の設定
    if ($env:DOT_DIR) {
        $DOT_DIR = $env:DOT_DIR
    } else {
        $DOT_DIR = Join-Path $env:USERPROFILE dotfiles
    }
    
    # CI環境ではリポジトリクローンをスキップ
    if (-not $env:CI -and -not (Test-Path $DOT_DIR)) {
        # dotfilesが存在しない場合はリポジトリをクローンする
        # gitコマンドが利用可能な場合
        if (Get-Command git -ea SilentlyContinue) { 
            git clone https://github.com/asapoka/dotfiles.git $DOT_DIR
        } else {
            Write-Output "gitコマンドが必要です！"
            exit 1
        }
    }

    # PowerShellプロファイルのパス設定
    $pwsh = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.PowerShell_profile.ps1   # PowerShell Core用
    $vscode = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.VSCode_profile.ps1     # VS Code用

    # PowerShellプロファイルのシンボリックリンクを作成
    install_profile($pwsh)
    install_profile($vscode)

    # Starshipプロンプトの設定ファイルをシンボリックリンク
    $starship = Join-Path $env:USERPROFILE .config starship.toml
    # .configディレクトリが存在しない場合は作成
    if (Test-Path (Join-Path $env:USERPROFILE .config)) {
        New-Item -Path $starship -ItemType SymbolicLink -Value (Get-Item (Join-Path $DOT_DIR config "starship.toml")).FullName -Force
    } else {
        New-Item -Path (Join-Path $env:USERPROFILE .config) -ItemType Directory
        New-Item -Path $starship -ItemType SymbolicLink -Value (Get-Item (Join-Path $DOT_DIR config "starship.toml")).FullName -Force
    }
    # 必要なコマンドラインツールをインストール
    check_command fzf junegunn.fzf 
    check_command lsd lsd-rs.lsd
    check_command starship Starship.Starship
    check_command rg BurntSushi.ripgrep
    
    # PowerShellモジュールをインストール
    check_installedModule PSfzf
} elseif ($IsMacOS -or $IsLinux) {
    # macOS/Linux環境の場合
    # CI環境での DOT_DIR の設定
    if ($env:DOT_DIR) {
        $DOT_DIR = $env:DOT_DIR
    } else {
        $DOT_DIR = Join-Path ~ dotfiles
    }

    # CI環境ではリポジトリクローンをスキップ
    if (-not $env:CI -and -not (Test-Path $DOT_DIR)) {
        # dotfilesが存在しない場合はリポジトリをクローンする
        if (Get-Command git -ea SilentlyContinue) { 
            git clone https://github.com/asapoka/dotfiles.git $DOT_DIR
        }
    }

    # VS Code用PowerShellプロファイルのパス設定
    $vscode = Join-Path ~ .config PowerShell Microsoft.VSCode_profile.ps1

    # PowerShellプロファイルのシンボリックリンクを作成
    install_profile($PROFILE)
    install_profile($vscode)
    
    # PowerShellモジュールをインストール
    check_installedModule PSfzf
}

