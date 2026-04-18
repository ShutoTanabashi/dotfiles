---
name: git-commit
description: この dotfiles リポジトリでコミットメッセージを作るときに使う。自動生成メッセージを除いた、このリポジトリ特有のコミット規約に従う。
---

# Git Commit Message Style

このリポジトリでコミットメッセージを作るときは、以下の形式を使う。

## 基本形式

`<scope>: <summary>`

例:

-   `nvim: Load fugitive on VeryLazy`
-   `wezterm: Use WebGPU`
-   `git: Set delta and bat to pager`
-   `zsh: Add completion settings for rust tools`

## ルール

-   `feat:` や `fix:` などの Conventional Commits は、ユーザーが明示的に求めない限り使わない。
-   `Merge pull request #...` や `Merge branch ...` のような自動生成メッセージは真似しない。
-   `scope` には変更対象のコンポーネント名を入れる。例: `nvim`, `wezterm`, `git`, `zsh`, `pkg`
    -   このリポジトリ全般の設定には `general:` を使う
    -   `scope` は、このリポジトリでディレクトリ名に利用される単位に合わせる。
-   `summary` は動詞から始まる英語の短いフレーズにする。
-   原則として 1 行で完結させる。本文はユーザーが求めたときだけ付ける。

## 出力方針

コミットメッセージを求められたら、原則として候補を 1 つだけ返す。

変更が複数領域にまたがっていて判断が割れる場合のみ、2〜3 個の候補を出し、最有力案を先頭に置く。
変更が明確に分離された複数領域を含む場合は、分割してコミットする場合の分割案とそれぞれのコミットメッセージ候補を提案する。
