# dotfiles

クロスプラットフォーム対応の開発環境自動構築用dotfilesリポジトリです。Linux、macOS、Windows環境で動作し、シンボリックリンクを使用して設定ファイルを配置し、モダンなCLIツールをインストールして開発効率を向上させます。

## インストール

### Unix/Linux/macOS

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/asapoka/dotfiles/master/scripts/install.bash)"
```

### Windows

```powershell
iwr "https://raw.githubusercontent.com/asapoka/dotfiles/refs/heads/master/scripts/install.ps1" | iex
```

### フォントのインストール (macOS)

```bash
brew install font-hackgen-nerd
```

## ディレクトリ構成

- `home/` - ホームディレクトリ用設定ファイル
  - `.zshrc` - エイリアスとプラグイン設定を含むZsh設定
  - `.gitconfig` - Git設定
  - `.ripgreprc` - Ripgrep検索設定
- `config/` - ~/.config ディレクトリ用設定ファイル
  - `starship.toml` - Starshipプロンプト設定
  - `alacritty/alacritty.toml` - Alacrittyターミナル設定
  - `sheldon/plugins.toml` - Zshプラグインマネージャー設定
  - `nvim/` - Neovim設定（Kickstart.nvimベース）
  - `powershell/` - PowerShell設定とモジュール
- `scripts/` - インストールと設定スクリプト
  - `install.bash` - メインUnix/Linuxインストールスクリプト
  - `install.ps1` - Windows PowerShellインストールスクリプト
  - `macos.bash` - macOS固有のシステム設定
- `lib/colors.bash` - bashスクリプト用カラー出力関数

## 主要技術

- **シェル**: ZshとStarshipプロンプト、Sheldonプラグインマネージャー
- **エディタ**: Kickstart.nvim設定のNeovim
- **ターミナル**: カスタムテーマのAlacritty
- **パッケージマネージャー**: Homebrew (Unix/macOS)、winget (Windows)
- **フォント**: HackGen Console NF (Nerd Font)

## インストールされるツール

インストールスクリプトでインストールされるコアツール：

- `sheldon` - 高速シェルプラグインマネージャー
- `starship` - クロスシェルプロンプト
- `lsd` - モダンなls代替
- `fzf` - ファジーファインダー
- `bat` - 拡張catコマンド
- `fd` - モダンなfind代替
- `ripgrep` - 高速grep代替

## アーキテクチャ

- `$HOME/dotfiles`からのシンボリンクを使用した設定配置
- OS固有ロジックによるクロスプラットフォーム対応
- 分離された設定ディレクトリによるモジュラー設計
- Windows用PowerShell自動読み込みシステム
- 配置前の既存設定のバックアップ
- `$OSTYPE`とPowerShell組み込み変数によるプラットフォーム検出

## 使用フォント

[yuru7/HackGen](https://github.com/yuru7/HackGen/releases)

```
HackGen Console NF
```
