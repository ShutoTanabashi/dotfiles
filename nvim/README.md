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

### Nero vim本体以外の設定

| ディレクトリ名 | 役割 |
| :-- | :-- |
| `snippets` | [nvim-snippy](https://github.com/dcampos/nvim-snippy)で用いるsnippets設定 |
| `spell` | (Neo)vimのスペルチェック用辞書 |

snippetsの文法やテンプレートは[vim-snippets](https://github.com/honza/vim-snippets)を参照。

## 環境依存ファイル

* `lua/envcfg.txt` - `lua/envcfg.lua`のテンプレート

## 検討事項

* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)と[vim-matchup](https://github.com/andymass/vim-matchup)が干渉する
  * 括弧系の入力のみ(例えば`[`や`<`)で補完しようとすると、次の項目を選択(`<C-n>`)が機能しない
  * 一旦はvim-matchupを無効化することで対象
    * 長期的にどうするかを検討する
