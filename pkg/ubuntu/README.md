# Linux の手動インストール

パッケージリストに含められない手順、または追加の設定が必要なツールの導入手順を記載する。

## APM

APM (Agent Package Manager) は公式インストーラーを使用して導入する。

```sh
curl -sSL https://aka.ms/apm-unix | sh
apm --version
```

APM の管理方針は
[../../docs/apm.md](../../docs/apm.md) を参照する。
