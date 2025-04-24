# zsh 設定ファイル

## ディレクトリ説明

| ファイル名 | 役割 |
| :-- | :-- |
| `.zshrc` | zshの個人設定ファイル |
| `.zsh_envcfg` | 環境依存部分を記述したファイル |

## shell向けソフトウェア設定の方針

*   `export` で変数を定義するだけのもの → `.zshrc`
*   ファイルパスが関係するもの → `.zsh_envcfg`
*   CLIコマンドの`alias` → `.zshrc`
*   GUIコマンドの`alias` → `.zsh_env`

## 検討中

### Homebrewに依存する補完周り

MBA用`.zshrc`に含まれる以下のスクリプトは整理中

```sh
# setting for completions
# for rustup
fpath+=~/.zfunc
if type brew &>/dev/null; then
  # for zsh-completions
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  # for homebrew
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi
```
