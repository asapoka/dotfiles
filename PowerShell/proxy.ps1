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