# 共通GitLab CI

このディレクトリには、再利用可能なPipeline設定を配置します。共通CIは、Jobの制御、実行ルール、Artifactの受け渡し、Runnerの共通設定など「どのように実行するか（HOW）」を担当します。
アプリケーションリポジトリは、ソースコード、テスト、SQL、テストデータ、デプロイ定義、アプリ固有スクリプトなど「何を実行するか（WHAT）」を担当します。

## 取り込み方法

アプリケーションリポジトリから標準Pipelineを取り込むには、実際のGitLabプロジェクトパスと固定したリリースrefを指定します。

```yaml
include:
  - project: "platform/common-cicd"
    ref: v1.0.0
    file: "/common_cicd/50_pipeline_standard.yml"

variables:
  APP_TYPE: springboot
  FRONTEND_TYPE: vue
  BACKEND_BUILD_IMAGE: maven:3.9-eclipse-temurin-21
  BACKEND_TEST_IMAGE: maven:3.9-eclipse-temurin-21
  BACKEND_BUILD_CMD: "cd backend && mvn clean package"
  BACKEND_TEST_CMD: "cd backend && mvn test"
  BACKEND_PACKAGE_PATH: "backend/target/*.jar"
  FRONTEND_BUILD_IMAGE: node:22-alpine
  FRONTEND_TEST_IMAGE: node:22-alpine
  FRONTEND_BUILD_CMD: "cd frontend && npm ci && npm run build"
  FRONTEND_TEST_CMD: "cd frontend && npm ci && npm test"
  FRONTEND_PACKAGE_PATH: "frontend/dist/**/*"
```

`50_pipeline_standard.yml` が、このリポジトリ内の他のテンプレートを読み込みます。
本番利用では、`ref` に更新され続けるブランチを指定せず、リリースタグなど固定されたrefを指定してください。

## アプリケーション側のVariables

- `APP_TYPE`: Backendの種別。例：`springboot`、`tomcat`、`python`。常に設定します。
- `FRONTEND_TYPE`: Frontendの種別。例：`vue`、`react`。Frontendがある場合に設定します。
- `BACKEND_BUILD_IMAGE`／`BACKEND_TEST_IMAGE`: Backend Build／Test用のイメージ。既定値はMaven + Java 21です。
- `BACKEND_BUILD_CMD`／`BACKEND_TEST_CMD`: BackendのBuild／単体テストコマンド。アプリケーションリポジトリのルートから実行します。
- `BACKEND_PACKAGE_PATH`: Backend Build成果物のglob。Build JobのArtifactとして受け渡します。
- `FRONTEND_BUILD_IMAGE`／`FRONTEND_TEST_IMAGE`: Frontend Build／Test用のイメージ。既定値はNode.js 22 Alpineです。
- `FRONTEND_BUILD_CMD`／`FRONTEND_TEST_CMD`: FrontendのBuild／単体テストコマンド。アプリケーションリポジトリのルートから実行します。
- `FRONTEND_PACKAGE_PATH`: Frontend Build成果物のglob。Build JobのArtifactとして受け渡します。
- `VALIDATE_CMD`: 任意のアプリケーション検証コマンド。追加の検証が必要な場合に設定します。
- `START_CMD`: E2E Jobでアプリケーションを起動するコマンド。E2Eを有効にする場合に設定します。
- `HEALTHCHECK_URL`: E2E実行前に確認する任意のローカルURL。起動確認を行う場合に設定します。
- `E2E_IMAGE`: アプリケーション実行環境とE2Eツールを含むイメージ。E2Eを有効にする場合に設定します。
- `E2E_INSTALL_CMD`: E2E依存関係をインストールする任意のコマンド。インストールが必要な場合に設定します。
- `E2E_CMD`: E2Eコマンド。例：`npx playwright test`。E2Eを有効にする場合に設定します。
- `PERFORMANCE_SCENARIO`: アプリ側で管理するk6シナリオのパス。手動性能試験を有効にする場合に設定します。

`SECURITY_CMD`と`SECURITY_IMAGE`は基盤管理者が設定します。GitLab CI/CD VariablesでProtectedに設定してください。共通テンプレートは`master`とタグでセキュリティチェックを実行します。
SecretをYAMLやスクリプトに直接記載しないでください。

## Pipelineの動作

- Merge Request、`feature/*`、`master`、タグを`workflow`で受け付けます。
- 完全一致のタグ名`release`を明示的に受け付け、`master`と同じJob条件で実行します。他のタグも従来どおり受け付けます。
- Validateの後、BackendとFrontendはそれぞれのイメージで並列Buildします。片方だけのアプリケーションでは、存在する側のBuildコマンドだけを設定します。
- 単体テストもBackend／Frontend別Jobで実行します。テストコマンドが未設定のJobは作成されません。
- `master`とタグでは、設定された成果物パスをPackage Stageで検証します。
- `START_CMD`、`E2E_CMD`、`E2E_IMAGE`が設定されている場合にE2Eを実行します。
- GitLabの各Jobは別コンテナで実行されるため、E2E Job内でアプリケーションを起動してテストします。`staging` Stageは、将来、外部ステージング環境を使うWorkflowに備えて残しています。
- 基盤側で`SECURITY_CMD`が設定されている場合、`master`とタグでセキュリティチェックを実行します。
- アプリ側のk6シナリオが設定されている場合、`master`とタグで手動実行可能な性能試験を実行します。失敗してもPipeline全体は失敗しません。
- Build成果物はArtifactとして後続Jobに渡します。Dockerの一括削除・pruneコマンドは使用しません。

Buildコマンドを設定したコンポーネントでは、対応する`*_PACKAGE_PATH`も設定してください。アプリ雛形のコマンドは未設定のため、値を埋めるまではPipelineは成功しません。

## アプリケーション資材の配置先

アプリケーション固有のDDL、DML、マスタデータ、テストデータ、API定義、Playwrightのテスト、k6シナリオ、業務固有スクリプトは、この共通CIリポジトリには配置しないでください。
共通Jobは、利用側プロジェクト内のファイルを対象に、設定されたコマンドを実行します。例えば、`sql/ddl/`、`sql/master/`、`sql/testdata/`、`tests/api/`、`tests/e2e/`、`tests/performance/`、`scripts/`はアプリケーションリポジトリで管理します。
