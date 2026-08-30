# PowerShell - AGENTS

このディレクトリは chezmoi で管理されています。

- 展開先: Windows の `%USERPROFILE%\Documents\PowerShell\` (pwsh 7 の CurrentUserCurrentHost profile)
- Source state: `home/Documents/PowerShell/` 配下
- Windows 以外では `.chezmoiignore` で配備対象外になります。
- 直接 `%USERPROFILE%\Documents\PowerShell\` 配下を編集しないでください。編集は source state で行い `chezmoi apply` で反映してください。

## 設定値

| 値 | 既定値 | 上書き方法 |
| :-- | :-- | :-- |
| `powershell.msys2_bash` | `C:\msys64\usr\bin\bash.exe` | `~/.config/chezmoi/chezmoi.toml` の `[data.powershell]` |

`powershell.msys2_bash` が未設定またはファイル不在の場合、`allupgrade` は msys2 の更新をスキップします。

## OpenCode API key

`OPENCODE_API_KEY` はこのファイルへ書き込みません。profile 読み込み時に OS の資格情報マネージャーから取得します。

```powershell
chezmoi secret keyring set --service=dotfiles --user=opencode_api_key
```

未登録または取得失敗時は `OPENCODE_API_KEY` を設定せず、profile の読み込みは継続します。

## Windows 実機での確認手順

1. `chezmoi apply` で `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` が生成されることを確認する。
2. `pwsh` を起動し、警告・エラーが出ないことを確認する。
3. `which nvim`、`allupgrade`、`gvi` が定義され、`$env:OPENCODE_API_KEY` が設定されることを確認する(値は画面へ出力しない)。
4. msys2 をインストールしていない環境では `allupgrade` が msys2 の更新をスキップすることを確認する。
5. `chezmoi apply` を再実行し、差分が出ないことを確認する。
