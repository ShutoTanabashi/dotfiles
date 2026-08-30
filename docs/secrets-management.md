# シークレット管理方針

chezmoi 移行後のシークレット(API キー、トークン等)の管理方針を定める。
本ドキュメントがシークレット管理の唯一の管理元であり、変更時はこのファイルだけを更新する。

## 基本原則

-   シークレットの値は Git リポジトリへコミットしない(**暗号文も含めて一切コミットしない**)
-   diff・ログ・Backlog・文書に値を出力しない
-   値は専用の管理ツール(gopass または OS の keyring)に登録し、apply 時に解決する
    (**平文ファイルには保存しない**)
-   シェルの環境変数として必要な値は、設定ファイルへ展開せず
    シェル起動時に取得する

## 取得先と解決順序

共通テンプレート `.chezmoitemplates/secret.tmpl` が apply 時に値を解決する。

| 優先 | 取得先 | 環境 |
| --- | --- | --- |
| 1 | gopass(`dotfiles/<key>` に登録) | gopass インストール済み(サーバー / WSL 等) |
| 2 | OS keyring(service `dotfiles` に登録) | darwin / windows、または `secret-tool` 検出時(GNOME デスクトップ等) |

-   自動判定は `chezmoi.toml` の `[data.secrets].backend`("gopass" / "keyring")で上書きできる
-   値が未登録の場合は gopass / keyring 関数がエラーになり
    **apply が失敗する**(loud fail)
-   複数行の値(SSH 鍵等)が必要な場合は `gopassRaw` テンプレート関数を直接使う

値の登録・確認方法は各ツールのドキュメントを参照(本リポジトリでは `dotfiles/<key>`
という名前規約を統一して使う):

-   gopass: <https://www.gopass.pw/docs/quickstart/>
-   GNOME Keyring(secret-tool / seahorse): <https://gnome.pages.gitlab.gnome.org/libsecret/>

## キーの管理

秘密キーの管理はテンプレートの呼び出し箇所と本ドキュメントの2箇所で行う:

-   **定義の単一ソース**: ツールのテンプレート中の
    `secret.tmpl` 呼び出し

    ```gotmpl
    {{ includeTemplate "secret.tmpl"
       (dict "key" "github_token" "data" .) | abortEmpty }}
    ```

-   **人間向けの索引**: 本ドキュメントのキー一覧表

キー追加・削除時は以下を必ず更新する:

1.  対象ツールのテンプレート(呼び出しの追加・削除)
2.  本ドキュメントのキー一覧表

### キー一覧

| キー | 用途 | 必須 | 管理 |
| --- | --- | --- | --- |
| `github_token` | GitHub Personal Access Token | ツール側で使用する場合 | keyring |
| `opencode_api_key` | OpenCode API key | OpenCodeを使う場合 | keyring |
| `rclone_gdrive_client_id` | rclone gdrive remote の OAuth client_id（Google Cloud Console で取得） | rclone(gdrive) を使う場合 | keyring |
| `rclone_gdrive_client_secret` | rclone gdrive remote の OAuth client_secret（同上） | rclone(gdrive) を使う場合 | keyring |
| `rclone_gdrive_token` | rclone gdrive remote の OAuth token(JSON, `refresh_token` を含む) | rclone(gdrive) を使う場合 | ローカル生成（`~/.config/rclone/rclone.conf`）。keyring 対象外 |

### rclone のキー命名と登録

-   rclone は remote ごとに独立した認証情報を持つ。
    キーは `rclone_<remote名>_<param>` の形とし、
    `dotfiles` 名前空間のもとで複数 remote も一意にする（例: `rclone_onedrive_token`）。
-   `client_id` / `client_secret` は Google Cloud Console で事前に取得できる
    静的な値のため keyring で管理する。参照時は `secret.tmpl` の `key` に
    上記キー名を指定し、`service` は既定の `dotfiles` のままとする
    （解決: `chezmoi secret keyring get --service=dotfiles --user=rclone_gdrive_client_id`）。
    登録・確認は全OSで `chezmoi secret keyring` に統一する。
    Seahorse GUIでは任意の属性を付けられず、異なる属性名で登録すると
    chezmoiの`keyring`関数から取得できない。例:

    ```sh
    chezmoi secret keyring set --service=dotfiles --user=rclone_gdrive_client_id
    chezmoi secret keyring set --service=dotfiles --user=rclone_gdrive_client_secret
    ```

    いずれも実行後に値を貼り付ける。取得確認では値を画面へ出さず、
    終了コードだけを確認する。
-   `token` は `rclone config` / `rclone authorize` のローカル初期化で
    生成される結果のため keyring では管理しない。
    `~/.config/rclone/rclone.conf` に
    `token = {"access_token":...,"refresh_token":...}` として保存される。
    このファイルはchezmoi・Git管理外で、rcloneが自動更新する。
    取得時は `rclone config reconnect gdrive:` でブラウザ認証し、
    生成された`rclone.conf`の`token`行を確認する。

### OpenCode API key

-   `opencode_api_key`は設定ファイルへ展開せず、シェル起動時に
    keyringまたはgopassから取得する。
-   取得元はOSごとに次のとおり。
    -   zsh(Linux/macOS): `.secrets.backend`の指定に従いkeyringまたはgopassから取得する
    （未指定時はgopass、次にkeyringの順で自動判定）。
    -   PowerShell(Windows): OSの資格情報マネージャーのみを使用する
    （`chezmoi secret keyring get --service=dotfiles --user=opencode_api_key`）。
-   未登録・backend不在・取得失敗時は`OPENCODE_API_KEY`を設定せず、
    シェル起動は継続する。
-   keyringへの登録は次のコマンドを使用する。
    値をシェル履歴へ残すため`--value`は使わない。

    ```sh
    chezmoi secret keyring set --service=dotfiles --user=opencode_api_key
    ```

## 参考

-   [chezmoi Password managers](https://www.chezmoi.io/user-guide/password-managers/)
    (gopass / Keychain / Windows Credential Manager 含む)
