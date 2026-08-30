# Windows の手動インストール

パッケージリストに含められない手順、または追加の設定が必要なツールの導入手順を記載する。

## APM

APM (Agent Package Manager) は Scoop を優先して導入する。初回のみ APM の
bucket を追加する。

```powershell
scoop bucket add apm https://github.com/microsoft/scoop-apm
scoop install apm
apm --version
```

Scoop を利用できない場合だけ、公式インストーラーを使用する。

```powershell
irm https://aka.ms/apm-windows | iex
apm --version
```

APM の管理方針は
[../../docs/apm.md](../../docs/apm.md) を参照する。

## Herdr

Herdr は公式インストーラーで導入する。

```powershell
powershell -ExecutionPolicy Bypass -c "irm https://herdr.dev/install.ps1 | iex"
```
