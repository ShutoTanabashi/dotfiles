# 設定ファイル集

（主にUnix系システム向けの）設定ファイルを管理する。  
環境依存のファイルがある場合は`txt`ファイルで保存し、環境に合わせて適宜変更する。

## 管理するファイル一覧

| ディレクトリ | ソフトウェア | 環境依存ファイル |
| :-- | :-- | :-- |
| zsh | [zsh](https://www.zsh.org) | `.zsh_envcfg` |
| nvim | [neovim](https://neovim.io) | `lua/envcnf.lua` |
| git | [git](https://git-scm.com) |  |
| sheldon | [sheldon](https://github.com/rossmacarthur/sheldon) |  |
| tealdeer | [tealdeer](https://github.com/dbrgn/tealdeer) | ファイルパス |

## 管理方法

- 本リポジトリはホームディレクトリに置くこと
- ソフトウェア毎に`README.md`を記載する
- 環境依存ファイルはテンプレートを`ドットを除いたファイル名.txt`として保存
- 環境依存ファイルは適宜書き換えて利用する
- ソフトウェア毎に`.gitignore`を作成してホワイトリスト管理
- シンボリックリンクの貼り方は各ディレクトリの`setup.sh`に記載
