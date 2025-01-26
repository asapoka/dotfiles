# シンボリックリンクを作成する関数
function install_profile {
    param (
        $path
    )
    if ($IsWindows) {
        $DOT_DIR = Join-Path $env:USERPROFILE dotfiles
    } elseif ($IsMacOS -or $IsLinux) {
        $DOT_DIR = Join-Path ~ dotfiles
    }
    New-Item -Path $path -ItemType SymbolicLink -Value (Get-Item (Join-Path $DOT_DIR PowerShell "Microsoft.PowerShell_profile.ps1")).FullName -Force
}
# コマンドがインストールされていなければwingetでインストールする関数
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
# Powershell-Moduleがインストールされてなければインストールする関数
function check_installedModule {
    param (
        $name
    )
    Get-InstalledModule $name | Out-Null
    if ($? -eq $false) {
        Write-Host Installing... $command
        Install-Module $name
    } 
}
# PowerShel Core でなければ終了
if ( $PSVersionTable.PSEdition -ne 'Core') {
    exit
}

# インストール処理
# windows
if ($IsWindows) {
    $DOT_DIR = Join-Path $env:USERPROFILE dotfiles
    if (Test-Path $DOT_DIR) {
        # dotfilesの存在チェック
    } else {
        # 無い場合は取得する
        #git がある場合
        if (Get-Command git -ea SilentlyContinue) { 
            git clone https://github.com/asapoka/dotfiles.git $DOT_DIR
        }
    }
    $pwsh = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.PowerShell_profile.ps1
    $vscode = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.VSCode_profile.ps1
    $ps = Join-Path  $env:USERPROFILE \Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 #古いpsは使わないから不要かも

    install_profile($pwsh)
    install_profile($vscode)
    install_profile($ps)

    $starship = Join-Path $env:USERPROFILE .config starship.toml
    if (Test-Path (Join-Path $env:USERPROFILE .config)) {
        New-Item -Path $starship -ItemType SymbolicLink -Value (Get-Item "..\starship.toml").FullName -Force
    } else {
        New-Item -Path (Join-Path $env:USERPROFILE .config) -ItemType Directory
        New-Item -Path $starship -ItemType SymbolicLink -Value (Get-Item "..\starship.toml").FullName -Force
    }
    check_command fzf junegunn.fzf 
    check_command lsd lsd-rs.lsd
    check_command starship Starship.Starship
    check_installedModule PSfzf
} elseif ($IsMacOS -or $IsLinux) {
    $DOT_DIR = Join-Path ~ dotfiles
    $vscode = Join-Path ~ .config PowerShel Microsoft.VSCode_profile.ps1

    if (Test-Path $DOT_DIR) {
    } else {
        # 無い場合は取得する
        #git がある場合
        if (Get-Command git -ea SilentlyContinue) { 
            git clone https://github.com/asapoka/dotfiles.git $DOT_DIR
        }
    }
    install_profile($PROFILE)
    install_profile($vscode)
    check_installedModule PSfzf
}

