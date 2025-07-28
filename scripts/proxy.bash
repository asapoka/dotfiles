#!/usr/bin/env bash

# プロキシ設定スクリプト
# wget, curl, git, zsh, bash用のプロキシ設定を行います

set -euo pipefail

# カラー出力関数の読み込み
if [ -f "$(dirname "$0")/../lib/colors.bash" ]; then
    source "$(dirname "$0")/../lib/colors.bash"
else
    # カラー出力が利用できない場合の代替関数
    info() { echo "[INFO] $*"; }
    error() { echo "[ERROR] $*" >&2; }
    success() { echo "[SUCCESS] $*"; }
    title() { echo "=== $* ==="; }
fi

# プロキシ設定関数
set_proxy() {
    local proxy_url="$1"
    local proxy_user="$2"
    local proxy_pass="$3"
    
    if [ -z "$proxy_url" ]; then
        error "プロキシURLが指定されていません"
        return 1
    fi
    
    # ユーザー名とパスワードが指定されている場合、URLに組み込む
    if [ -n "$proxy_user" ] && [ -n "$proxy_pass" ]; then
        # URLからプロトコル部分を抽出
        if [[ "$proxy_url" =~ ^(https?://) ]]; then
            local protocol="${BASH_REMATCH[1]}"
            local host_port="${proxy_url#$protocol}"
            proxy_url="${protocol}${proxy_user}:${proxy_pass}@${host_port}"
        else
            error "無効なプロキシURL形式です"
            return 1
        fi
    fi
    
    title "プロキシ設定を適用中"
    info "プロキシURL: $(echo "$proxy_url" | sed 's/:[^:@]*@/:***@/')"  # パスワードを隠して表示
    
    # 環境変数の設定
    export http_proxy="$proxy_url"
    export https_proxy="$proxy_url"
    export ftp_proxy="$proxy_url"
    export HTTP_PROXY="$proxy_url"
    export HTTPS_PROXY="$proxy_url"
    export FTP_PROXY="$proxy_url"
    
    # Git のプロキシ設定
    if command -v git >/dev/null 2>&1; then
        info "Gitのプロキシ設定を更新中..."
        git config --global http.proxy "$proxy_url"
        git config --global https.proxy "$proxy_url"
        success "Gitのプロキシ設定完了"
    fi
    
    # curl のプロキシ設定（~/.curlrc）
    if command -v curl >/dev/null 2>&1; then
        info "curlのプロキシ設定を更新中..."
        # 既存設定があれば更新、なければ新規作成
        if [ -f "$HOME/.curlrc" ]; then
            # 既存のproxy設定行を削除してから追加
            grep -v "^proxy = " "$HOME/.curlrc" > "$HOME/.curlrc.tmp" 2>/dev/null || touch "$HOME/.curlrc.tmp"
            echo "proxy = $proxy_url" >> "$HOME/.curlrc.tmp"
            mv "$HOME/.curlrc.tmp" "$HOME/.curlrc"
        else
            echo "proxy = $proxy_url" > "$HOME/.curlrc"
        fi
        success "curlのプロキシ設定完了"
    fi
    
    # wget のプロキシ設定（~/.wgetrc）
    if command -v wget >/dev/null 2>&1; then
        info "wgetのプロキシ設定を更新中..."
        # 既存設定があれば更新、なければ新規作成
        if [ -f "$HOME/.wgetrc" ]; then
            # 既存のプロキシ設定行を削除
            grep -v -E "^(http_proxy|https_proxy|ftp_proxy|use_proxy) = " "$HOME/.wgetrc" > "$HOME/.wgetrc.tmp" 2>/dev/null || touch "$HOME/.wgetrc.tmp"
            # 新しいプロキシ設定を追加
            cat >> "$HOME/.wgetrc.tmp" << EOF
http_proxy = $proxy_url
https_proxy = $proxy_url
ftp_proxy = $proxy_url
use_proxy = on
EOF
            mv "$HOME/.wgetrc.tmp" "$HOME/.wgetrc"
        else
            cat > "$HOME/.wgetrc" << EOF
http_proxy = $proxy_url
https_proxy = $proxy_url
ftp_proxy = $proxy_url
use_proxy = on
EOF
        fi
        success "wgetのプロキシ設定完了"
    fi
    
    # シェル設定ファイルへの追加
    update_shell_configs "$proxy_url"
    
    success "プロキシ設定が完了しました"
}

# プロキシ設定解除関数
unset_proxy() {
    title "プロキシ設定を解除中"
    
    # 環境変数の削除
    unset http_proxy https_proxy ftp_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY
    
    # Git のプロキシ設定削除
    if command -v git >/dev/null 2>&1; then
        info "Gitのプロキシ設定を削除中..."
        git config --global --unset http.proxy 2>/dev/null || true
        git config --global --unset https.proxy 2>/dev/null || true
        success "Gitのプロキシ設定削除完了"
    fi
    
    # curl 設定ファイル削除
    if [ -f "$HOME/.curlrc" ]; then
        info "curlのプロキシ設定を削除中..."
        rm -f "$HOME/.curlrc"
        success "curlのプロキシ設定削除完了"
    fi
    
    # wget 設定ファイル削除
    if [ -f "$HOME/.wgetrc" ]; then
        info "wgetのプロキシ設定を削除中..."
        rm -f "$HOME/.wgetrc"
        success "wgetのプロキシ設定削除完了"
    fi
    
    # シェル設定ファイルからプロキシ設定削除
    remove_shell_configs
    
    success "プロキシ設定の解除が完了しました"
}

# シェル設定ファイルの更新
update_shell_configs() {
    local proxy_url="$1"
    
    info "シェル設定ファイルを更新中..."
    
    # プロキシ設定用の設定内容
    local proxy_config=$(cat << EOF
# プロキシ設定 (自動生成)
export http_proxy="$proxy_url"
export https_proxy="$proxy_url"
export ftp_proxy="$proxy_url"
export HTTP_PROXY="$proxy_url"
export HTTPS_PROXY="$proxy_url"
export FTP_PROXY="$proxy_url"
EOF
)
    
    # .zprofile への追加/更新
    if [ -f "$HOME/.zprofile" ] || [ -f "$HOME/.zshrc" ]; then
        # .zprofileが存在しない場合は作成
        [ ! -f "$HOME/.zprofile" ] && touch "$HOME/.zprofile"
        remove_proxy_config_from_file "$HOME/.zprofile"
        echo "" >> "$HOME/.zprofile"
        echo "$proxy_config" >> "$HOME/.zprofile"
        info ".zprofileのプロキシ設定を更新"
    fi
    
    # .bash_profile への追加/更新
    if [ -f "$HOME/.bash_profile" ] || [ -f "$HOME/.bashrc" ]; then
        # .bash_profileが存在しない場合は作成
        [ ! -f "$HOME/.bash_profile" ] && touch "$HOME/.bash_profile"
        remove_proxy_config_from_file "$HOME/.bash_profile"
        echo "" >> "$HOME/.bash_profile"
        echo "$proxy_config" >> "$HOME/.bash_profile"
        info ".bash_profileのプロキシ設定を更新"
    fi
}

# シェル設定ファイルからプロキシ設定削除
remove_shell_configs() {
    info "シェル設定ファイルからプロキシ設定を削除中..."
    
    for file in "$HOME/.zprofile" "$HOME/.bash_profile"; do
        if [ -f "$file" ]; then
            remove_proxy_config_from_file "$file"
            info "$(basename "$file")からプロキシ設定を削除"
        fi
    done
}

# ファイルからプロキシ設定を削除
remove_proxy_config_from_file() {
    local file="$1"
    if [ -f "$file" ]; then
        # プロキシ設定セクションを削除（更新時の重複を防ぐため）
        if grep -q "# プロキシ設定 (自動生成)" "$file" 2>/dev/null; then
            # プロキシ設定セクションの開始から次の空行または EOF まで削除
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS の場合
                sed -i '' '/# プロキシ設定 (自動生成)/,/^$/d' "$file" 2>/dev/null || true
            else
                # Linux の場合
                sed -i '/# プロキシ設定 (自動生成)/,/^$/d' "$file" 2>/dev/null || true
            fi
        fi
    fi
}

# プロキシ設定状況の確認
check_proxy() {
    title "現在のプロキシ設定状況"
    
    # 環境変数の確認
    echo "環境変数:"
    for var in http_proxy https_proxy ftp_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY; do
        if [ -n "${!var:-}" ]; then
            echo "  $var: ${!var}"
        else
            echo "  $var: (未設定)"
        fi
    done
    
    echo ""
    
    # Git設定の確認
    if command -v git >/dev/null 2>&1; then
        echo "Git設定:"
        echo "  http.proxy: $(git config --global --get http.proxy 2>/dev/null || echo "(未設定)")"
        echo "  https.proxy: $(git config --global --get https.proxy 2>/dev/null || echo "(未設定)")"
    fi
    
    echo ""
    
    # 設定ファイルの確認
    echo "設定ファイル:"
    echo "  ~/.curlrc: $([ -f "$HOME/.curlrc" ] && echo "存在" || echo "存在しない")"
    echo "  ~/.wgetrc: $([ -f "$HOME/.wgetrc" ] && echo "存在" || echo "存在しない")"
}

# ヘルプ表示
show_help() {
    cat << EOF
プロキシ設定スクリプト

使用方法:
  $0 set <プロキシURL> [ユーザー名] [パスワード]  プロキシ設定を適用
  $0 unset                                      プロキシ設定を解除
  $0 check                                      現在のプロキシ設定状況を確認
  $0 help                                       このヘルプを表示

例:
  $0 set http://proxy.example.com:8080
  $0 set http://proxy.example.com:8080 username password
  $0 set http://user:pass@proxy.example.com:8080
  $0 unset
  $0 check

対象ツール:
  - wget
  - curl
  - git
  - bash (.bash_profile)
  - zsh (.zprofile)
EOF
}

# メイン処理
main() {
    case "${1:-}" in
        "set")
            if [ -z "${2:-}" ]; then
                error "プロキシURLを指定してください"
                show_help
                exit 1
            fi
            set_proxy "$2" "$3" "$4"
            ;;
        "unset")
            unset_proxy
            ;;
        "check")
            check_proxy
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            error "無効なコマンドです"
            show_help
            exit 1
            ;;
    esac
}

# スクリプトが直接実行された場合のみメイン処理を実行
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi