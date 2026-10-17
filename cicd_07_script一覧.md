# 共通 Script 一覧

| No | Script | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|
| 61 | common_validate.sh | APP_TYPE, ソースコード, pom.xml, package.json, requirements.txt, *.yml, *.yaml, *.sh | reports/validate/validate-summary.txt | Validate共通処理 |
| 62 | common_secret_scan.sh | ソースコード, 設定ファイル, Git管理対象ファイル | reports/secrets/secret-scan.json<br>reports/secrets/secret-summary.txt | Secret Scan共通処理 |
| 63 | common_dependency_scan.sh | pom.xml, package.json, requirements.txt | reports/dependency/dependency-scan.json<br>reports/dependency/dependency-summary.txt | Dependency/CVE Scan |
| 64 | common_sbom.sh | pom.xml, package.json, requirements.txt | reports/sbom/sbom.json<br>reports/sbom/sbom.xml | SBOM生成 |
| 65 | common_license_check.sh | pom.xml, package.json, requirements.txt, reports/sbom/sbom.json | reports/license/license-summary.txt<br>reports/license/license-detail.csv | OSSライセンス確認 |
| 66 | common_sast.sh | ソースコード一式 | reports/sast/sast-report.json<br>reports/sast/sast-summary.txt | 静的解析 |
| 67 | common_policy_gate.sh | reports/validate/*<br>reports/secrets/*<br>reports/dependency/*<br>reports/sbom/*<br>reports/license/*<br>reports/sast/* | reports/gate/policy-gate-summary.txt | 品質ゲート判定 |
| 68 | common_logging.sh | ログメッセージ | logs/*.log | 共通ログ出力 |
| 69 | common_report.sh | reports/* | reports/summary/summary.txt | レポート集約 |
| 70 | common_healthcheck.sh | HEALTHCHECK_URL<br>DEPLOY_HEALTHCHECK_URL | reports/healthcheck/healthcheck-summary.txt | HealthCheck実行 |

---

# Build Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 71 | tomcat_build.sh | tomcat | pom.xml, src/main, src/webapp | build-output/*.war | WAR作成 |
| 72 | springboot_build.sh | springboot | pom.xml, src/main | build-output/*.jar | JAR作成 |
| 73 | vue_springboot_build.sh | vue-springboot | frontend/package.json<br>backend/pom.xml | frontend/dist/<br>build-output/*.jar | Vue Build + Spring Boot Build |
| 74 | react_springboot_build.sh | react-springboot | frontend/package.json<br>backend/pom.xml | frontend/dist/<br>build-output/*.jar | React Build + Spring Boot Build |
| 75 | python_build.sh | python | requirements.txt<br>pyproject.toml<br>setup.py | build-output/dist/ | Python Package作成 |
| 76 | was_build.sh | was | pom.xml<br>EAR/WARソース | build-output/*.ear | EAR作成 |
| 77 | liberty_build.sh | liberty | pom.xml<br>server.xml | build-output/*.war | WAR作成 |

---

# Test Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 81 | tomcat_test.sh | tomcat | src/test | reports/test/<br>surefire-reports/ | Unit Test |
| 82 | springboot_test.sh | springboot | src/test | reports/test/<br>surefire-reports/ | Unit Test |
| 83 | vue_springboot_test.sh | vue-springboot | frontend/tests<br>backend/src/test | reports/test/<br>coverage/ | Front/Back Test |
| 84 | react_springboot_test.sh | react-springboot | frontend/tests<br>backend/src/test | reports/test/<br>coverage/ | Front/Back Test |
| 85 | python_test.sh | python | tests/ | reports/test/<br>junit.xml<br>coverage/ | pytest |
| 86 | was_test.sh | was | src/test | reports/test/ | Unit Test |
| 87 | liberty_test.sh | liberty | src/test | reports/test/ | Unit Test |

---

# Startup Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 91 | tomcat_start.sh | tomcat | target/*.war | startup.log<br>app.pid | Tomcat起動 |
| 92 | springboot_start.sh | springboot | target/*.jar | startup.log<br>app.pid | Spring Boot起動 |
| 93 | vue_springboot_start.sh | vue-springboot | backend/target/*.jar | startup.log<br>app.pid | Spring Boot起動 |
| 94 | react_springboot_start.sh | react-springboot | backend/target/*.jar | startup.log<br>app.pid | Spring Boot起動 |
| 95 | python_start.sh | python | APP_FILE | startup.log<br>app.pid | Python起動 |
| 96 | was_start.sh | was | WAS Profile | startup.log | WAS起動 |
| 97 | liberty_start.sh | liberty | Liberty Server | startup.log | Liberty起動 |

---

# E2E Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 101 | run_playwright.sh | ALL | playwright/tests/<br>HEALTHCHECK_URL | playwright-report/<br>test-results/<br>screenshots/<br>videos/<br>traces/ | E2E実行 |

---

# Performance Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 111 | k6_smoke.js | ALL | TARGET_URL | reports/k6/summary.json<br>reports/k6/result.json | パフォーマンステスト |

---

# Deploy Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 121 | tomcat_deploy.sh | tomcat | build-output/*.war | reports/deploy/deploy-summary.txt | Tomcat配置 |
| 122 | springboot_deploy.sh | springboot | build-output/*.jar | reports/deploy/deploy-summary.txt | Spring Boot配置 |
| 123 | vue_springboot_deploy.sh | vue-springboot | frontend/dist/<br>backend.jar | reports/deploy/deploy-summary.txt | Vue + Spring Boot配置 |
| 124 | react_springboot_deploy.sh | react-springboot | frontend/dist/<br>backend.jar | reports/deploy/deploy-summary.txt | React + Spring Boot配置 |
| 125 | python_deploy.sh | python | build-output/dist/ | reports/deploy/deploy-summary.txt | Python配置 |
| 126 | was_deploy.sh | was | build-output/*.ear | reports/deploy/deploy-summary.txt | WAS配置 |
| 127 | liberty_deploy.sh | liberty | build-output/*.war | reports/deploy/deploy-summary.txt | Liberty配置 |

---

# Release Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 131 | release_publish.sh | ALL | reports/release/release-notes.md<br>CI_COMMIT_TAG | reports/release/release-publish.txt<br>reports/release/release-summary.txt | Release処理 |

---

# Notify Script 一覧

| No | Script | APP_TYPE | 入力データ | 出力データ | 説明 |
|----:|---------|---------|---------|---------|---------|
| 141 | notify_success.sh | ALL | CI_PIPELINE情報 | reports/notify/success-notify.txt | 成功通知 |
| 142 | notify_failure.sh | ALL | CI_PIPELINE情報 | reports/notify/failure-notify.txt | 失敗通知 |
| 143 | notify_mail.sh | ALL | reports/notify/notify-context.txt | reports/notify/mail-message.txt | メール通知 |
| 144 | notify_teams.sh | ALL | reports/notify/notify-context.txt | reports/notify/teams-message.json | Teams通知 |
| 145 | notify_release.sh | ALL | reports/release/release-summary.txt | reports/notify/release-notify.txt | Release通知 |
