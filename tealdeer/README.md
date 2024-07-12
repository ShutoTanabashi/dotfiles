# tealdeer 設定ファイル

## 構成ファイル

* `config.toml`

## 設定ファイルに関する注意

* 設定ファイルの場所がOSによって大きく異なる
  * パスを確認して都度設定すること。
    * Linux向け(`$HOME/.config/tealdeer`に配置)の設定スクリプトを用意：`setup_linux.sh`

```sh
ln -s ~/dotfiles/tealdeer/config.toml PathForTeadDeer
```

## 設定に関するコマンド

```sh
# 基本の設定ファイル生成
tldr --seed-config

# 設定ファイルのパス確認
tldr --show-paths
```
