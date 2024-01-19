function install_profile {
    param (
        $path
    )
    New-Item -Path $path -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName -Force
}

$pwsh = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.PowerShell_profile.ps1
$vscode = Join-Path $env:USERPROFILE \Documents\PowerShell\Microsoft.VSCode_profile.ps1
$ps = Join-Path  $env:USERPROFILE \Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 

install_profile($pwsh)
install_profile($vscode)
install_profile($ps)

$starship = Join-Path $env:USERPROFILE .config starship.toml
if (Test-Path (Join-Path $env:USERPROFILE .config)) {
    New-Item -Path $starship -ItemType SymbolicLink -Value (Get-Item "..\zsh\.config\starship.toml").FullName -Force
} else {
    New-Item -Path (Join-Path $env:USERPROFILE .config) -ItemType Directory
    New-Item -Path $starship -ItemType SymbolicLink -Value (Get-Item "..\zsh\.config\starship.toml").FullName -Force
}