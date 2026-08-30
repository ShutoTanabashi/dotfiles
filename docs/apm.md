# APM によるエージェント設定の管理

[APM (Agent Package Manager)](https://github.com/microsoft/apm) で、エージェントの
設定とスキルを管理する。

## 管理方針

-   APM 本体は、利用する OS の[パッケージ一覧](../pkg/README.md)または OS 別の
    手順に従って導入する。[Ubuntu](../pkg/ubuntu/README.md)と
    [Windows](../pkg/windows/README.md)の手動導入手順も参照する。
-   依存関係の定義はユーザースコープの `~/.apm/apm.yml` で管理し、chezmoi で
    配備する。`~/.apm/apm.lock.yaml` は APM がローカルに生成する解決結果であり、
    chezmoi では管理しない。
-   スキルの実体は APM が `~/.agents/skills/<skill-name>/` に配備する。ここは
    生成物のため、直接編集も chezmoi による配備も行わない。
-   リポジトリ直下の `.agents/` は、このリポジトリ固有のスキルを Git 管理する
    場所であり、ユーザースコープの `~/.agents/` とは別に扱う。

## 参照

-   [APM のインストール](https://microsoft.github.io/apm/getting-started/installation/)
-   [APM の利用方法](https://microsoft.github.io/apm/consumer/install-packages/)
