# 設定ファイル集

（主にUnix系システム向けの）設定ファイルを管理する。  
環境依存のファイルがある場合は`txt`ファイルで保存し、環境に合わせて適宜変更する。

## 管理するファイル一覧

| ディレクトリ | ソフトウェア | 環境依存のある部分 |
| :-- | :-- | :-- |
| alacritty | [Alacritty](https://github.com/alacritty/alacritty) | `envcfg.toml` |
| git | [git](https://git-scm.com) | `.gitconfig.env` |
| goneovim | [goneovim](https://github.com/akiyosi/goneovim) |  |
| hhkb | [HHKB](https://happyhackingkb.com/jp/download/#tool) |  |
| mozc | [mozc](https://github.com/google/mozc) |  |
| nvim | [Neovim](https://neovim.io) | `lua/envcfg.lua` |
| sheldon | [sheldon](https://github.com/rossmacarthur/sheldon) |  |
| tealdeer | [tealdeer](https://github.com/dbrgn/tealdeer) | 設定ファイルのパス |
| wezterm | [WezTerm](https://wezfurlong.org/wezterm/index.html) | `envcfg.lua` |
| zsh | [zsh](https://www.zsh.org) | `.zsh_envcfg` |

## 管理方法

- 本リポジトリはホームディレクトリに置くこと
- ソフトウェア毎に`README.md`を記載する
- 環境依存ファイルはテンプレートを`ドットを除いたファイル名.txt`として保存
- 環境依存ファイルは適宜書き換えて利用する
- ソフトウェア毎に`.gitignore`を作成してホワイトリスト管理
- シンボリックリンクの貼り方は各ディレクトリの`setup.sh`に記載

## ToDo

* [ ] zellijのREADME.md
