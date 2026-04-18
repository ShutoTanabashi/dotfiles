---
name: make-pr
description: GitHub で管理している作業ブランチから pull request を作成するときに使う。変更後の branch がすでにある場合に、関連する issue 情報を利用して PR を立てる場合に使う。
---

# Make Pull Request

## Overview

既存の作業ブランチを起点に、対応する GitHub issue を参照しながら PR を作成する。
issue の assignee と label は PR に引き継ぎ、必要なら commit を整えてから公開する。

## Workflow

### 1. Confirm the starting point

現在の branch が作業用 branch であり、すでに branch 作成が済んでいる前提で進める。
この Skill では issue 作成や branch 作成はしない。

変更がない場合や作業ツリーに未 commit 変更がある場合、main ブランチにいるは実行しない。
その場合、ユーザに中断理由を伝える。

### 2. Identify the source issue

PR に対応する issue を特定する。
優先順は次の通りにする。

1.  ユーザーが明示した issue 番号
2.  branch 名に含まれる issue 番号
3.  GitHub 上の branch / development linkage

issue を特定できない場合だけ、短く確認する。
推測で別 issue を選ばない。

### 3. Read issue metadata

元 issue から次の情報を取得する。

-   issue title と body
-   assignee 一覧
-   label 一覧
-   PR 本文に入れるべき背景や受け入れ条件

issue は PR metadata の一次情報として扱う。
ユーザーが明示的に別指定した assignee や label がある場合だけ、その指定を優先する。

### 4. Draft the PR content

PR title は branch 名の繰り返しではなく、実際の変更内容が分かる短い文にする。
issue の意図とずれていないかを確認する。

PR body には最低限次を入れる。

-   何を変えたか
-   なぜ必要か
-   閉じる issue 参照 (`Closes #<issue-number>`)

本文は簡潔にし、未確認事項や残タスクがある場合は明記する。

### 6. Create the PR and inherit metadata

GitHub integration または `gh` CLI を使って PR を作成する。
base branch はリポジトリ既定の branch を使い、ユーザー指定がある場合だけ変更する。

PR 作成時または直後の更新で、元 issue の assignee と label を PR に反映する。
一部のツールで同時設定できない場合は、PR 作成直後に編集コマンドを追加で実行して必ず合わせる。

issue に assignee や label がない場合は、その事実をそのまま扱う。
存在しない値を補わない。

### 7. Report the outcome

完了時は次を共有する。

-   PR URL
-   採用した issue 番号

そのうえで、 `gh` コマンドを利用して該当 PR をブラウザで開く。

## Practical Rules

-   branch を新しく切り直さない。
-   issue から引き継ぐ assignee と label は、ユーザーの追加指定がない限りそのまま全件コピーする。
-   issue の metadata を PR に反映できなかった場合は、成功したふりをせず不足分を明示する。
-   GitHub への書き込みに必要なツールや認証がない場合は、その時点で不足内容を伝える。
