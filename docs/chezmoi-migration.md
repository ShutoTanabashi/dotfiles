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
.agents/            # エージェント用スキル等(HOME 配備対象外)
.github/            # リポジトリ運用用テンプレート等(HOME 配備対象外)
```

## 非配備資産の管理方針

`hhkb/`、`pkg/`、`.agents/`、`.github/`、`docs/` は HOME へ配備せず、
この Git リポジトリ上の現位置で継続管理する。`source state` は `.chezmoiroot`
により `home/` に限定されているため、これらは `chezmoi managed` にも
apply 対象にも含まれない(一時 HOME への apply で配備されないことを検証済み)。

| ディレクトリ | 内容 | 管理 |
| --- | --- | --- |
| `hhkb/` | HHKB キーマップ(`.hks`)・参考画像・README | Git のみ(手動で配布) |
| `pkg/` | [OS・chezmoi profile 別パッケージインストールリスト](../pkg/README.md) | Git のみ(セットアップ時に参照) |
| `.agents/` | エージェント用スキル | Git のみ |
| `.github/` | issue テンプレート等 | Git のみ |
| `docs/` | 移行・シークレット管理の文書 | Git のみ |

### `gentemplate.sh` の扱い

`gentemplate.sh` はシンボリックリンク方式の新規ツール用ディレクトリ
(`README.md` / `.gitignore` / `setup.sh`)を生成するスクリプトだった。
chezmoi 移行後は新規ツールの追加は `chezmoi add` で行うため役割を終え、
**廃止する**。

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
| `~/.config/chezmoi/chezmoi.toml` の `[data]` | マシン固有の選択(init プロンプトで生成) + 実験的 opt-in | `role`, `variant`, `secrets.backend`, `experimental.<tool>` |
| source state の `home/.chezmoidata.toml` | 全マシン共通の既定値の単一ソース | 共通既定値（`variant` / `experimental.<tool>` で配備制御） |
| gopass / OS keyring | シークレット実値(apply 時に解決) | `dotfiles/github_token` |
| `.chezmoiignore`(テンプレート可) | role / variant / experimental による配備抑制 | 実験的ツールは `experimental.rclone` で opt-in |

注意: chezmoi は設定ファイルのトップレベルの未知キーをテンプレートデータに
反映しないため、machine 固有の変数は必ず `[data]` 配下に置く。

## profile

`~/.config/chezmoi/chezmoi.toml`(machine-local data)で以下を管理する:

| キー | 値 | 用途 |
| --- | --- | --- |
| `data.role` | `desktop` / `server` | 役割別の配備制御(GUI ツール等) |
| `data.variant` | `full` / `minimal` | 構成の規模（`full` のみ追加ツールを含む） |
| `data.experimental.<tool>` | `true` / `false` | 実験的ツールの個別 opt-in（例: `experimental.rclone`。既定 false） |

`.chezmoiignore` は `role` / `variant` / `experimental.<tool>` と
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
| Linux Desktop(Arch) | Secret Service(GNOME Keyring) | 実機検証済み |
| macOS / Windows | OS keyring(Keychain / Credential Manager) | 配置・テンプレート・手順のみ整備(未検証) |
| Linux Server / WSL | gopass | 同上 |

### Windows

- 配置先が `%APPDATA%` / `%LOCALAPPDATA%` 系のツールは `home/AppData/` 配下の
  薄いテンプレートで配備する(nvim: `AppData/Local/nvim`、rumdl:
  `AppData/Roaming/rumdl`、alacritty: `AppData/Roaming/alacritty`)。
  Unix 系配置先(`.config/*`)は `.chezmoiignore` で除外される。
- PowerShell プロファイルは `Documents/PowerShell/` に配備される。msys2 の bash
  パスは `.chezmoidata.toml` の `[powershell]` で既定値を持つ。
- zsh・zathura・systemd ユニット(rclone)は Windows では配備されない。
- git の credential helper は `manager`(Git Credential Manager)へ分岐する。
- WSL(Linux)では `sumatrapdf.sh` が配備され、zsh に WSL 固有の WINHOME /
  WSLg 処理が生成される(`init` 時に Windows home パスを入力)。
- **未検証**: 実機での apply・各アプリの起動確認(テンプレートのレンダリング
  論理は `execute-template` で確認済み)。

### macOS

- zsh に Homebrew / OpenJDK / Ruby / Skim 向けの処理が生成される。
  alacritty は `option_as_alt` + Alt+Backslash の分岐が入る。
- wezterm の `default_prog` は OS 既定のまま(Windows のみ pwsh 分岐)。
- git の credential helper は `osxkeychain` へ分岐する。
- **未検証**: 実機での apply・各アプリの起動確認(テンプレートのレンダリング
  論理は `execute-template` で確認済み)。

### Linux Server

- `role=server` により GUI ツール(alacritty / wezterm / zathura / goneovim /
  `.xprofile` / mozc デスクトップエントリ)は配備されない。
- シークレット取得先は gopass を想定する(`secrets.backend` で明示可能)。
  Secret Service が無い環境では keyring バックエンドが使えないため、
  `gopass insert dotfiles/<key>` で登録する。
- systemd ユーザサービス(rclone)は experimental opt-in のときのみ配備。
- **未検証**: 実機での apply・gopass でのシークレット解決(一時 HOME での
  `role=server` の配備結果は検証済み)。

## 移行時の注意(共通)

- 旧シンボリックリンク運用からの切替は、`chezmoi apply` が symlink を
  実ファイルへ置き換える。切替前に旧 `setup.sh` によるリンクを残したままで
  問題ないが、適用後は `chezmoi diff` が空であることを確認する。
- `chezmoi init` 後に `config file template has changed` 警告が出た場合は
  `chezmoi init` を再実行して設定ファイルを再生成する。
- goneovim を使う Linux では `init` 時に実行ファイルパスとアイコンパスの
  入力が必要(`[data.goneovim]` が未設定だと apply が失敗する)。
