# Arch Linux のパッケージ導入

WSL を含む Arch Linux では、このディレクトリの一覧を利用する。WSL 専用の一覧は
設けず、通常の Arch プロファイルへ含める。

## pacman

desktop / full の例。存在する層だけを順に連結して導入する。

```sh
cat pacman-server-minimal.txt pacman-server-full.txt \
  pacman-desktop-minimal.txt pacman-desktop-full.txt | \
  xargs -r sudo pacman -S --needed
```

WM 構成は full の追加要素である。

```sh
cat pacman-wm-desktop-full.txt | xargs -r sudo pacman -S --needed
```

## AUR

AUR ヘルパーを使い、pacman と同じプロファイル順で導入する。以下は `paru` の例である。

```sh
cat aur-server-minimal.txt aur-desktop-minimal.txt aur-desktop-full.txt | \
  xargs -r paru -S --needed
```
