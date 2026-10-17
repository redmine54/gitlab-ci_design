# CI/CD変数設定値一覧

## System

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| APP_NAME | 任意文字列 | なし | 必須 |
| APP_TYPE | tomcat, springboot, vue-springboot, react-springboot, python, was, liberty | なし | 必須 |
| DEPLOY_ENV | dev, stg, prod | なし | 必須 |
| DEPLOY_TARGET | dev, stg, prod | なし | 必須 |
| HEALTHCHECK_URL | URL | なし | 必須 |
| DEPLOY_HEALTHCHECK_URL | URL | なし | 必須 |
| RELEASE_VERSION | 任意Version | なし | 必須 |

---

# Quality Policy

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| PRE_VALIDATE_ENABLED | true, false | true | Validate実施 |
| PRE_SECRET_SCAN_ENABLED | true, false | true | Secret Scan実施 |
| PRE_DEPENDENCY_SCAN_ENABLED | true, false | true | Dependency/CVE Scan実施 |
| PRE_SBOM_ENABLED | true, false | true | SBOM生成 |
| PRE_LICENSE_ENABLED | true, false | true | License Check実施 |
| PRE_SAST_ENABLED | true, false | true | SAST実施 |
| PRE_POLICY_GATE_ENABLED | true, false | true | Policy Gate実施 |

---

# Quality Rule

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| SECRET_SCAN_FAIL_ON_FOUND | true, false | true | Secret検出時Fail |
| CVE_FAIL_SEVERITY | CRITICAL, HIGH, MEDIUM, LOW | CRITICAL | Fail閾値 |
| LICENSE_DENY_LIST | カンマ区切り | GPL,AGPL | 禁止ライセンス |
| SAST_FAIL_SEVERITY | CRITICAL, HIGH, MEDIUM, LOW | CRITICAL | Fail閾値 |
| POLICY_GATE_FAIL_FAST | true, false | true | 即Fail判定 |
| TEST_COVERAGE_MIN | 0～100 | 0 | Test最低カバレッジ |

---

# Build

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| BUILD_PROFILE | standard, debug, release | standard | Buildプロファイル |
| MAVEN_OPTS | 任意文字列 | -B | Mavenオプション |
| NODE_VERSION | Node.js Version | 22 | Nodeバージョン |
| PYTHON_VERSION | Python Version | 3.12 | Pythonバージョン |

---

# Test

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| UNIT_TEST_ENABLED | true, false | true | Unit Test実施 |
| UNIT_TEST_REQUIRED | true, false | false | Unit Test未作成時Fail |
| E2E_ENABLED | true, false | true | E2E実施 |
| E2E_REQUIRED | true, false | true | E2E未実施時Fail |

---

# Frontend

## vue-springboot

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| FRONTEND_DIR | ディレクトリ名 | frontend | Vue配置先 |
| VITE_MODE | production, development | production | Viteモード |

## react-springboot

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| FRONTEND_DIR | ディレクトリ名 | frontend | React配置先 |
| VITE_MODE | production, development | production | Viteモード |

---

# Backend

## springboot

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| SPRING_PROFILE | dev, stg, prod | prod | Spring Profile |
| DEPLOY_DIR | ディレクトリパス | なし | 必須 |

## vue-springboot

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| BACKEND_DIR | ディレクトリ名 | backend | Spring Boot配置先 |
| SPRING_PROFILE | dev, stg, prod | prod | Spring Profile |
| DEPLOY_DIR | ディレクトリパス | なし | 必須 |

## react-springboot

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| BACKEND_DIR | ディレクトリ名 | backend | Spring Boot配置先 |
| SPRING_PROFILE | dev, stg, prod | prod | Spring Profile |
| DEPLOY_DIR | ディレクトリパス | なし | 必須 |

---

# Tomcat

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| TOMCAT_HOME | ディレクトリパス | なし | 必須 |

---

# Python

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| APP_FILE | Pythonファイル名 | app.py | エントリポイント |
| DEPLOY_DIR | ディレクトリパス | なし | 必須 |

---

# WAS

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| WAS_PROFILE | WAS Profile Path | なし | 必須 |
| WAS_USER | ユーザー名 | なし | 必須 |
| WAS_PASSWORD | パスワード | なし | 必須(Secret) |

---

# Liberty

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| WLP_HOME | ディレクトリパス | なし | 必須 |
| LIBERTY_SERVER_NAME | サーバ名 | defaultServer | Libertyサーバ |

---

# Liberty(OpenShift)

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| OPENSHIFT_PROJECT | Project名 | なし | OpenShift利用時 |
| OPENSHIFT_APP | App名 | なし | OpenShift利用時 |
| OPENSHIFT_TOKEN | Token | なし | Secret |

---

# Security

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| SECURITY_GATE_ENABLED | true, false | true | Security Gate |
| TRIVY_SEVERITY | CRITICAL, HIGH, MEDIUM, LOW | HIGH,CRITICAL | Trivy対象 |

---

# Performance

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| PERFORMANCE_GATE_ENABLED | true, false | true | 性能試験実施 |
| K6_VUS | 数値 | 10 | 仮想ユーザー数 |
| K6_DURATION | 10s,30s,1m,5m等 | 1m | 実行時間 |

---

# Release

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| RELEASE_PUBLISH_COMMAND | 任意コマンド | なし | 追加公開処理 |

---

# Notify

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| NOTIFY_ENABLED | true, false | true | 通知有効化 |
| NOTIFY_MAIL_TO | メールアドレス | なし | 通知先 |
| NOTIFY_TEAMS_WEBHOOK | Webhook URL | なし | Teams通知 |

---

# Cleanup

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| CLEANUP_ENABLED | true, false | true | Cleanup実施 |

---

# SMTP

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| SMTP_HOST | ホスト名 | なし | Secret |
| SMTP_PORT | ポート番号 | 587 | Secret |
| SMTP_USER | ユーザー名 | なし | Secret |
| SMTP_PASSWORD | パスワード | なし | Secret |

---

# Artifact Repository

| 変数名 | 設定可能値 | デフォルト | 備考 |
|----------|----------|----------|----------|
| REGISTRY_URL | URL | なし | Secret |
| REGISTRY_USER | ユーザー名 | なし | Secret |
| REGISTRY_PASSWORD | パスワード | なし | Secret |
| NEXUS_URL | URL | なし | Secret |
| NEXUS_USER | ユーザー名 | なし | Secret |
| NEXUS_PASSWORD | パスワード | なし | Secret |
| ARTIFACTORY_URL | URL | なし | Secret |
| ARTIFACTORY_USER | ユーザー名 | なし | Secret |
| ARTIFACTORY_PASSWORD | パスワード | なし | Secret |
