if($env:http_proxy){

    # 個別の認証情報
$proxyUser = "<USERNAME>"
$proxyPassword = "<PASSWORD>"
$proxyhost = "<HOSTNAME>:<PORTNUMBER>"

# 環境変数
$proxyAddressWithAuthenticattion = "http://$($proxyUser):$($proxy$password)@$($proxyhost)"
$env:http_proxy = $proxyAddressWithAuthenticattion
$env:https_proxy = $proxyAddressWithAuthenticattion
$env:ftp_proxy = $proxyAddressWithAuthenticattion

# クレデンシャル設定
$passwordSecure = ConvertTo-SecureString $proxyPassword -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential $proxyUser, $passwordSecure
$proxy = New-Object System.Net.WebProxy "http://$($proxyhost)/"
$proxy.Credentials = $creds
[System.Net.WebRequest]::DefaultWebProxy = $proxy

}