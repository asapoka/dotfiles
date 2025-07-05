#!/usr/bin/env bash

###############################################################################
# Finder                                                                      #
###############################################################################

# Finderで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles YES

# 新しいFinderウィンドウでデフォルトでホームフォルダを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Finderでステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true

# Finderでパスバーを表示
defaults write com.apple.finder ShowPathbar -bool true

# Finderでタブバーを表示
defaults write com.apple.finder ShowTabView -bool true

# ~/Libraryディレクトリを表示（デフォルトは非表示）
chflags nohidden ~/Library

# 不可視ファイルを表示
defaults write com.apple.finder AppleShowAllFiles YES

# Finder を CMD Q で閉じる
defaults write com.apple.finder QuitMenuItem -bool true

killall Finder

###############################################################################
# Dock                                                                        #
###############################################################################

# Dockを自動的に隠す
defaults write com.apple.dock autohide -bool true
# Dock のアイコンサイズ
defaults write com.apple.dock tilesize -int 50

# Dock の拡大機能を入にする
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock persistent-apps -array

# ホットコーナー
# 設定可能な値:
#  0: 何もしない
#  2: Mission Control
#  3: アプリケーションウィンドウを表示
#  4: デスクトップ
#  5: スクリーンセーバー開始
#  6: スクリーンセーバー無効
#  7: Dashboard
# 10: ディスプレイをスリープ
# 11: Launchpad
# 12: 通知センター
# 13: 画面をロック
# 右上角 → デスクトップ
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# 左下角 → スクリーンセーバー開始
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# 上記設定後は、Finder と Dock を再起動する

killall Dock

###############################################################################
# General                                                                        #
###############################################################################

# スクロール方向を設定
defaults write -g com.apple.swipescrolldirection -bool false

# ネットワークドライブに .DS_Storeを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# リモートログイン を オン
systemsetup -setremotelogin on

# 未確認のアプリケーションを実行する際のダイアログを無効にする
defaults write com.apple.LaunchServices LSQuarantine -bool false

# スクリーンショットをPNG形式で保存
defaults write com.apple.screencapture type -string "png"

# 自動アップデートチェックを有効にする
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# ソフトウェアアップデートを週1回ではなく毎日チェック
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# 利用可能なアップデートをバックグラウンドでダウンロード
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# システムデータファイルとセキュリティアップデートをインストール
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# アプリの自動アップデートを有効にする
defaults write com.apple.commerce AutoUpdate -bool true

# macOSアップデート時にApp Storeが再起動を実行することを許可
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
