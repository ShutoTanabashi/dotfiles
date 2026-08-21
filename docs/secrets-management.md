# シークレット管理方針

chezmoi 移行後のシークレット(API キー、トークン等)の管理方針を定める。
本ドキュメントがシークレット管理の唯一の管理元であり、変更時はこのファイルだけを更新する。

## 基本原則

- シークレットの値は Git リポジトリへコミットしない(**暗号文も含めて一切コミットしない**)
- diff・ログ・Backlog・文書に値を出力しない
- 値は専用の管理ツール(gopass または OS の keyring)に登録し、apply 時に解決する
  (**平文ファイルには保存しない**)

## 取得先と解決順序

共通テンプレート `.chezmoitemplates/secret.tmpl` が apply 時に値を解決する。

| 優先 | 取得先 | 環境 |
| --- | --- | --- |
| 1 | gopass(`dotfiles/<key>` に登録) | gopass インストール済み(サーバー / WSL 等) |
| 2 | OS keyring(service `dotfiles` に登録) | darwin / windows、または `secret-tool` 検出時(GNOME デスクトップ等) |

- 自動判定は `chezmoi.toml` の `[data.secrets].backend`("gopass" / "keyring")で上書きできる
- 値が未登録の場合は gopass / keyring 関数がエラーになり **apply が失敗する**(loud fail)
- 複数行の値(SSH 鍵等)が必要な場合は `gopassRaw` テンプレート関数を直接使う

値の登録・確認方法は各ツールのドキュメントを参照(本リポジトリでは `dotfiles/<key>`
という名前規約を統一して使う):

- gopass: <https://www.gopass.pw/docs/quickstart/>
- GNOME Keyring(secret-tool / seahorse): <https://gnome.pages.gitlab.gnome.org/libsecret/>

## キーの管理

秘密キーの管理はテンプレートの呼び出し箇所と本ドキュメントの2箇所で行う:

- **定義の単一ソース**: ツールのテンプレート中の `secret.tmpl` 呼び出し
  (`{{ includeTemplate "secret.tmpl" (dict "key" "github_token" "data" .) | abortEmpty }}`)
- **人間向けの索引**: 本ドキュメントのキー一覧表

キー追加・削除時は以下を必ず更新する:

1. 対象ツールのテンプレート(呼び出しの追加・削除)
2. 本ドキュメントのキー一覧表

### キー一覧

| キー | 用途 | 必須 |
| --- | --- | --- |
| `github_token` | GitHub Personal Access Token | ツール側で使用する場合 |
| `rclone_pass` | rclone 設定のパスワード | ツール側で使用する場合 |

## 参考

- chezmoi Password managers(gopass / Keychain / Windows Credential Manager 含む): <https://www.chezmoi.io/user-guide/password-managers/>
