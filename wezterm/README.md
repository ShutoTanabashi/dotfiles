# WezTerm 設定ファイル

設定の詳細は[公式ドキュメント](https://wezfurlong.org/wezterm/config/files.html)を参照

## ファイル構成

| ファイル名 | 役割 |
| :-- | :-- |
| `wezterm.lua` | メイン設定ファイル |
| `envcfg.lua` | 環境依存の設定 |

## 環境依存ファイル

* `envcfg.txt` - `envcfg.lua`のテンプレート

## To Do

[tmuxの操作方法](https://www.tohoho-web.com/ex/tmux.html#run-exit)を参考にしながらショートカットキーをカスタマイズする

* [x] leaderキー(prefix)の設定
* [x] ペイン分割：上下
* [x] ペイン分割：左右
* [ ] ペイン移動(tmux準拠も追加)
* [ ] ペイン入れ替え
* [ ] ペインのウィンドウ化
* [x] ペイン終了
* [ ] コピーモードの設定

### 不具合情報

Linux環境だとペイン分割がうまくいかない。
動作を見る限りでは入力は受け付けているし、ペイン分割以外のリーダーキーを用いた操作は動作する。
