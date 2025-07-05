#!/usr/bin/env zsh

# =============================================================================
# zshオプション設定
# =============================================================================
# zshの動作を制御するオプションの設定

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# フローコントロール（Ctrl+S, Ctrl+Q）を無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う（対話モードでも）
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# コマンドのスペルミスを自動修正しない
setopt nocorrect

# ビープ音を鳴らさない
setopt no_beep