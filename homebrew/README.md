# Homebrew 設定ファイル

## ファイル構成

* `brew.env` - Homebrewの環境変数用設定ファイル

### 設定場所について

設定ファイルを設置可能な場所が複数存在する．

| Location | Target |
| :-- | :-- |
| `/etc/homebrew/brew.sh` | system-wide |
| `$HOME/.homebrew/brew.env` | user-specific |

本リポジトリに含まれる`setup.sh`では`/etc`以下（system-wide）にファイルを配置する．
したがって **`setup.sh`は管理者権限で実行する必要がある** ．
