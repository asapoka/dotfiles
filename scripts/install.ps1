# PowerShellプロファイルのシンボリックリンクを作成する関数
function install_profile {
    param (
        $path
    )
    if ($IsWindows) {
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
    # 管理者権限でない場合は管理者権限に昇格する
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { 
        Start-Process pwsh.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit 
    }

    $DOT_DIR = Join-Path $env:USERPROFILE dotfiles
    if (Test-Path $DOT_DIR) {
        # dotfilesディレクトリが既に存在する場合は何もしない
    } else {
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
    $DOT_DIR = Join-Path ~ dotfiles

    # dotfilesディレクトリの存在確認
    if (Test-Path $DOT_DIR) {
        # 既に存在する場合は何もしない
    } else {
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

