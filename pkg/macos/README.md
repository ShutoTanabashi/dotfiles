# macOS のパッケージ導入

Homebrew で server / full の一覧を導入する。macOS 固有の desktop 差分は現在ないため、
desktop 構成も同じ一覧を使用する。

```sh
cat brew-server-minimal.txt brew-server-full.txt | xargs brew install
```
