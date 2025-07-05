#!/usr/bin/env bash

###############################################################################
# Finder                                                                      #
###############################################################################

# Finderで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles YES

# Set `${HOME}` as the default location for new Finder windows
# 新しいウィンドウでデフォルトでホームフォルダを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Show Status bar in Finder （ステータスバーを表示）
defaults write com.apple.finder ShowStatusBar -bool true

# Show Path bar in Finder （パスバーを表示）
defaults write com.apple.finder ShowPathbar -bool true

# Show Tab bar in Finder （タブバーを表示）
defaults write com.apple.finder ShowTabView -bool true

# Show the ~/Library directory （ライブラリディレクトリを表示、デフォルトは非表示）
chflags nohidden ~/Library

# Show the hidden files （不可視ファイルを表示）
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

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
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

# Save screenshots as PNGs （スクリーンショット保存形式をPNGにする）
defaults write com.apple.screencapture type -string "png"

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
