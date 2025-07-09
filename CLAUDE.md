# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリでコードを操作する際のガイダンスを提供します。

## 概要

このリポジトリは、Linux、macOS、Windows 向けの自動化された開発環境構築を提供するクロスプラットフォーム dotfiles リポジトリです。シンボリンクを使用して設定ファイルを配置し、生産性を向上させるモダンな CLI ツールをインストールします。

## インストールコマンド

**Unix/Linux/macOS:**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/asapoka/dotfiles/master/scripts/install.bash)"
```

**Windows:**

```powershell
iwr "https://raw.githubusercontent.com/asapoka/dotfiles/refs/heads/master/scripts/install.ps1" | iex
```

**フォントインストール (macOS):**

```bash
brew install font-hackgen-nerd
```

**手動フォントインストール (Windows/Linux):**
[HackGen releases](https://github.com/yuru7/HackGen/releases)から HackGen Console NF をダウンロード

## リポジトリ構成

- `home/` - ホームディレクトリ用設定ファイル
  - `.zshrc` - エイリアスとプラグイン設定を含む Zsh 設定
  - `.gitconfig` - Git 設定
  - `.ripgreprc` - Ripgrep 検索設定
- `config/` - ~/.config ディレクトリ用設定ファイル
  - `starship.toml` - Starship プロンプト設定
  - `alacritty/alacritty.toml` - Alacritty ターミナル設定
  - `sheldon/plugins.toml` - Zsh プラグインマネージャー設定
  - `nvim/` - Neovim 設定 (Kickstart.nvim ベース)
  - `powershell/` - PowerShell 設定とモジュール
  - `zsh/` - エイリアス、コア設定、環境、初期化を分離したモジュール化 Zsh 設定
- `scripts/` - インストールと設定スクリプト
  - `install.bash` - メイン Unix/Linux インストールスクリプト
  - `install.ps1` - Windows PowerShell インストールスクリプト
  - `macos.bash` - macOS 固有のシステム設定
- `lib/colors.bash` - bash スクリプト用カラー出力関数

## 主要技術

- **シェル**: Starship プロンプトと sheldon プラグインマネージャーを使用した Zsh
- **エディタ**: Kickstart.nvim 設定を使用した Neovim
- **ターミナル**: カスタムテーマ使用の Alacritty
- **パッケージマネージャー**: Homebrew (Unix/macOS)、winget (Windows)
- **フォント**: HackGen Console NF (Nerd Font)

## インストールされるツール

インストールスクリプトでインストールされるコアツール：

- `sheldon` - 遅延読み込み機能付き高速シェルプラグインマネージャー
- `starship` - カスタムテーマ付きクロスシェルプロンプト
- `lsd` - アイコン付きモダン ls 代替
- `fzf` - シェル統合付きファジーファインダー
- `bat` - シンタックスハイライト付き拡張 cat コマンド
- `fd` - モダンな find 代替
- `ripgrep` - カラーサポート付き高速 grep 代替

**Zsh プラグイン (Sheldon 経由):**

- `zsh-defer` - 高速起動のための遅延プラグイン読み込み
- `fzf-tab` - タブ補完のファジー補完
- `zsh-autosuggestions` - 履歴ベースの自動補完
- `zsh-syntax-highlighting` - コマンド構文ハイライト
- `zsh-autopair` - 自動ブラケットペア

**Windows 追加:**

- `PSfzf` - PowerShell ファジーファインダー統合
- `winget` - Windows パッケージマネージャー統合

## アーキテクチャ注意事項

- `$HOME/dotfiles`からの設定配置にシンボリンクを使用
- OS 固有のロジックを使用したクロスプラットフォーム互換性
- 設定ディレクトリを分離したモジュラー設計
- Windows 用 PowerShell 自動読み込みシステム
- 配置前に既存設定をバックアップ
- `$OSTYPE`および PowerShell 組み込み変数を使用したプラットフォーム検出

**主要設計パターン:**

- **遅延読み込み**: Zsh プラグインは`zsh-defer`を使用して高速シェル起動を実現
- **モジュール化設定**: エイリアス、環境、コア設定を分離したファイル構成
- **テーマシステム**: カスタム Alacritty テーマ (`blood_moon.toml`) と Starship 設定
- **自動補完**: ファジータブ補完でのシェル間 fzf 統合
- **色の一貫性**: git、ripgrep、ターミナル間での統一カラースキーム

## 開発コマンド

**インストール (Unix/Linux/macOS):**

```bash
bash scripts/install.bash
```

**インストール (Windows):**

```powershell
powershell scripts/install.ps1
```

**設定テスト:**

```bash
# zsh設定テスト
zsh -n config/zsh/.zshrc

# PowerShell設定テスト
powershell -NoProfile -Command "& { try { . config/powershell/Microsoft.PowerShell_profile.ps1 } catch { Write-Error $_.Exception.Message } }"
```

**開発ワークフロー:**

```bash
# 変更をローカルでインストールしテスト
bash scripts/install.bash
source ~/.zshrc  # シェル設定を再読み込み

# シンボリンクを確認
ls -la ~ | grep dotfiles
ls -la ~/.config | grep dotfiles
```

## CI/CD とテスト

**GitHub Actions ワークフロー** プッシュ/PR 時の自動テスト：

- **Linux** (`linux.yml`): curl、wget、git、zsh を使用した Ubuntu テスト
- **macOS** (`mac.yml`): Homebrew 依存関係を使用した macOS テスト
- **Windows** (`windows.yml`): winget と PowerShell を使用した Windows テスト

**CI 環境変数:**

- `CI=true` - 対話的プロンプトと特定のインストールをスキップ
- `DOT_DIR` - CI 実行用の現在のディレクトリを指定

**テストコマンド:**

```bash
# 手動テスト (コミット前に実行)
bash scripts/install.bash
powershell scripts/install.ps1

# 設定検証
zsh -n config/zsh/.zshrc
powershell -NoProfile -Command "& { try { . config/powershell/Microsoft.PowerShell_profile.ps1 } catch { Write-Error $_.Exception.Message } }"

# インストール検証
sheldon --version
starship --version
ls -la ~/.config | grep dotfiles
```

## トラブルシューティングコマンド

**シンボリンクのデバッグ:**

```bash
# 全シンボリンクを確認
ls -la ~ | grep dotfiles
ls -la ~/.config | grep dotfiles

# 特定の設定を検証
cat ~/.zshrc | head -10
cat ~/.config/starship.toml | head -10
```

**パフォーマンス診断:**

```bash
# シェル起動時間を測定
time zsh -i -c exit

# プラグイン読み込みを確認
sheldon status
```

**よくある問題:**

- **Windows**: PowerShell の実行ポリシーがスクリプトを許可していることを確認
- **macOS**: ビルドエラーが発生する場合は Xcode コマンドラインツールをインストール
- **Linux**: `curl`、`wget`、`git`、`zsh`がインストールされていることを確認

## 開発注意事項

- インストールスクリプトには安全性チェックと終了条件が含まれている
- リポジトリルートからの絶対パスを全設定で使用
- カラーとメッセージ関数は`lib/colors.bash`に集約
- **ファイル移動**: git 履歴を保持するため`git mv`を使用
- **バックアップ**: インストール時に元の設定が自動的にバックアップされる
- **CI 統合**: 全ワークフローでインストールと設定検証をテスト
