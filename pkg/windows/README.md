# Windows のパッケージ導入

パッケージリストに含められない手順、または追加の設定が必要なツールの導入手順を記載する。

## Scoop、winget、MSYS2

desktop / full の例。各 profile の合成規則は [../README.md](../README.md) を参照する。

```powershell
Get-Content scoop-server-minimal.txt, scoop-server-full.txt, scoop-desktop-minimal.txt, scoop-desktop-full.txt |
  ForEach-Object { scoop install $_ }
Get-Content winget-server-minimal.txt, winget-desktop-minimal.txt |
  ForEach-Object { winget install --id $_ --exact }
Get-Content msys2-server-minimal.txt |
  ForEach-Object { & C:\msys64\usr\bin\bash.exe -lc "pacman -S --needed --noconfirm $_" }
```

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
