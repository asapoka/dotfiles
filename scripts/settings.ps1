# Windows 11 設定

# Windows OS でのみ実行
if ($IsWindows -or $PSVersionTable.Platform -eq "Win32NT" -or [Environment]::OSVersion.Platform -eq "Win32NT") {
    Write-Host "Windows 設定を適用中..." -ForegroundColor Green
    
    # 拡張子を表示
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
    
    # 隠しファイルを表示
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    
    # システムファイルを表示
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1
    
    # テレメトリー無効化
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
    
    # フォルダーサイズを表示（詳細表示で）
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "FolderContentsInfoTip" -Value 1
    
    # クイックアクセスを無効化（頻繁に使用するフォルダーを表示しない）
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0
    
    # 共有ウィザードを無効化
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Value 0
    
    # 完全パスをタイトルバーに表示
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 1
    
    Write-Host "Windows 設定の適用が完了しました。" -ForegroundColor Green
} else {
    Write-Host "Windows 以外の OS のため、設定をスキップしました。" -ForegroundColor Yellow
}