# シンボリックリンクを作成する関数
function install_profile {
    param (
        $path
    )
    New-Item -Path $path -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName -Force
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
# スクリプトのあるディレクトリへ移動
Set-Location $PSScriptRoot
$pwsh = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.PowerShell_profile.ps1
$vscode = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.VSCode_profile.ps1
$ps = Join-Path  $env:USERPROFILE \Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 

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
check_command eza eza-community.eza
check_command starship Starship.Starship
check_installedModule PSFzf