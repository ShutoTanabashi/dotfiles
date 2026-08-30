# パッケージリスト

`pkg/` は chezmoi の配備対象外であり、新しい環境をセットアップするときに参照する。
一覧は1行1パッケージで、ファイル内容をそのままパッケージマネージャへ渡せる。

## ディレクトリ

| ディレクトリ | 対象 | パッケージマネージャ |
| --- | --- | --- |
| `common/` | OS 共通 | Cargo |
| `macos/` | macOS | Homebrew |
| `ubuntu/` | Ubuntu | apt、snap |
| `arch/` | Arch Linux（WSL を含む） | pacman、AUR ヘルパー |
| `windows/` | Windows | Scoop、winget、MSYS2 |

## プロファイルの合成

ファイル名は `<manager>-<role>-<variant>.txt` とする。存在するファイルだけを、次の
順序で連結して導入する。

| 構成 | 連結する層 |
| --- | --- |
| server / minimal | `server-minimal` |
| server / full | `server-minimal` → `server-full` |
| desktop / minimal | `server-minimal` → `desktop-minimal` |
| desktop / full | `server-minimal` → `server-full` → `desktop-minimal` → `desktop-full` |

`server-minimal` は CLI・開発ツールの基底である。`desktop-minimal` は GUI・入力・
表示・デスクトップ連携の差分、`*-full` は対応する chezmoi full 構成の追加分だけを
持つ。したがって desktop は server の、full は minimal のスーパーセットになる。

各 OS の導入コマンドと手動手順は、配下の README を参照する。
