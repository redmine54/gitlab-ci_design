# GitLab CI/CD 標準設計・テンプレート

GitLab CI/CDを複数のアプリケーションで共通利用するための設計資料と、パイプラインテンプレート／補助スクリプトを管理するプロジェクトです。開発者が個別に `.gitlab-ci.yml` を作り込まず、共通テンプレートとGitLab CI/CD Variablesを使ってパイプラインを運用することを目指します。

## 対象と前提

- 対象アプリケーション: Java Servlet/JSP (Tomcat)、Spring Boot、Node.js、Python
- 将来の拡張候補: WAS Traditional、WAS Liberty
- GitLab: 社内SaaS版
- Runner: Shared Runner、Docker Executor、DooD構成
- ブランチ: `feature/*`、`master`、タグ
- 対象工程: Validate、Build、Unit Test、Package、Staging、E2E、Performance Test、Security Test
- 本番環境へのデプロイは対象外です。Kubernetes/OpenShiftも前提としていません。

## ドキュメント

設計資料は、共通方針から個別設計へ進む順に読むことを想定しています。

| ファイル | 内容 |
| --- | --- |
| [01_GitLab_CICD_Design_Prompt_v1.1.md](01_GitLab_CICD_Design_Prompt_v1.1.md) | 設計の前提条件、対象範囲、命名規則 |
| [02_GitLab_CICD_Standard_Design_v1.1.md](02_GitLab_CICD_Standard_Design_v1.1.md) | 標準ステージ、ブランチ別方針、共通原則 |
| [03_GitLab_CICD_Template_Architecture_v1.0.md](03_GitLab_CICD_Template_Architecture_v1.0.md) | CI/CDテンプレートの構成と責務 |
| [04_GitLab_CICD_Variables_Design_v1.0.md](04_GitLab_CICD_Variables_Design_v1.0.md) | 利用者・管理者・Secret Variablesの設計 |
| [05_GitLab_CICD_Rules_Design_v1.0.md](05_GitLab_CICD_Rules_Design_v1.0.md) | workflow、ブランチ、Job実行条件の設計 |
| [06_GitLab_CICD_Runner_Design_v1.0.md](06_GitLab_CICD_Runner_Design_v1.0.md) | Runner、DooD、キャッシュ、Artifactの設計 |
| [07_GitLab_CICD_E2E_Design_v1.0.md](07_GitLab_CICD_E2E_Design_v1.0.md) | Runner上で行うアプリ起動、Health Check、Playwright E2Eの設計 |
| [50−59比較.md](50%E2%88%9259%E6%AF%94%E8%BC%83.md) | 50番台テンプレートと補助スクリプトの一覧 |
| [scripts_summary.md](scripts_summary.md) | Build／Testスクリプトの概要 |
| [50_pipeline_standard.yml](50_pipeline_standard.yml) | Pipeline標準設定のYAMLファイル |
| [.gitlab-ci/GitLab_CICD_Template_Structure_50-59.md](.gitlab-ci/GitLab_CICD_Template_Structure_50-59.md) | テンプレートとスクリプトの配置設計 |

## ディレクトリ構成

```text
.
├── 01_...md ～ 07_...md       # CI/CD設計資料
├── 50_pipeline_standard.yml   # Pipeline標準設定
├── 50−59比較.md               # テンプレート一覧・比較
├── scripts_summary.md         # スクリプト概要
└── .gitlab-ci/
    ├── includes/              # 共通Pipeline／Stage定義
    ├── scripts/               # Build、Test、起動、E2E、Deploy等のスクリプト
    ├── playwright/            # Playwright設定とE2Eテスト
    └── reports/               # 各種レポート関連
```

`.gitlab-ci/includes/stages/` にはBuild、Test、E2E、Security、Performance、Deploy、Release、Cleanup、Notifyの共通定義を配置します。`.gitlab-ci/scripts/` はアプリケーション種別や処理単位でスクリプトを分けます。

## 標準パイプライン

標準ステージは次の順序です。

```text
validate → build → unit_test → package → staging → e2e → performance → security
```

ブランチ／タグによって実行範囲を変えます。

| 対象 | 主な実行内容 |
| --- | --- |
| `feature/*` | Validate、Build、Unit Test、Staging、E2E |
| `master` | 上記にPackage、Performance Test、Security Testを追加 |
| タグ | リリース候補の検証として、master相当の工程を実行 |

具体的なJob条件は設計書とテンプレート定義を正としてください。

## 利用方法

1. 対象プロジェクトに必要なGitLab CI/CD Variablesを設定します。アプリケーション種別やBuild／Testコマンド、成果物パスなどはVariablesで指定します。
2. 共通テンプレートを利用するプロジェクトでは、`.gitlab-ci.yml` からテンプレートのPipeline定義を `include` します。別プロジェクトから参照する場合は、GitLab上の実際のプロジェクトパスとファイルパスに合わせて `include:project` を設定してください。
3. `APP_TYPE`、`BUILD_CMD`、`TEST_CMD`、`PACKAGE_PATH`、`START_CMD` などをアプリケーションに合わせて設定します。利用可能な変数と必須条件はVariables設計書を確認してください。
4. featureブランチで基本工程を確認し、master／タグで追加のSecurity・Performance工程を確認します。

テンプレートを同じリポジトリ内で試す場合のinclude例:

```yaml
include:
  - local: '.gitlab-ci/includes/50_pipeline_standard.yml'
```

実際に参照するファイルパスは、GitLabに登録したテンプレートの配置に合わせてください。

## セキュリティと運用上の注意

- Token、Password、その他のSecretをYAMLやスクリプトへ直接記載しないでください。
- SecretはGitLab CI/CD Variablesで管理し、用途に応じてProtected／Maskedを設定してください。
- Dockerの一括削除コマンド（`docker system prune`、`docker volume prune`、`docker network prune`、`docker image prune`）はRunner環境で実行しない方針です。
- Build成果物やテストレポートの受け渡しにはArtifactを利用します。
- E2Eテストは実環境ではなくRunner上でアプリケーションを起動して実施します。
- Runnerの利用可能なDocker操作、Artifactの保持期間、Secretの保護条件は利用環境の管理者設定も確認してください。

## ファイル命名

設計資料には `01`～`49`、実装ファイルには `50`～`99` の番号帯を使用する方針です。ファイル追加時は既存番号との重複を避け、一覧資料もあわせて更新してください。
