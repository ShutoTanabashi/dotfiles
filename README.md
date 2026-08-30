# 設定ファイル集

chezmoi で管理する dotfiles リポジトリ。
セットアップ手順と移行の経緯は [docs/chezmoi-migration.md](docs/chezmoi-migration.md)、
シークレット管理方針は [docs/secrets-management.md](docs/secrets-management.md)、
APM によるエージェント設定の管理は [docs/apm.md](docs/apm.md) を参照。

## セットアップ

```sh
chezmoi init ShutoTanabashi/dotfiles   # role / variant を対話入力
chezmoi apply
```

## ディレクトリ構成

| ディレクトリ | 内容 | 管理 |
| :-- | :-- | :-- |
| `home/` | chezmoi の source state(HOME へ配備) | chezmoi |
| `hhkb/` | HHKB キーマップ(`.hks`)・参考画像 | Git のみ |
| [`pkg/`](pkg/README.md) | OS・chezmoi profile 別パッケージインストールリスト | Git のみ |
| `docs/` | 移行ガイド・シークレット管理方針 | Git のみ |
| `.agents/` / `.github/` | エージェント用スキル・リポジトリ運用用 | Git のみ |

## 管理するツール

alacritty, fcitx5, git, goneovim, Herdr, homebrew, ibus, mozc, nvim, PowerShell,
rclone, rumdl, sheldon, tealdeer, wezterm, zathura, zellij, zsh

配備の対象・規模は `~/.config/chezmoi/chezmoi.toml` の
`role`(`desktop` / `server`)と `variant`(`full` / `minimal`)で制御する。
実験的ツール(rclone / fcitx / ibus / mozc)は `experimental.<tool>` で個別に opt-in する。
