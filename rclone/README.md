# rclone 設定ファイル

## ファイル構成

rcloneの設定ファイルも`~/.config/rclone`以下に存在するが、認証に用いる秘密鍵が記載されているためリポジトリには保存しない。

*   `rclone-googledrive.txt` - [Google Drive](https://drive.google.com)を`~/GoogleDrive`に自動でマウントするためのsystemd用設定ファイル`rclone-googledrive.service`のテンプレート

### 環境依存ファイル

systemdが用いる`*.service`ファイルにはホームディレクトリをフルパスで記述している箇所あり。
ユーザ名を適宜変更すること。
元のファイルでは`shoot`を利用している。

## ドライブ連携時の注意事項

### Google drive

[Google driveに関する公式ドキュメント](https://rclone.org/drive/#making-your-own-client-id)

remoteのnameは`gdrive`で作成する。
そうでないと、本リポジトリに含まれる設定ファイルがうまく起動しない。

client_idについては[自分で作成済み](https://console.cloud.google.com/apis/credentials?project=vocal-facet-435115-g5)
