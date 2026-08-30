# Ubuntu のパッケージ導入

パッケージリストに含められない手順、または追加の設定が必要なツールの導入手順を記載する。

## apt と snap

desktop / full の例。各 profile の合成規則は [../README.md](../README.md) を参照する。

```sh
cat apt-server-minimal.txt apt-server-full.txt \
  apt-desktop-minimal.txt | xargs -r sudo apt install -y
cat snap-server-minimal.txt snap-desktop-minimal.txt | \
  xargs -r sudo snap install
cat snap-classic-server-minimal.txt | xargs -r sudo snap install --classic
```

## APM

APM (Agent Package Manager) は公式インストーラーを使用して導入する。

```sh
curl -sSL https://aka.ms/apm-unix | sh
apm --version
```

APM の管理方針は
[../../docs/apm.md](../../docs/apm.md) を参照する。
