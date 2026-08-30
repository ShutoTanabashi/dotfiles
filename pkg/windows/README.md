# Windows の手動インストール

パッケージマネージャのインストール一覧に含められないツールの導入手順を記載する。

## Herdr

Herdr は公式インストーラーで導入する。

```powershell
powershell -ExecutionPolicy Bypass -c "irm https://herdr.dev/install.ps1 | iex"
```
