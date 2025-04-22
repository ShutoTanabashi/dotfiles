# Neovim 設定

[Lua](https://www.lua.org/docs.html)を用いた[Neovimの設定について](https://neovim.io/doc/user/lua.html)

## ファイル構成

| ファイル名 | 役割 |
|  :-- | :-- |
| `init.lua` | 設定ファイルの起点、コア設定 |
| `lua/extensions.lua` | 拡張機能の設定 |
| `lua/lspcfg.lua` | [LSP](https://neovim.io/doc/user/lsp.html)の設定 |
| `lua/stlcfg.lua` | ステータスラインの設定 |
| `lua/envcfg.lua` | 環境依存の設定 |

| ディレクトリ名 | 役割 |
| :-- | :-- |
| `snippets` | [nvim-snippy](https://github.com/dcampos/nvim-snippy)用snippets設定 |
| `spell` | (Neo)vimのスペルチェック用辞書 |

### Neovim本体以外の設定

| ファイル名 | 役割 |
| `sumatrapdf.sh` | [WSLでSumatraPDFを利用するための設定](https://github.com/lervag/vimtex/issues/2566#issuecomment-1322886643) |
| `setup.sh` | Unix系のためのセットアップスクリプト |
| `setup.ps1` | Windowsのためのセットアップスクリプト |
| `setup_wsl.sh` | WSLのためのセットアップスクリプト |

### Notion

snippetsの文法やテンプレートは[vim-snippets](https://github.com/honza/vim-snippets)を参照。

## 環境依存ファイル

* `lua/envcfg.txt` - `lua/envcfg.lua`のテンプレート

### ハードコーディングされた環境依存

* markdownlintの設定ファイル
    * `dotfiles`リポジトリがホームディレクトリ直下にある前提でパスを記述

## 追加でインストールが必要なもの

### Rust LSP 関連ツール

[mason.nvim](https://github.com/williamboman/mason.nvim)と
[rustaceanvim](https://github.com/mrcjkb/rustaceanvim)の干渉問題および
[mason.nvim](https://github.com/williamboman/mason.nvim)経由での
[rustfmt](https://github.com/rust-lang/rustfmt)インストール非推奨に伴い、
RustのLSP関連ツールはrustup経由でインストールする。

```zsh
rustup component add rust-analyzer
rustup component add rustfmt
```

## 検討事項

* [lsp-config](https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration)に
  基づいたkeymap設定の有効化
  * 一部(definition)については既に有効であるが、全部ではない(formatなど)
