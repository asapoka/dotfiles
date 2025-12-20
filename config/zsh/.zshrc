#!/usr/bin/env zsh

# =============================================================================
# Zsh設定ファイル - メイン
# =============================================================================
# dotfiles配下の分割された設定ファイルを読み込み管理

# 編集する際の心得：自分で意味分かんないやつコピペすんな
# ログインシェルをzshに変更する: chsh -s /bin/zsh

# dotfiles配下のzsh設定ディレクトリ
ZSH_CONFIG_DIR="$HOME/dotfiles/config/zsh"

# =============================================================================
# 基本設定の読み込み
# =============================================================================

# ヒストリ設定
source "$ZSH_CONFIG_DIR/core/history.zsh"

# zshオプション設定
source "$ZSH_CONFIG_DIR/core/options.zsh"

# プロンプト設定（フォールバック用）
source "$ZSH_CONFIG_DIR/core/prompt.zsh"

# =============================================================================
# エイリアス設定の読み込み
# =============================================================================

# 一般的なエイリアス
source "$ZSH_CONFIG_DIR/aliases/general.zsh"

# 便利関数エイリアス
source "$ZSH_CONFIG_DIR/aliases/function.zsh"

# 安全性向上エイリアス
source "$ZSH_CONFIG_DIR/aliases/safety.zsh"

# ディレクトリ移動エイリアス
source "$ZSH_CONFIG_DIR/aliases/navigation.zsh"

# モダンツールエイリアス
source "$ZSH_CONFIG_DIR/aliases/tools.zsh"

# =============================================================================
# 環境設定の読み込み
# =============================================================================

# PATH設定・Homebrew初期化
source "$ZSH_CONFIG_DIR/env/paths.zsh"

# =============================================================================
# 外部ツール初期化
# =============================================================================

# Starshipプロンプト初期化
source "$ZSH_CONFIG_DIR/init/starship.zsh"

# Sheldonプラグインマネージャー初期化
source "$ZSH_CONFIG_DIR/init/sheldon.zsh"

eval "$(mise activate zsh)"