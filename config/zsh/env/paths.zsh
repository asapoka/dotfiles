#!/usr/bin/env zsh

# =============================================================================
# 環境変数・PATH設定
# =============================================================================
# OS別のPATH設定とHomebrew環境の初期化

# Homebrewの環境設定（OS別）
case "${OSTYPE}" in
  darwin*)
    # macOS: Apple Silicon/Intel対応のHomebrew
    if [[ -f /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    ;;
  linux*)
    # Linux: Linuxbrew
    if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    ;;
esac