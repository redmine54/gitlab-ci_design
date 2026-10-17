# Script 一覧

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Pre | 61 | common_pre.sh | ALL | APP_TYPE, QUALITY_POLICY, ソースコード, pom.xml, package.json, requirements.txt | reports/pre/* | Build前品質検査実行 |
| Common | 68 | common_logging.sh | ALL | ログメッセージ | logs/*.log | 共通ログ出力 |
| Common | 69 | common_report.sh | ALL | reports/* | reports/summary/summary.txt | レポート集約 |
| Common | 70 | common_healthcheck.sh | ALL | HEALTHCHECK_URL, DEPLOY_HEALTHCHECK_URL | reports/healthcheck/healthcheck-summary.txt | HealthCheck |

---

# Build Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Build | 71 | tomcat_build.sh | tomcat | pom.xml, src/main, src/webapp | build-output/*.war | WAR作成 |
| Build | 72 | springboot_build.sh | springboot | pom.xml, src/main | build-output/*.jar | JAR作成 |
| Build | 73 | vue_springboot_build.sh | vue-springboot | frontend/package.json, backend/pom.xml | frontend/dist/, build-output/*.jar | Vue Build + Spring Boot Build |
| Build | 74 | react_springboot_build.sh | react-springboot | frontend/package.json, backend/pom.xml | frontend/dist/, build-output/*.jar | React Build + Spring Boot Build |
| Build | 75 | python_build.sh | python | requirements.txt, pyproject.toml, setup.py | build-output/dist/ | Python Package作成 |
| Build | 76 | was_build.sh | was | pom.xml, EAR/WARソース | build-output/*.ear | EAR作成 |
| Build | 77 | liberty_build.sh | liberty | pom.xml, server.xml | build-output/*.war | WAR作成 |

---

# Test Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Test | 81 | tomcat_test.sh | tomcat | src/test | reports/test/, surefire-reports/ | Unit Test |
| Test | 82 | springboot_test.sh | springboot | src/test | reports/test/, surefire-reports/ | Unit Test |
| Test | 83 | vue_springboot_test.sh | vue-springboot | frontend/tests/, backend/src/test/ | reports/test/, coverage/ | Frontend + Backend Test |
| Test | 84 | react_springboot_test.sh | react-springboot | frontend/tests/, backend/src/test/ | reports/test/, coverage/ | Frontend + Backend Test |
| Test | 85 | python_test.sh | python | tests/ | reports/test/, junit.xml, coverage/ | pytest |
| Test | 86 | was_test.sh | was | src/test | reports/test/ | Unit Test |
| Test | 87 | liberty_test.sh | liberty | src/test | reports/test/ | Unit Test |

---

# Startup Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Startup | 91 | tomcat_start.sh | tomcat | target/*.war | startup.log, app.pid | Tomcat起動 |
| Startup | 92 | springboot_start.sh | springboot | target/*.jar | startup.log, app.pid | Spring Boot起動 |
| Startup | 93 | vue_springboot_start.sh | vue-springboot | backend/target/*.jar | startup.log, app.pid | Spring Boot起動 |
| Startup | 94 | react_springboot_start.sh | react-springboot | backend/target/*.jar | startup.log, app.pid | Spring Boot起動 |
| Startup | 95 | python_start.sh | python | APP_FILE | startup.log, app.pid | Python起動 |
| Startup | 96 | was_start.sh | was | WAS_PROFILE | startup.log | WAS起動 |
| Startup | 97 | liberty_start.sh | liberty | LIBERTY_SERVER_NAME | startup.log | Liberty起動 |

---

# E2E Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| E2E | 101 | run_playwright.sh | ALL | playwright/tests/, HEALTHCHECK_URL | playwright-report/, test-results/, screenshots/, videos/, traces/ | E2E実行 |

---

# Performance Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Performance | 111 | k6_smoke.js | ALL | TARGET_URL | reports/k6/summary.json, reports/k6/result.json | パフォーマンステスト |

---

# Deploy Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Deploy | 121 | tomcat_deploy.sh | tomcat | build-output/*.war | reports/deploy/deploy-summary.txt | Tomcat配置 |
| Deploy | 122 | springboot_deploy.sh | springboot | build-output/*.jar | reports/deploy/deploy-summary.txt | Spring Boot配置 |
| Deploy | 123 | vue_springboot_deploy.sh | vue-springboot | frontend/dist/, build-output/*.jar | reports/deploy/deploy-summary.txt | Vue + Spring Boot配置 |
| Deploy | 124 | react_springboot_deploy.sh | react-springboot | frontend/dist/, build-output/*.jar | reports/deploy/deploy-summary.txt | React + Spring Boot配置 |
| Deploy | 125 | python_deploy.sh | python | build-output/dist/ | reports/deploy/deploy-summary.txt | Python配置 |
| Deploy | 126 | was_deploy.sh | was | build-output/*.ear | reports/deploy/deploy-summary.txt | WAS配置 |
| Deploy | 127 | liberty_deploy.sh | liberty | build-output/*.war | reports/deploy/deploy-summary.txt | Liberty配置 |

---

# Release Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Release | 131 | release_publish.sh | ALL | reports/release/release-notes.md, CI_COMMIT_TAG | reports/release/release-publish.txt, reports/release/release-summary.txt | Release処理 |

---

# Notify Stage

| Stage | No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|---------|----:|---------|---------|---------|---------|---------|
| Notify | 141 | notify_success.sh | ALL | CI_PIPELINE情報 | reports/notify/success-notify.txt | 成功通知 |
| Notify | 142 | notify_failure.sh | ALL | CI_PIPELINE情報 | reports/notify/failure-notify.txt | 失敗通知 |
| Notify | 143 | notify_mail.sh | ALL | reports/notify/* | reports/notify/mail-message.txt | メール通知 |
| Notify | 144 | notify_teams.sh | ALL | reports/notify/* | reports/notify/teams-message.json | Teams通知 |
| Notify | 145 | notify_release.sh | ALL | reports/release/release-summary.txt | reports/notify/release-notify.txt | Release通知 |

---

# Pre Stage 内部処理（common_pre.sh）

| 実行順 | QUALITY_POLICY変数 | 処理 | 出力 |
|---------|---------|---------|---------|
| 1 | PRE_VALIDATE_ENABLED | Validate | reports/pre/validate-summary.txt |
| 2 | PRE_SECRET_SCAN_ENABLED | Secret Scan | reports/pre/secret-summary.txt |
| 3 | PRE_DEPENDENCY_SCAN_ENABLED | Dependency/CVE Scan | reports/pre/dependency-summary.txt |
| 4 | PRE_SBOM_ENABLED | SBOM生成 | reports/pre/sbom.json |
| 5 | PRE_LICENSE_ENABLED | License Check | reports/pre/license-summary.txt |
| 6 | PRE_SAST_ENABLED | SAST | reports/pre/sast-summary.txt |
| 7 | PRE_POLICY_GATE_ENABLED | Policy Gate | reports/pre/policy-gate-summary.txt |
| 8 | - | Summary生成 | reports/pre/pre-summary.txt |
