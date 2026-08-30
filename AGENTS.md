# dotfiles

普段利用する設定ファイルを管理するリポジトリ

## ディレクトリ構成

各ツールごとにディレクトリを分けて設定ファイルを保存します。

## パッケージ管理

パッケージリストの構成・profile の合成規則は [`pkg/README.md`](pkg/README.md) を参照する。

| 対象 | 利用するパッケージマネージャ |
| --- | --- |
| OS 共通 | Cargo |
| macOS | Homebrew |
| Ubuntu | apt、snap |
| Arch Linux（WSL を含む） | pacman、AUR ヘルパー |
| Windows | Scoop、winget、MSYS2 |

パッケージ一覧は server / minimal を基底とし、desktop と full は差分だけを持つ。
CLI・開発ツールは server 側、GUI・デスクトップ連携ツールは desktop 側へ分類する。

## 作業時の注意点

ユーザへの応答は日本語を用いてください。
