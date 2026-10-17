# YAML - Script対応表

| Stage | No | YAML | 呼び出しScript | APP_TYPE | 入力データ | 出力データ |
|---------|----:|---------|---------|---------|---------|---------|
| Pre | 40 | 40_stage_pre_common.yml | scripts/common/pre/common_pre.sh | ALL | ソースコード一式 | reports/pre/* |
| Build | 51 | 51_stage_build_common.yml | 71〜77 | APP_TYPE依存 | ソースコード | build-output/* |
| Test | 52 | 52_stage_test_common.yml | 81〜87 | APP_TYPE依存 | Build成果物, テストコード | reports/test/* |
| E2E | 53 | 53_stage_e2e_common.yml | 91〜97, 101 | APP_TYPE依存 | 起動済アプリ, Playwrightコード | playwright-report/* |
| Security | 54 | 54_stage_security_common.yml | 共通Security処理 | ALL | Build成果物, コンテナイメージ | reports/security/* |
| Performance | 55 | 55_stage_performance_common.yml | 111 | ALL | 起動済アプリ | reports/k6/* |
| Deploy | 56 | 56_stage_deploy_common.yml | 121〜127 | APP_TYPE依存 | Build成果物 | reports/deploy/* |
| Release | 57 | 57_stage_release_common.yml | 131 | ALL | Release Notes, Git Tag | reports/release/* |
| Cleanup | 58 | 58_stage_cleanup_common.yml | common_report.sh 等 | ALL | build-output/*, reports/* | cleanup-log.txt |
| Notify | 59 | 59_stage_notify_common.yml | 141〜145 | ALL | CI情報, reports/* | reports/notify/* |

---

# Build Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 71 | tomcat_build.sh | tomcat |
| 72 | springboot_build.sh | springboot |
| 73 | vue_springboot_build.sh | vue-springboot |
| 74 | react_springboot_build.sh | react-springboot |
| 75 | python_build.sh | python |
| 76 | was_build.sh | was |
| 77 | liberty_build.sh | liberty |

---

# Test Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 81 | tomcat_test.sh | tomcat |
| 82 | springboot_test.sh | springboot |
| 83 | vue_springboot_test.sh | vue-springboot |
| 84 | react_springboot_test.sh | react-springboot |
| 85 | python_test.sh | python |
| 86 | was_test.sh | was |
| 87 | liberty_test.sh | liberty |

---

# Startup / E2E Preparation Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 91 | tomcat_start.sh | tomcat |
| 92 | springboot_start.sh | springboot |
| 93 | vue_springboot_start.sh | vue-springboot |
| 94 | react_springboot_start.sh | react-springboot |
| 95 | python_start.sh | python |
| 96 | was_start.sh | was |
| 97 | liberty_start.sh | liberty |
| 101 | run_playwright.sh | ALL |

---

# Performance Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 111 | k6_smoke.js | ALL |

---

# Deploy Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 121 | tomcat_deploy.sh | tomcat |
| 122 | springboot_deploy.sh | springboot |
| 123 | vue_springboot_deploy.sh | vue-springboot |
| 124 | react_springboot_deploy.sh | react-springboot |
| 125 | python_deploy.sh | python |
| 126 | was_deploy.sh | was |
| 127 | liberty_deploy.sh | liberty |

---

# Release Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 131 | release_publish.sh | ALL |

---

# Notify Stage

| No | Script | APP_TYPE |
|----:|---------|---------|
| 141 | notify_success.sh | ALL |
| 142 | notify_failure.sh | ALL |
| 143 | notify_mail.sh | ALL |
| 144 | notify_teams.sh | ALL |
| 145 | notify_release.sh | ALL |

---

# Quality Policy と Pre Stage の対応

| Variable | 実施処理 | 出力 |
|---------|---------|---------|
| PRE_VALIDATE_ENABLED | Validate | reports/pre/validate-summary.txt |
| PRE_SECRET_SCAN_ENABLED | Secret Scan | reports/pre/secret-summary.txt |
| PRE_DEPENDENCY_SCAN_ENABLED | Dependency/CVE Scan | reports/pre/dependency-summary.txt |
| PRE_SBOM_ENABLED | SBOM生成 | reports/pre/sbom.json |
| PRE_LICENSE_ENABLED | License Check | reports/pre/license-summary.txt |
| PRE_SAST_ENABLED | SAST | reports/pre/sast-summary.txt |
| PRE_POLICY_GATE_ENABLED | Policy Gate | reports/pre/policy-gate-summary.txt |
