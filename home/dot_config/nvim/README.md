# Neovim 設定

[Lua](https://www.lua.org/docs.html)を用いたNeovim設定。
このディレクトリはchezmoiによって生成されるため、直接編集しない。

## ファイル構成

| パス | 役割 |
| :-- | :-- |
| `init.lua` | 設定の起点、コア設定 |
| `lua/plugins` | lazy.nvim用プラグイン設定 |
| `lua/lspcfg.lua` | LSPの共通設定 |
| `lua/stlcfg.lua` | ステータスライン設定 |
| `after/lsp` | LSPサーバー別設定 |
| `snippets` | nvim-snippy用snippet |
| `spell` | スペルチェック用辞書 |

環境差分はchezmoiの`nvim.*` data、`variant`、`role`、OS情報から生成される。
WSLでSumatraPDFを使う場合だけ`~/.local/bin/sumatrapdf.sh`も配備される。

snippetsの文法やテンプレートは[vim-snippets](https://github.com/honza/vim-snippets)を参照。

## 追加でインストールが必要なもの

### markdown-preview.nvim

[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)では、
`lazy.nvim`のプラグイン設定に次のbuild処理を指定している。

```lua
build = "cd app && npm install",
```

この処理はプラグインの初回インストール時と更新時に自動実行されるため、
Node.jsとnpmが利用できれば手動での初期セットアップは不要。
依存パッケージのインストールに失敗した場合や、再構築する場合だけ、
Neovim上で次のコマンドを実行する。

```vim
:Lazy build markdown-preview.nvim
```

完了後、Markdownファイルを開いて`:MarkdownPreview`を実行し、
ブラウザでプレビューが表示されることを確認する。

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

*   [lsp-config](https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration)に
  基づいたkeymap設定の有効化
    *   一部(definition)については既に有効であるが、全部ではない(formatなど)
