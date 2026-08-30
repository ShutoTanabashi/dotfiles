# rclone

Google Drive を `~/GoogleDrive` にマウントする rclone 設定。chezmoi で管理（実験的 opt-in、Linux のみ）。

## 構成

* `~/.config/rclone/rclone.env`（chezmoi 生成、0600）: `RCLONE_CONFIG_GDRIVE_TYPE/CLIENT_ID/CLIENT_SECRET` を定義。`client_id` / `client_secret` は keyring から `secret.tmpl` で解決。`token` は含まない。
* `~/.config/rclone/rclone.conf`（ローカル生成、0600、chezmoi 管理外）: `rclone config` で生成。`token = {"access_token":...,"refresh_token":...}` を保持。rclone が自動更新で書き戻す。
* `~/.config/systemd/user/rclone-googledrive.service`（chezmoi 生成）: `rclone.env` を source して `rclone mount gdrive:` を実行。`rclone.conf` の token とマージされる。

`rclone.env` と `rclone.conf` はマージされる。`client_id/secret` は env、`token` はファイルで管理するハイブリッド構成。

## セットアップ

1. Google Cloud Console で OAuth クライアントを作成（https://console.cloud.google.com/apis/credentials?project=vocal-facet-435115-g5）し、`client_id` / `client_secret` を取得。
2. keyring に登録:
   ```sh
   chezmoi secret keyring set --service=dotfiles --user=rclone_gdrive_client_id
   chezmoi secret keyring set --service=dotfiles --user=rclone_gdrive_client_secret
   ```
3. このマシンで有効化:
   ```sh
   # ~/.config/chezmoi/chezmoi.toml に追記
   [data.experimental]
   rclone = true
   chezmoi apply
   ```
   （`.chezmoidata.toml` の既定は `experimental.rclone = false`。`.chezmoiignore` で Linux + 実験的フラグが有効な場合のみ `rclone.env` / `service` が配備される）
4. 初期認証（token 生成）:
   ```sh
   source ~/.config/rclone/rclone.env
   rclone config reconnect gdrive:
   # ブラウザで承認 → ~/.config/rclone/rclone.conf に token が保存される
   ```
5. マウント確認:
   ```sh
   systemctl --user daemon-reload
   systemctl --user enable --now rclone-googledrive.service
   rclone about gdrive:
   systemctl --user status rclone-googledrive.service
   ```

## 実験的フラグ

`rclone` は `experimental.rclone` でゲートされる。共有既定 `home/.chezmoidata.toml` は `false`、このマシンの `~/.config/chezmoi/chezmoi.toml` で `true` に上書きして検証。

## 注意

* remote 名は `gdrive` で作成すること。env 変数 `RCLONE_CONFIG_GDRIVE_*` と対応。
* `rclone.conf` は chezmoi 管理外のため `git` 管理しない。 `token` の keyring 登録は不要。
* 旧資産 `rclone/rclone-googledrive.txt` / `rclone/setup.sh` は chezmoi 移行後に削除。
