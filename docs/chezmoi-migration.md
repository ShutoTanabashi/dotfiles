# chezmoi 移行ガイド

自作 shell スクリプト から、chezmoi を利用した dotfiles 管理への段階的移行について記載する。

## 概要

- 従来の各ディレクトリの `setup.sh` によるシンボリックリンク方式から、chezmoi による配備へ移行する
- 移行はツール単位で行い、旧資産は動作確認完了後に削除する
- シークレット管理方針は [secrets-management.md](secrets-management.md) を参照

## ディレクトリ構成

```console
.chezmoiroot        # source state として home/ を指定
home/               # HOME へ配備する source state
  .chezmoidata.toml     # 共通データ（共通既定値の単一ソース）
  .chezmoiignore        # 配備除外の定義
  .chezmoi.toml.tmpl    # chezmoi init 時の設定ファイル生成テンプレート
  .chezmoitemplates/    # 共通テンプレート(secret.tmpl 等)
pkg/                # パッケージリスト(HOME 配備対象外)
hhkb/               # HHKB 設定(HOME 配備対象外)
docs/               # 文書(HOME 配備対象外)
```

## 新規マシンの初期化手順

```console
$ chezmoi init <repo-url>   # role / variant を対話入力([data] 配下に生成される)
$ chezmoi apply             # 未登録のシークレットがある場合はここでエラーになる
# gopass insert dotfiles/<key> または secret-tool store --label=dotfiles dotfiles <key> で値を登録
$ chezmoi apply
```

## 設定値の置き場所の役割分担

| 置き場所 | 役割 | 例 |
| --- | --- | --- |
| `~/.config/chezmoi/chezmoi.toml` の `[data]` | マシン固有の選択(init プロンプトで生成) | `role`, `variant`, `secrets.backend` |
| source state の `home/.chezmoidata.toml` | 全マシン共通の既定値の単一ソース | 共通既定値（ツール配備は `variant` で制御） |
| gopass / OS keyring | シークレット実値(apply 時に解決) | `dotfiles/github_token` |
| `.chezmoiignore`(テンプレート可) | role / variant による配備抑制 | server なら GUI ツールを ignore |

注意: chezmoi は設定ファイルのトップレベルの未知キーをテンプレートデータに
反映しないため、machine 固有の変数は必ず `[data]` 配下に置く。

## profile

`~/.config/chezmoi/chezmoi.toml`(machine-local data)で以下を管理する:

| キー | 値 | 用途 |
| --- | --- | --- |
| `data.role` | `desktop` / `server` | 役割別の配備制御(GUI ツール等) |
| `data.variant` | `full` / `minimal` | 構成の規模（`full` のみ追加ツールを含む） |

`.chezmoiignore` は `role` / `variant` と `.chezmoi.os` を併用して配備を制御する。

## 個別ツール移行状況

### zellij

- **profile:** `variant=full` のみ配備（`minimal` では除外）。`role` による分岐なし。
- **配置先:** `~/.config/zellij/config.kdl` と `~/.config/zellij/themes/*.kdl`（18テーマ）
- **source state:** `home/dot_config/zellij/config.kdl`, `home/dot_config/zellij/themes/*.kdl`
- **OS固有事項:** なし（全OS共通、シークレットなし）
- **切替方法:** `~/.config/chezmoi/chezmoi.toml` の `data.variant` を `full` / `minimal` に変更後 `chezmoi apply`
- **ロールバック:** `chezmoi purge` 後に旧コミットを checkout し、必要に応じて `zellij/setup.sh` を再実行（第1コミット checkout で旧シンボリックリンク方式に戻せる）

## ロールバック方法

- chezmoi 管理をやめる場合は `chezmoi purge` 後に旧コミットを checkout し、必要に応じて `setup.sh` を再実行する

## OS 固有事項

| OS | シークレット取得先 | 状態 |
| --- | --- | --- |
| Linux Desktop(Arch) | Secret Service(GNOME Keyring) | 実機検証対象 |
| macOS / Windows | OS keyring(Keychain / Credential Manager) | 配置・テンプレート・手順のみ整備(未検証) |
| Linux Server / WSL | gopass | 同上 |
