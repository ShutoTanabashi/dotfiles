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

```sh
chezmoi init <repo-url>   # role / variant を対話入力([data] 配下に生成される)
chezmoi apply             # 未登録のシークレットがある場合はここでエラーになる
# gopass insert dotfiles/<key>、または次のコマンドで値を登録
chezmoi secret keyring set --service=dotfiles --user=<key>
chezmoi apply
```

## 設定値の置き場所の役割分担

| 置き場所 | 役割 | 例 |
| --- | --- | --- |
| `~/.config/chezmoi/chezmoi.toml` の `[data]` | マシン固有の選択(init プロンプトで生成) + 実験的 opt-in | `role`, `variant`, `secrets.backend`, `experimental_<tool>` |
| source state の `home/.chezmoidata.toml` | 全マシン共通の既定値の単一ソース | 共通既定値（`variant` / `experimental_<tool>` で配備制御） |
| gopass / OS keyring | シークレット実値(apply 時に解決) | `dotfiles/github_token` |
| `.chezmoiignore`(テンプレート可) | role / variant / experimental による配備抑制 | 実験的ツールは `experimental_rclone` で opt-in |

注意: chezmoi は設定ファイルのトップレベルの未知キーをテンプレートデータに
反映しないため、machine 固有の変数は必ず `[data]` 配下に置く。

## profile

`~/.config/chezmoi/chezmoi.toml`(machine-local data)で以下を管理する:

| キー | 値 | 用途 |
| --- | --- | --- |
| `data.role` | `desktop` / `server` | 役割別の配備制御(GUI ツール等) |
| `data.variant` | `full` / `minimal` | 構成の規模（`full` のみ追加ツールを含む） |
| `data.experimental_<tool>` | `true` / `false` | 実験的ツールの個別 opt-in（例: `experimental_rclone`。既定 false） |

`.chezmoiignore` は `role` / `variant` / `experimental_<tool>` と
`.chezmoi.os` を併用して配備を制御する。

## 生成時と実行時の条件分岐

テンプレートで生成するshell設定は、条件が変化する時点に応じて責務を分ける。

| 判定時点 | 対象 | 判定方法 |
| --- | --- | --- |
| chezmoi生成時 | OS、distribution、WSL、role、variant、machine data | `.chezmoi.os`、`.chezmoi.osRelease.id`、kernel、data |
| shell起動時 | コマンド、ファイル、ディレクトリ、keyringの現在状態 | `$commands`、`-r`、`-d`、取得コマンドの終了状態 |

- OSやdistributionが限定される設定は、chezmoiテンプレートで対象環境にだけ
  書き出す。zshrc内の`OSTYPE`等で同じ判定を重ねない。
- 任意ツールはインストール後・削除後に再applyなしで追従できるよう、
  shell起動時にも存在確認する。
- 両方の条件が必要な場合は、生成時に対象環境を限定し、生成された処理内で
  現在のコマンドやパスを検査する。
- `lookPath`は設定ファイル全体の配備判定に使用できる。zshrc内の任意機能には
  原則として使用せず、起動時判定を使う。
- シークレットは値を生成物へ埋め込まず、選択されたbackendからshell起動時に
  取得する。未登録・取得失敗時の挙動はツールごとに明示する。

zshでは次の分担を使用する。

- Debian / Ubuntuの`batcat` aliasはdistributionで生成を限定し、生成後も
  `bat`と`batcat`の有無を確認する。
- Homebrew / OpenJDK / Ruby / SkimはmacOSだけへ生成し、各実体を起動時に確認する。
- CUDAはLinuxだけへ生成し、`/opt/cuda`が存在する場合だけ環境変数を設定する。
- WINHOME / WSLgはWSLだけへ生成し、machine dataとsocketを起動時に確認する。
- eza、sheldon、pyenv等のOS非依存な任意ツールは、zsh起動時の検出だけで制御する。

## ロールバック方法

- chezmoi 管理をやめる場合は `chezmoi purge` 後に旧コミットを
  checkout し、必要に応じて `setup.sh` を再実行する

## OS 固有事項

| OS | シークレット取得先 | 状態 |
| --- | --- | --- |
| Linux Desktop(Arch) | Secret Service(GNOME Keyring) | 実機検証対象 |
| macOS / Windows | OS keyring(Keychain / Credential Manager) | 配置・テンプレート・手順のみ整備(未検証) |
| Linux Server / WSL | gopass | 同上 |
