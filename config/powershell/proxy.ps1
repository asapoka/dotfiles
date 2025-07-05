<#
.SYNOPSIS
    プロキシ設定とユーティリティ関数

.DESCRIPTION
    企業環境でのプロキシ設定と便利なユーティリティ関数を提供します。
    主にWindows環境での開発作業を支援します。

.NOTES
    Author: asapoka
    RequiredVersion: PowerShell Core 6.0+
    RequiredOS: Windows (主にWindows環境向け)
    
    企業ネットワーク環境での使用を想定しています。

.FUNCTIONALITY
    - プロキシ設定関数
    - Windows環境向けユーティリティ関数

.LINK
    https://github.com/asapoka/dotfiles
#>

if ($env:http_proxy) {
    # プロキシURLからユーザー名などを抽出する正規表現
    $regex = "^(.*?):(.*?)@(.*?):(\d+)$"

    # 正規表現でマッチ
    $match = $env:http_proxy | Select-String -Pattern $regex

    if ($match) {
        # キャプチャグループから情報を抽出
        $proxyUser = $match.Matches.Groups[1].Value
        $proxyPassword = $match.Matches.Groups[2].Value
        $proxyhost = $match.Matches.Groups[3].Value
        $proxyPort = [int]$match.Matches.Groups[4].Value
    }
    # 環境変数
    $proxyAddressWithAuthenticattion = "http://$($proxyUser):$($proxyPassword)@$($proxyhost):$($proxyPort)"
    $env:https_proxy = $proxyAddressWithAuthenticattion
    $env:ftp_proxy = $proxyAddressWithAuthenticattion

    # クレデンシャル設定
    $passwordSecure = ConvertTo-SecureString $proxyPassword -AsPlainText -Force
    $creds = New-Object System.Management.Automation.PSCredential $proxyUser, $passwordSecure
    $proxy = New-Object System.Net.WebProxy "http://$($proxyhost)/"
    $proxy.Credentials = $creds
    [System.Net.WebRequest]::DefaultWebProxy = $proxy

}